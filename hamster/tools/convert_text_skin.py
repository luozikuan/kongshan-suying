from __future__ import annotations

import argparse
import importlib.util
import json
import shutil
import sys
from pathlib import Path
from typing import Any

import yaml


SKILL_CONVERTER = Path(
    r"D:\Codex\.codex\skills\port-yuanshu-hamster-skin\scripts\convert_compiled_skin.py"
)

RETURN_KEY_SCRIPT = """// JavaScript
function getText() {
  const type = $getReturnKeyType();
  switch (type) {
    case 1:
      return "前往";
    case 3:
      return "加入";
    case 4:
      return "前往";
    case 6:
      return "搜索";
    case 7:
      return "发送";
    case 9:
      return "完成";
    default:
      return "换行";
  }
}"""

SHORTCUT_MAP = {
    "#undo": "#撤销",
}

UNSUPPORTED_SHORTCUT_FALLBACK = {
    "#keyboardPerformance": "systemSettings",
    "#toggleEmbeddedInputMode": "systemSettings",
    "#左手模式": "systemSettings",
    "#右手模式": "systemSettings",
}

DOCUMENTED_SHORTCUTS = {
    "#简繁切换",
    "#繁简切换",
    "#中英切换",
    "#行首",
    "#行尾",
    "#次选上屏",
    "#三选上屏",
    "#方案切换",
    "#换行",
    "#Enter",
    "#重输",
    "#上个输入方案",
    "#RimeSwitcher",
    "#symbolKeyboard",
    "#numberKeyboard",
    "#左移",
    "#右移",
    "#剪切",
    "#复制",
    "#粘贴",
    "#selectText",
    "#deleteText",
    "#撤销",
    "#重做",
    "#showPhraseView",
    "#showPasteboardView",
    "#toggleScriptView",
    "#clearSystemPasteboard",
    "#capsLocked",
}

NUMERIC_SYMBOLS = [
    "+",
    "-",
    "*",
    "/",
    "()",
    "%",
    ".",
    "@",
    ",",
    "#",
    ":",
    "_",
    "=",
    "?",
    "￥",
]


def load_skill_converter(converter_path: Path):
    spec = importlib.util.spec_from_file_location("skin_converter", converter_path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Unable to load converter: {converter_path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def iter_nodes(value: Any):
    yield value
    if isinstance(value, dict):
        for child in value.values():
            yield from iter_nodes(child)
    elif isinstance(value, list):
        for child in value:
            yield from iter_nodes(child)


def shortcut_name(action: Any) -> str | None:
    if isinstance(action, dict):
        shortcut = action.get("shortcutCommand")
        return shortcut if isinstance(shortcut, str) else None
    return None


def style_refs(value: Any) -> list[str]:
    if isinstance(value, str):
        return [value]
    if isinstance(value, list):
        return [item for item in value if isinstance(item, str)]
    return []


def position_text_style(
    keyboard: dict[str, Any],
    style_name: str,
    y: float,
) -> None:
    style = keyboard.get(style_name)
    if not isinstance(style, dict) or "text" not in style:
        return
    center = style.setdefault("center", {})
    if not isinstance(center, dict):
        center = {}
        style["center"] = center
    center["x"] = 0.5
    center["y"] = y
    style["fontWeight"] = "medium"


def repair_text_layout(keyboard: dict[str, Any]) -> None:
    """Apply Hamster-specific vertical text alignment to every visible Cell."""
    cell_names = {
        node["Cell"]
        for node in iter_nodes(keyboard.get("keyboardLayout", []))
        if isinstance(node, dict) and isinstance(node.get("Cell"), str)
    }

    for cell_name in cell_names:
        cell = keyboard.get(cell_name)
        if not isinstance(cell, dict):
            continue

        for state_key in (
            "foregroundStyle",
            "uppercasedStateForegroundStyle",
            "capsLockedStateForegroundStyle",
            "preeditStateForegroundStyle",
        ):
            for ref in style_refs(cell.get(state_key)):
                if ref == "enterButtonForegroundStyle":
                    y = 0.82
                elif ref == "spaceButtonSchemaNameForegroundStyle":
                    y = 0.70
                elif "SwipeUpForegroundStyle" in ref or "SwipeDownForegroundStyle" in ref:
                    y = 0.62
                else:
                    style = keyboard.get(ref)
                    text = style.get("text") if isinstance(style, dict) else None
                    is_latin_letter = (
                        isinstance(text, str)
                        and len(text) == 1
                        and text.isascii()
                        and text.isalpha()
                    )
                    y = 0.77 if is_latin_letter else 0.75
                position_text_style(keyboard, ref, y)

        # Key-press bubbles use independent styles. Without a center, Hamster
        # pins their labels to the bubble's top edge.
        for hint_name in style_refs(cell.get("hintStyle")):
            hint = keyboard.get(hint_name)
            if not isinstance(hint, dict):
                continue
            for key, value in hint.items():
                if key == "foregroundStyle" or key.endswith("ForegroundStyle"):
                    for ref in style_refs(value):
                        position_text_style(keyboard, ref, 0.75)

        # Long-press symbol panels use another independent set of text views.
        for hold_name in style_refs(cell.get("holdSymbolsStyle")):
            hold = keyboard.get(hold_name)
            if not isinstance(hold, dict):
                continue
            for ref in style_refs(hold.get("foregroundStyle")):
                position_text_style(keyboard, ref, 0.75)


def repair_numeric_symbol_collections(keyboard: dict[str, Any]) -> None:
    collection_names = [
        name
        for name, value in keyboard.items()
        if isinstance(value, dict)
        and value.get("type") in {"numericSymbols", "categorySymbols"}
    ]
    if not collection_names:
        return

    data_sources = keyboard.setdefault("dataSource", {})
    if not isinstance(data_sources, dict):
        data_sources = {}
        keyboard["dataSource"] = data_sources
    data_sources["numericSymbols"] = list(NUMERIC_SYMBOLS)

    for name in collection_names:
        collection = keyboard[name]
        collection["type"] = "symbols"
        collection["dataSource"] = "numericSymbols"
        collection["cellStyle"] = "numericSymbolsCollectionCellStyle"

    number_style = keyboard.get("oneButtonForegroundStyle", {})
    normal_color = (
        number_style.get("normalColor", "000000")
        if isinstance(number_style, dict)
        else "000000"
    )
    highlight_color = (
        number_style.get("highlightColor", normal_color)
        if isinstance(number_style, dict)
        else normal_color
    )
    keyboard["numericSymbolsCollectionCellStyle"] = {
        "backgroundStyle": "keyboardBackgroundStyle",
        "foregroundStyle": "numericSymbolsCollectionCellForegroundStyle",
    }
    keyboard["numericSymbolsCollectionCellForegroundStyle"] = {
        "center": {"x": 0.5, "y": 0.75},
        "fontSize": 18,
        "fontWeight": "medium",
        "highlightColor": highlight_color,
        "normalColor": normal_color,
    }


def repair_node(value: Any) -> Any:
    if isinstance(value, list):
        return [repair_node(item) for item in value]
    if not isinstance(value, dict):
        if value == "$returnKeyType":
            return RETURN_KEY_SCRIPT
        return value

    if set(value) == {"shortcutCommand"}:
        shortcut = value["shortcutCommand"]
        if shortcut in SHORTCUT_MAP:
            return {"shortcutCommand": SHORTCUT_MAP[shortcut]}
        if shortcut in UNSUPPORTED_SHORTCUT_FALLBACK:
            return UNSUPPORTED_SHORTCUT_FALLBACK[shortcut]

    result: dict[str, Any] = {}
    for key, child in value.items():
        if key == "notification":
            continue
        result[key] = repair_node(child)
    return result


def repair_keyboard(data: dict[str, Any]) -> dict[str, Any]:
    # Hamster's toolbar accepts direct button-style references only. YuanShu's
    # portrait sliding collection is flattened to the five initially visible
    # buttons, with the dismiss button kept at the far right.
    data_sources = data.get("dataSource")
    toolbar_items = (
        data_sources.get("horizontalSymbolsToolbarButtonsDataSource", [])
        if isinstance(data_sources, dict)
        else []
    )
    visible_toolbar_styles: list[str] = []
    for item in toolbar_items[:5]:
        if not isinstance(item, dict):
            continue
        style_name = item.get("styleName")
        action = item.get("action")
        style = data.get(style_name) if isinstance(style_name, str) else None
        if isinstance(style, dict) and action is not None:
            style["action"] = action
            visible_toolbar_styles.append(style_name)

    toolbar = data.get("toolbar")
    if isinstance(toolbar, dict):
        toolbar.pop("backgroundStyle", None)
        if visible_toolbar_styles:
            toolbar["secondaryButtonStyle"] = [
                "toolbarDismissButton",
                *reversed(visible_toolbar_styles),
            ]
        else:
            toolbar["secondaryButtonStyle"] = [
                ref
                for ref in (
                    "toolbarDismissButton",
                    "toolbarClipboardButton",
                    "toolbarPhraseButton",
                    "toolbarScriptButton",
                    "toolbarRimeSwitcherButton",
                    "toolbarKeyboardSymbolicButton",
                )
                if ref in data
            ]

    data.pop("toolbarSlideButtons", None)
    data.pop("toolbarCollectionCellStyle", None)
    data_sources = data.get("dataSource")
    if isinstance(data_sources, dict):
        data_sources.pop("horizontalSymbolsToolbarButtonsDataSource", None)
        if not data_sources:
            data.pop("dataSource", None)

    # YuanShu notifications and `$returnKeyType` are not part of the documented
    # Hamster skin API. Hamster exposes the return-key type through JavaScript.
    for name, item in list(data.items()):
        if isinstance(item, dict) and "notificationType" in item:
            data.pop(name)

    # One-handed mode shortcuts are documented as unavailable in Hamster.
    # Remove those options from hold menus while retaining ordinary glyphs.
    for item in data.values():
        if not isinstance(item, dict):
            continue
        actions = item.get("actions")
        foregrounds = item.get("foregroundStyle")
        if not isinstance(actions, list) or not isinstance(foregrounds, list):
            continue
        if len(actions) != len(foregrounds):
            continue
        kept = [
            (action, foreground)
            for action, foreground in zip(actions, foregrounds)
            if shortcut_name(action) not in {"#左手模式", "#右手模式"}
        ]
        if kept and len(kept) != len(actions):
            item["actions"] = [pair[0] for pair in kept]
            item["foregroundStyle"] = [pair[1] for pair in kept]
            item["selectedIndex"] = min(
                int(item.get("selectedIndex", 0)), len(kept) - 1
            )
        if "symbolWidth" in item:
            item["symbolWidth"] = "0.8em"

    converted = repair_node(data)
    if isinstance(converted.get("spaceButtonSchemaNameForegroundStyle"), dict):
        converted["spaceButtonSchemaNameForegroundStyle"]["text"] = "$inputSchemaName"

    # Hamster text views are horizontally centered but vertically top-aligned.
    # Main legends, compact swipe legends, and key-press bubbles therefore need
    # distinct optical baselines. Medium weight matches the reference better.
    repair_text_layout(converted)
    repair_numeric_symbol_collections(converted)
    return converted


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert a resource-free YuanShu skin to a Hamster staging directory."
    )
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument("--stage", type=Path, required=True)
    parser.add_argument(
        "--converter",
        type=Path,
        default=SKILL_CONVERTER,
        help="Path to convert_compiled_skin.py from the Hamster conversion skill.",
    )
    args = parser.parse_args()

    source_root = args.source_root.resolve()
    stage = args.stage.resolve()
    converter = load_skill_converter(args.converter.resolve())

    if stage.exists():
        shutil.rmtree(stage)
    stage.mkdir(parents=True)

    source_config = converter.yaml_load(source_root / "config.yaml")
    config: dict[str, Any] = {
        "name": "空山素影·仓·数字键修正版",
        "author": "luozikuan（原作）/ Codex（Hamster 适配）",
    }
    config.update(source_config)
    converter.yaml_dump(stage / "config.yaml", config)

    demo = source_root / "demo.png"
    if demo.is_file():
        shutil.copy2(demo, stage / "demo.png")

    converted_files: list[str] = []
    errors: list[str] = []
    # `styleName` is valid for collection data-source entries in Hamster. The
    # shared converter marks it unsupported because it normally sees this key
    # only in YuanShu conditional-style arrays.
    forbidden = set(converter.UNSUPPORTED_KEYS) - {"styleName"}

    for mode in ("light", "dark"):
        source_mode = source_root / mode
        destination_mode = stage / mode
        destination_mode.mkdir(parents=True)
        (destination_mode / "resources").mkdir()
        for source_yaml in sorted(source_mode.glob("*.yaml")):
            destination = destination_mode / source_yaml.name
            converted = converter.transform_keyboard(source_yaml, destination)
            converted = repair_keyboard(converted)
            converter.yaml_dump(destination, converted)
            converted_files.append(f"{mode}/{source_yaml.name}")

            found: set[str] = set()
            for node in iter_nodes(converted):
                if isinstance(node, dict):
                    found.update(forbidden.intersection(node.keys()))
                    for key, value in node.items():
                        if (
                            "color" in key.lower()
                            and isinstance(value, str)
                            and value.startswith("#")
                        ):
                            errors.append(
                                f"{mode}/{source_yaml.name}: color starts with #: {key}"
                            )
            if found:
                errors.append(
                    f"{mode}/{source_yaml.name}: unsupported keys {sorted(found)}"
                )
            for node in iter_nodes(converted):
                if not isinstance(node, dict):
                    continue
                shortcut = node.get("shortcutCommand")
                if isinstance(shortcut, str) and shortcut not in DOCUMENTED_SHORTCUTS:
                    errors.append(
                        f"{mode}/{source_yaml.name}: undocumented shortcut {shortcut}"
                    )
                if "notificationType" in node or "notification" in node:
                    errors.append(
                        f"{mode}/{source_yaml.name}: YuanShu notification remains"
                    )
                if node.get("text") == "$returnKeyType":
                    errors.append(
                        f"{mode}/{source_yaml.name}: raw return-key variable remains"
                    )
                if "styleName" in node:
                    errors.append(
                        f"{mode}/{source_yaml.name}: unsupported styleName remains"
                    )
                if node.get("type") == "horizontalSymbols":
                    errors.append(
                        f"{mode}/{source_yaml.name}: unsupported toolbar collection remains"
                    )
                if node.get("type") in {"numericSymbols", "categorySymbols"}:
                    errors.append(
                        f"{mode}/{source_yaml.name}: YuanShu numeric collection remains"
                    )

            toolbar = converted.get("toolbar")
            if isinstance(toolbar, dict):
                secondary = toolbar.get("secondaryButtonStyle")
                if not isinstance(secondary, list) or not 1 <= len(secondary) <= 7:
                    errors.append(
                        f"{mode}/{source_yaml.name}: invalid toolbar secondary buttons"
                    )
                toolbar_refs = [
                    toolbar.get("primaryButtonStyle"),
                    *(secondary if isinstance(secondary, list) else []),
                    toolbar.get("horizontalCandidateStyle"),
                    toolbar.get("verticalCandidateStyle"),
                    toolbar.get("candidateContextMenu"),
                ]
                for ref in toolbar_refs:
                    if isinstance(ref, str) and ref and ref not in converted:
                        errors.append(
                            f"{mode}/{source_yaml.name}: missing toolbar style {ref}"
                        )

            for node in iter_nodes(converted.get("keyboardLayout", [])):
                if isinstance(node, dict) and isinstance(node.get("Cell"), str):
                    ref = node["Cell"]
                    if ref and ref not in converted:
                        errors.append(
                            f"{mode}/{source_yaml.name}: missing Cell reference {ref}"
                        )

            data_sources = converted.get("dataSource", {})
            for node in iter_nodes(converted):
                if not isinstance(node, dict):
                    continue
                source_ref = node.get("dataSource")
                if (
                    isinstance(source_ref, str)
                    and (
                        not isinstance(data_sources, dict)
                        or source_ref not in data_sources
                    )
                ):
                    errors.append(
                        f"{mode}/{source_yaml.name}: missing dataSource {source_ref}"
                    )
                hold_ref = node.get("holdSymbolsStyle")
                if isinstance(hold_ref, str):
                    hold = converted.get(hold_ref)
                    if not isinstance(hold, dict):
                        errors.append(
                            f"{mode}/{source_yaml.name}: missing hold style {hold_ref}"
                        )
                    elif len(hold.get("foregroundStyle", [])) != len(
                        hold.get("actions", [])
                    ):
                        errors.append(
                            f"{mode}/{source_yaml.name}: hold style length mismatch {hold_ref}"
                        )

            for name, style in converted.items():
                if not isinstance(style, dict):
                    continue
                if (
                    "Hint" not in name
                    and (
                        name.endswith("ButtonSwipeUpForegroundStyle")
                        or name.endswith("ButtonSwipeDownForegroundStyle")
                    )
                    and isinstance(style.get("text"), str)
                ):
                    center = style.get("center", {})
                    if (
                        not isinstance(center, dict)
                        or center.get("y") != 0.62
                        or style.get("fontWeight") != "medium"
                    ):
                        errors.append(
                            f"{mode}/{source_yaml.name}: misplaced swipe hint {name}"
                        )
            enter_style = converted.get("enterButtonForegroundStyle")
            if isinstance(enter_style, dict):
                center = enter_style.get("center", {})
                if (
                    not isinstance(center, dict)
                    or center.get("y") != 0.82
                    or enter_style.get("fontWeight") != "medium"
                ):
                    errors.append(
                        f"{mode}/{source_yaml.name}: return label is not centered"
                    )

            if "numericSymbolsCollection" in converted:
                collection = converted.get("numericSymbolsCollection", {})
                data_sources = converted.get("dataSource", {})
                if (
                    not isinstance(collection, dict)
                    or collection.get("type") != "symbols"
                    or collection.get("dataSource") != "numericSymbols"
                    or collection.get("cellStyle")
                    != "numericSymbolsCollectionCellStyle"
                ):
                    errors.append(
                        f"{mode}/{source_yaml.name}: invalid numeric symbol collection"
                    )
                if (
                    not isinstance(data_sources, dict)
                    or data_sources.get("numericSymbols") != NUMERIC_SYMBOLS
                ):
                    errors.append(
                        f"{mode}/{source_yaml.name}: numeric symbol data is missing"
                    )

    for keyboard_type, targets in source_config.items():
        if not isinstance(targets, dict):
            continue
        for device in targets.values():
            if not isinstance(device, dict):
                continue
            for filename in device.values():
                for mode in ("light", "dark"):
                    expected = stage / mode / f"{filename}.yaml"
                    if not expected.is_file():
                        errors.append(f"missing keyboard: {mode}/{filename}.yaml")

    for required_keyboard in ("pinyin", "numeric", "symbolic"):
        if required_keyboard not in source_config:
            errors.append(f"config.yaml: missing required keyboard {required_keyboard}")

    for mode in ("light", "dark"):
        if not (stage / mode / "resources").is_dir():
            errors.append(f"missing required directory: {mode}/resources")

    for yaml_file in sorted(stage.rglob("*.yaml")):
        yaml.safe_load(yaml_file.read_text(encoding="utf-8"))

    readme = (
        "# 空山素影·仓\n\n"
        "基于 luozikuan/kongshan-suying v9.1 适配 Hamster（仓输入法）。\n\n"
        "- 保留原作的轻量原生风格、深浅色模式和横竖屏布局。\n"
        "- 已转换工具栏、候选栏、长按符号、动作、颜色和集合数据源字段。\n"
        "- 按官方 Hamster 皮肤文档补齐分类符号键盘，并改用直接工具栏按钮。\n"
        "- 回车键标题使用 `$getReturnKeyType()` JavaScript 动态生成。\n"
        "- 原项目不含自定义图片或字体资源，本适配沿用系统字体与 SF Symbols。\n"
        "- Jsonnet 源码未打包，避免 Hamster 将开发文件识别为皮肤资源。\n"
    )
    (stage / "README.md").write_text(readme, encoding="utf-8", newline="\n")

    report = {
        "ok": not errors,
        "errors": errors,
        "keyboardYamlFiles": len(converted_files),
        "convertedFiles": converted_files,
        "yamlFilesParsed": len(list(stage.rglob("*.yaml"))),
        "demoIncluded": (stage / "demo.png").is_file(),
        "resourceFree": not any(
            isinstance(node, dict) and "file" in node and "image" in node
            for yaml_file in stage.rglob("*.yaml")
            for node in iter_nodes(yaml.safe_load(yaml_file.read_text(encoding="utf-8")))
        ),
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))
    if errors:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
