# 空山素影 · 仓输入法适配

本目录提供基于空山素影 v9.1 的仓输入法（Hamster）皮肤适配成品和生成脚本。

## 文件

- `releases/Kongshan-Suying-Hamster-Numeric-v5.hskin`：可直接导入仓输入法的皮肤包。
- `tools/convert_text_skin.py`：将编译后的元书皮肤 YAML 转为仓皮肤 staging 目录的脚本。

此版本修正了键帽主字符、辅助字符、按键提示和长按面板的垂直对齐，并使用 `medium` 字重；数字键盘左侧的元书专用 `numericSymbols` 已改为仓支持的 `symbols` 集合，横竖屏及明暗模式均包含显式符号数据源。

## 源码改动

- `jsonnet/Settings.libsonnet`：启用分类符号键盘布局。
- `jsonnet/Styles/BasicStyle.libsonnet`：将 Jsonnet 的负索引字符串切片替换为 `std.substr`，以兼容用于本次构建的 Jsonnet 实现。

## 重新生成

先按项目原有方式编译 Jsonnet，得到包含 `config.yaml`、`light/` 与 `dark/` 的目录；然后运行：

```powershell
python hamster/tools/convert_text_skin.py `
  --source-root <compiled-skin-directory> `
  --stage <hamster-stage-directory> `
  --converter <path-to-convert_compiled_skin.py>
```

最后使用仓皮肤转换工具中的 `package_wrapped_hskin.py` 对 staging 目录封包。导入时请优先停用旧版本，避免仓继续读取缓存皮肤。
