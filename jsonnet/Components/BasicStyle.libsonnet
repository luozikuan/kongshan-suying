local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local keyboardParams = import '../Constants/Keyboard.libsonnet';
local settings = import '../Settings.libsonnet';
local utils = import 'Utils.libsonnet';

local buttonCornerRadius = 8.5;

local swipeTextCenter = {
  up: { x: 0.28, y: 0.28 },
  down: { x: 0.72, y: 0.28 },
};

local getKeyboardActionText(params={}, key='action', isUppercase=false) =
  if std.objectHas(params, 'text') then
    { text: params.text }
  else if std.objectHas(params, key) then
    local action = params[key];
    if std.type(action) == 'object' then
      if std.objectHas(action, 'character') then
        local text = if isUppercase then std.asciiUpper(action.character) else action.character;
        { text: text }
      else if std.objectHas(action, 'symbol') then
        local text = if isUppercase then std.asciiUpper(action.symbol) else action.symbol;
        { text: text }
      else
        {}
    else
      {}
  else
    {};

// 通用键盘背景样式
local keyboardBackgroundStyleName = 'keyboardBackgroundStyle';
local newKeyboardBackgroundStyle(isDark=false, params={}) = {
  [keyboardBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.keyboardBackgroundColor,
  } + params, isDark),
};

// 浮动键盘按钮背景样式
local floatingKeyboardButtonBackgroundStyleName = 'floatingKeyboardButtonBackgroundStyle';
local newFloatingKeyboardButtonBackgroundStyle(isDark=false, params={}) = {
  [floatingKeyboardButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.floatingKeyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.standardButtonBackgroundColor,
    highlightColor: colors.standardButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 字母键按键动画名称
local buttonAnimationName = 'scaleAnimation';
local newButtonAnimation() = {
  [buttonAnimationName]: {
    animationType: 'scale',
    isAutoReverse: true,
    scale: 0.87,
    pressDuration: 60,
    releaseDuration: 80,
  },
};

// 字母键按钮背景样式
local alphabeticButtonBackgroundStyleName = 'alphabeticButtonBackgroundStyle';
local newAlphabeticButtonBackgroundStyle(isDark=false, params={}) = {
  [alphabeticButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.standardButtonBackgroundColor,
    highlightColor: colors.standardButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 字母键按钮前景样式
local newAlphabeticButtonForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    } + params, isDark)
  else if std.objectHas(params, 'assetImageName') then
    utils.newAssetImageStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

// 字母键按钮上下划提示前景样式
local newAlphabeticButtonAlternativeForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

// 生成上下划提示前景名称
local generateSwipeForegroundStyleName(name, direction='Up', suffix='') =
  assert direction == 'Up' || direction == 'Down' : 'direction 必须是 Up 或 Down';
  name + suffix + 'Swipe' + direction + 'ForegroundStyle';

local generateSwipeForegroundStyleNames(name, params={}, suffix='', followSetting=false) =
  local swipeUpStyleName = if std.objectHas(params, 'swipeUp') && (!followSetting || settings.showSwipeUpText) then [generateSwipeForegroundStyleName(name, 'Up', suffix)] else [];
  local swipeDownStyleName = if std.objectHas(params, 'swipeDown') && (!followSetting || settings.showSwipeDownText) then [generateSwipeForegroundStyleName(name, 'Down', suffix)] else [];
  swipeUpStyleName + swipeDownStyleName;

// 大写字母键按钮前景样式
local newAlphabeticButtonUppercaseForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.standardButtonForegroundColor,
    highlightColor: colors.standardButtonHighlightedForegroundColor,
    fontSize: fonts.standardButtonUppercasedTextFontSize,
  } + params, isDark);

// 字母提示背景样式
local alphabeticHintBackgroundStyleName = 'alphabeticHintBackgroundStyle';
local newAlphabeticHintBackgroundStyle(isDark=false, params={}) = {
  [alphabeticHintBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutBackgroundColor,
    borderColor: colors.standardCalloutBorderColor,
    borderSize: 0.5,
  } + params, isDark),
};

// 字母提示前景样式
local newAlphabeticButtonHintStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.standardCalloutForegroundColor,
    fontSize: fonts.hintTextFontSize,
  } + params, isDark);

// 长按背景样式
local longPressSymbolsBackgroundStyleName = 'longPressSymbolsBackgroundStyle';
local newLongPressSymbolsBackgroundStyle(isDark=false, params={}) = {
  [longPressSymbolsBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutBackgroundColor,
    highlightColor: colors.standardCalloutSelectedBackgroundColor,
    cornerRadius: 10,
    borderColor: colors.standardCalloutBorderColor,
    borderSize: 0.5,
    shadowRadius: 24,
    shadowOffset: { x: 0, y: 0 },
    normalShadowColor: '#000000',
    highlightShadowColor: '#000000',
  } + params, isDark),
};

// 长按前景样式
local newLongPressSymbolsForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

// 长按高亮背景样式
local longPressSymbolsSelectedBackgroundStyleName = 'longPressSymbolsSelectedBackgroundStyle';
local newLongPressSymbolsSelectedBackgroundStyle(isDark=false, params={}) = {
  [longPressSymbolsSelectedBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutSelectedBackgroundColor,
    highlightColor: colors.standardCalloutSelectedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 系统功能键按钮背景样式
local systemButtonBackgroundStyleName = 'systemButtonBackgroundStyle';
local newSystemButtonBackgroundStyle(isDark=false, params={}) = {
  [systemButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.systemButtonBackgroundColor,
    highlightColor: colors.systemButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 文本文字系统功能键按钮前景样式
local newTextSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + getKeyboardActionText(params);

local newImageSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newSystemImageStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonImageFontSize,
  } + params, isDark);

local newAssetImageSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newAssetImageStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonImageFontSize,
  } + params, isDark);

// 系统键按钮前景样式
local newSystemButtonForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    newImageSystemButtonForegroundStyle(isDark, params)
  else if std.objectHas(params, 'assetImageName') then
    newAssetImageSystemButtonForegroundStyle(isDark, params)
  else
    newTextSystemButtonForegroundStyle(isDark, params) + getKeyboardActionText(params);

local spaceButtonForegroundStyleName = 'spaceButtonForegroundStyle';

local spaceButtonRimeSchemaForegroundStyleName = 'spaceButtonRimeSchemaForegroundStyle';
local newSpaceButtonRimeSchemaForegroundStyle(isDark=false) =
  if settings.spaceButtonShowSchema then
  {
    [spaceButtonRimeSchemaForegroundStyleName]: utils.newTextStyle({
      text: '$rimeSchemaName',
      fontSize: fonts.alternativeTextFontSize,
      center: settings.spaceButtonSchemaNameCenter,
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
    }, isDark),
  }
  else
  {};

local spaceButtonForegroundStyle = [
  spaceButtonForegroundStyleName,
]
+ (
  if settings.spaceButtonShowSchema then
    [
      spaceButtonRimeSchemaForegroundStyleName,
    ]
  else []
  );

// 彩色功能键按钮背景样式
local colorButtonBackgroundStyleName = 'colorButtonBackgroundStyle';
local newColorButtonBackgroundStyle(isDark=false, params={}) = {
  [colorButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.colorButtonBackgroundColor,
    highlightColor: colors.colorButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

local colorButtonForegroundStyleName = 'colorButtonForegroundStyle';
local newColorButtonForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.colorButtonForegroundColor,
      highlightColor: colors.colorButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.colorButtonForegroundColor,
      highlightColor: colors.colorButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

local newFloatingKeyboardButton(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=floatingKeyboardButtonBackgroundStyleName)
            +
            {
              foregroundStyle: [
                name + 'ForegroundStyleSystemImage',
                name + 'ForegroundStyleText',
              ],
            }
            + utils.extractProperties(
              params,
              [
                'size',
                'action',
              ]
            ),
    [name + 'ForegroundStyleSystemImage']: utils.newSystemImageStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.floatingKeyboardButtonImageFontSize,
      center: { y: 0.4 }
    } + params, isDark),
    [name + 'ForegroundStyleText']: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.floatingKeyboardButtonTextFontSize,
      center: { y: 0.7 }
    } + params, isDark),
  };

local newToolbarButtonForegroundStyle(isDark=false, params={}) =
  local preferIcon = settings.toolbarPreferIcon;
  if preferIcon && (std.objectHas(params, 'systemImageName') || std.objectHas(params, 'assetImageName')) then
    utils.newSystemImageStyle({
    normalColor: colors.toolbarButtonForegroundColor,
    highlightColor: colors.toolbarButtonHighlightedForegroundColor,
    fontSize: fonts.toolbarButtonImageFontSize,
  } + params, isDark)
  else if std.objectHas(params, 'text') || std.objectHas(params, 'action') then
    utils.newTextStyle({
    normalColor: colors.toolbarButtonForegroundColor,
    highlightColor: colors.toolbarButtonHighlightedForegroundColor,
    fontSize: fonts.toolbarButtonTextFontSize,
  } + params, isDark) + getKeyboardActionText(params)
  else
    assert false : 'toolbar button 必须指定 systemImageName、assetImageName、text 或 action 中的一个';
    {};

local toolbarSlideButtonsName = 'toolbarSlideButtons';
local newToolbarSlideButtons(buttons, slideButtonsMaxCount, isDark=false) =
  local rightToLeft = std.length(buttons) < slideButtonsMaxCount;
  {
    [toolbarSlideButtonsName]: {
      type: 'horizontalSymbols',
      size: { width: '%d/%d' % [slideButtonsMaxCount, slideButtonsMaxCount + 2] },
      maxColumns: slideButtonsMaxCount,
      contentRightToLeft: rightToLeft,
      insets: { left: 3, right: 3 },
      // backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsToolbarButtonsDataSource',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarCollectionCellStyle',
    },
    horizontalSymbolsToolbarButtonsDataSource:
      local adjustOrderButtons = if rightToLeft then std.reverse(buttons) else buttons;
      [
        {
          label: button.name,
          action: button.params.action,
          styleName: button.name + 'Style',
        } for button in adjustOrderButtons
      ],
    toolbarCollectionCellStyle: utils.newBackgroundStyle(style=keyboardBackgroundStyleName)
      + utils.newForegroundStyle(style=keyboardBackgroundStyleName),
  } +
  std.foldl(
    function(acc, button) acc + {
      [button.name + 'Style']: utils.newForegroundStyle(style=button.name + 'ForegroundStyle'),
      [button.name + 'ForegroundStyle']: newToolbarButtonForegroundStyle(isDark, button.params),
    },
    buttons,
    {}
  );

// 例如：replaceGivenPairs(['a', 'b', 'c'], {'a': 'x', 'b':'y'}) 返回 ['x', 'y', 'c']
local replaceGivenPairs(arr, oldToNewPairs) =
  if std.length(std.objectFields(oldToNewPairs)) == 0 then
    arr
  else
    [std.get(oldToNewPairs, item, item) for item in arr];

local newButton(name, type='alphabetic', isDark=false, params={}) =
{
  assert type == 'alphabetic' || type == 'system' || type == 'color' : 'type 可选值： alphabetic, system, color',
  local root = self,
  name: name,
  type: type, // type 可选值： alphabetic, system, color
  isDark: isDark,
  params: params,

  [name]: {}, // 保存按钮相关信息
  reference: {},   // 按钮内的相关引用定义
  globalNames: [], // 引用全局名称列表

  AddBackgroundStyle(): root {
    [root.name]+: { backgroundStyle: type + 'ButtonBackgroundStyle' },
  },

  AddForegroundStyle(newButtonForegroundStyle): root {
    [root.name]+: {
      foregroundStyle: [root.name + 'ForegroundStyle'],
    },
    reference+: {
      [root.name + 'ForegroundStyle']: newButtonForegroundStyle(root.isDark, root.params),
    },
  },

  AddHintStyle(needHint):
    assert type == 'alphabetic' : '只有字母键才支持提示样式';
  if !needHint then
    root
  else
  root {
    [root.name]+: {
      hintStyle: root.name + 'HintStyle',
    },
    reference+: {
      [root.name + 'HintStyle']: (
            if std.objectHas(root.params, 'hintStyle') then
              root.params.hintStyle
            else
              {}
          )
          + utils.newBackgroundStyle(style=alphabeticHintBackgroundStyleName)
          + utils.newForegroundStyle(style=root.name + 'HintForegroundStyle'),
      [root.name + 'HintForegroundStyle']: newAlphabeticButtonHintStyle(root.isDark, utils.excludeProperties(root.params, ['center'])) + getKeyboardActionText(root.params),
    },
  },

  AddPropertiesInParams(): root {
    [root.name]+: utils.extractProperties(
      root.params,
      [
        'size',
        'bounds',
        'action',
        'repeatAction',
      ]
    ),
  },

  AddSwipeUp(showSwipeText):
  local hasSwipeUpParams = std.objectHas(root.params, 'swipeUp');
  local swipeUpParams = if hasSwipeUpParams then root.params.swipeUp else {};
  root {
    [root.name]+: {
        [if hasSwipeUpParams then 'swipeUpAction']: swipeUpParams.action,
        [if hasSwipeUpParams && showSwipeText then 'foregroundStyle']+: [generateSwipeForegroundStyleName(root.name, 'Up')],
      },
    reference+: {
        [if hasSwipeUpParams && showSwipeText then generateSwipeForegroundStyleName(root.name, 'Up')]:
          newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.up } + swipeUpParams),
      }
      + (if std.objectHas(root[root.name], 'hintStyle') then {
          [root.name + 'HintStyle']+: {
            swipeUpForegroundStyle: root.name + 'SwipeUpHintForegroundStyle',
          },
          [root.name + 'SwipeUpHintForegroundStyle']: newAlphabeticButtonHintStyle(root.isDark, swipeUpParams) + getKeyboardActionText(swipeUpParams),
        } else {}
      ),
  },

  AddSwipeDown(showSwipeText):
  local hasSwipeDownParams = std.objectHas(root.params, 'swipeDown');
  local swipeDownParams = if hasSwipeDownParams then root.params.swipeDown else {};
  root {
    [root.name]+: {
        [if hasSwipeDownParams then 'swipeDownAction']: swipeDownParams.action,
        [if hasSwipeDownParams && showSwipeText then 'foregroundStyle']+: [generateSwipeForegroundStyleName(root.name, 'Down')],
      },
    reference+: {
        [if hasSwipeDownParams && showSwipeText then generateSwipeForegroundStyleName(root.name, 'Down')]:
          newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.down } + swipeDownParams),
      }
      + (if std.objectHas(root[root.name], 'hintStyle') then {
          [root.name + 'HintStyle']+: {
            swipeDownForegroundStyle: root.name + 'SwipeDownHintForegroundStyle',
          },
          [root.name + 'SwipeDownHintForegroundStyle']: newAlphabeticButtonHintStyle(root.isDark, swipeDownParams) + getKeyboardActionText(swipeDownParams),
        } else {}
      ),
  },

  AddUppercasedState(newButtonUppercasedForegroundStyle):
    local hasUppercasedParams = std.objectHas(root.params, 'uppercased');
    local uppercasedParams = if hasUppercasedParams then root.params.uppercased else {};
    if !hasUppercasedParams then
      root
    else
      root {
        [root.name]+:
        local oldForegroundStyle = root[root.name].foregroundStyle;
        local uppercasedForeground = replaceGivenPairs(
          oldForegroundStyle,
          {
            [root.name + 'ForegroundStyle']: root.name + 'UppercasedForegroundStyle',
          });
        {
          [if std.objectHas(uppercasedParams, 'action') then 'uppercasedStateAction']: uppercasedParams.action,
        } + utils.newForegroundStyle('uppercasedStateForegroundStyle', uppercasedForeground),
        reference+: {
          [root.name + 'UppercasedForegroundStyle']: newButtonUppercasedForegroundStyle(root.isDark, root.params + uppercasedParams) + getKeyboardActionText(uppercasedParams),
        },
      },

  AddCapsLockedState(newButtonCapsLockedForegroundStyle):
    local hasCapsLockedParams = std.objectHas(root.params, 'capsLocked');
    local capsLockedParams = if hasCapsLockedParams then root.params.capsLocked else {};
    if !hasCapsLockedParams then
      root
    else
      root {
        [root.name]+: {
          capsLockedStateForegroundStyle: root.name + 'CapsLockedForegroundStyle',
        },
        reference+: {
          [root.name + 'CapsLockedForegroundStyle']: newButtonCapsLockedForegroundStyle(root.isDark, capsLockedParams),
        },
      },

  AddLongPress():
    local hasLongPressParams = std.objectHas(root.params, 'longPress');
    local longPressParams = if hasLongPressParams then root.params.longPress else {};
    if !hasLongPressParams then
      root
    else
      root {
        [root.name]+: {
          hintSymbolsStyle: root.name + 'LongPressSymbolsStyle',
        },
        reference+: {
          [root.name + 'LongPressSymbolsStyle']:
            local findSelectedIndex =
              local findIndex(arr, idx) =
              if idx >= std.length(arr) then
                0 // 默认选中第一个
              else if std.objectHas(arr[idx], 'selected') && arr[idx].selected == true then
                idx
              else
                findIndex(arr, idx + 1);
            findIndex(longPressParams, 0);
           {
            size: { width: self.height, height: keyboardParams.toolbar.height },
            insets: {
              left: 3,
              right: 3,
              top: 3,
              bottom: 3,
            },
            symbolStyles: [
              root.name + 'LongPressSymbol'+i+'Style' for i in std.range(0, std.length(longPressParams) - 1)
            ],
            selectedIndex: findSelectedIndex,
           }
          + utils.newBackgroundStyle(style=longPressSymbolsBackgroundStyleName)
          + utils.newBackgroundStyle('selectedBackgroundStyle', style=longPressSymbolsSelectedBackgroundStyleName)
        } + {
          [root.name + 'LongPressSymbol'+i+'Style']: {
            action: longPressParams[i].action,
          }
          + utils.newForegroundStyle(style=root.name + 'LongPressSymbol'+i+'ForegroundStyle'),
            for i in std.range(0, std.length(longPressParams) - 1)
        } + {
          [root.name + 'LongPressSymbol'+i+'ForegroundStyle']:
            newLongPressSymbolsForegroundStyle(root.isDark, longPressParams[i]),
            for i in std.range(0, std.length(longPressParams) - 1)
        },
      },

  AddAnimation(): root {
    [root.name]+: utils.newAnimation(animation=[buttonAnimationName]),
    globalNames+: [buttonAnimationName],
  },

  AddAsciiModeChangeEvent():
    local isAsciiModeAware = std.objectHas(root.params, 'whenAsciiModeOn') || std.objectHas(root.params, 'whenAsciiModeOff');
    local hasAsciiModeOnParams = std.objectHas(root.params, 'whenAsciiModeOn');
    local hasAsciiModeOffParams = std.objectHas(root.params, 'whenAsciiModeOff');
    local asciiModeOnParams = if hasAsciiModeOnParams then root.params.whenAsciiModeOn else {};
    local asciiModeOffParams = if hasAsciiModeOffParams then root.params.whenAsciiModeOff else {};
    if !isAsciiModeAware then
      root
    else
      local oldForegroundStyle = root[root.name].foregroundStyle;
      local asciiModeOnForeground = replaceGivenPairs(
        oldForegroundStyle,
        {
          [if asciiModeOnParams != {} then root.name + 'ForegroundStyle']: utils.asciiModeForegroundStyleName(root.name, true),
          [if std.objectHas(asciiModeOnParams, 'swipeUp') then generateSwipeForegroundStyleName(root.name, 'Up')]: generateSwipeForegroundStyleName(root.name, 'Up', 'AsciiModeOn'),
          [if std.objectHas(asciiModeOnParams, 'swipeDown') then generateSwipeForegroundStyleName(root.name, 'Down')]: generateSwipeForegroundStyleName(root.name, 'Down', 'AsciiModeOn'),
        }
      );
      local asciiModeOffForeground = replaceGivenPairs(
        oldForegroundStyle,
        {
          [if asciiModeOffParams != {} then root.name + 'ForegroundStyle']: utils.asciiModeForegroundStyleName(root.name, false),
          [if std.objectHas(asciiModeOffParams, 'swipeUp') then generateSwipeForegroundStyleName(root.name, 'Up')]: generateSwipeForegroundStyleName(root.name, 'Up', 'AsciiModeOff'),
          [if std.objectHas(asciiModeOffParams, 'swipeDown') then generateSwipeForegroundStyleName(root.name, 'Down')]: generateSwipeForegroundStyleName(root.name, 'Down', 'AsciiModeOff'),
        }
      );
      root {
        [root.name]+: {
          foregroundStyle: [
            {
              styleName: asciiModeOnForeground,
              conditionKey: 'rime$ascii_mode',
              conditionValue: true,
            },
            {
              styleName: asciiModeOffForeground,
              conditionKey: 'rime$ascii_mode',
              conditionValue: false,
            },
          ],
          notification: [
            utils.asciiModeChangedNotificationName(root.name, true),
            utils.asciiModeChangedNotificationName(root.name, false),
          ]
        },
        reference+: (
          if isAsciiModeAware then
            utils.newAsciiModeChangedNotification(root.name, true, {
              backgroundStyleName: root[root.name].backgroundStyle,
              foregroundStyleName: asciiModeOnForeground,
              [if std.objectHas(asciiModeOnParams, 'action') then 'action']: asciiModeOnParams.action,
              [if std.objectHas(asciiModeOnParams, 'swipeUp') && std.objectHas(asciiModeOnParams.swipeUp, 'action') then 'swipeUpAction']: asciiModeOnParams.swipeUp.action,
              [if std.objectHas(asciiModeOnParams, 'swipeDown') && std.objectHas(asciiModeOnParams.swipeDown, 'action') then 'swipeDownAction']: asciiModeOnParams.swipeDown.action,
            } + utils.extractProperties(root.params, ['bounds']))
            + utils.newAsciiModeChangedNotification(root.name, false, {
              backgroundStyleName: root[root.name].backgroundStyle,
              foregroundStyleName: asciiModeOffForeground,
              [if std.objectHas(asciiModeOffParams, 'action') then 'action']: asciiModeOffParams.action,
              [if std.objectHas(asciiModeOffParams, 'swipeUp') && std.objectHas(asciiModeOffParams.swipeUp, 'action') then 'swipeUpAction']: asciiModeOffParams.swipeUp.action,
              [if std.objectHas(asciiModeOffParams, 'swipeDown') && std.objectHas(asciiModeOffParams.swipeDown, 'action') then 'swipeDownAction']: asciiModeOffParams.swipeDown.action,
            } + utils.extractProperties(root.params, ['bounds']))
          else {}
        ) +
          {
            [if asciiModeOnParams != {} then utils.asciiModeForegroundStyleName(root.name, true)]: newAlphabeticButtonForegroundStyle(root.isDark, root.params + asciiModeOnParams),
            [if asciiModeOffParams != {} then utils.asciiModeForegroundStyleName(root.name, false)]: newAlphabeticButtonForegroundStyle(root.isDark, root.params + asciiModeOffParams),

            [if std.objectHas(asciiModeOnParams, 'swipeUp') then generateSwipeForegroundStyleName(root.name, 'Up', 'AsciiModeOn')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.up } + asciiModeOnParams.swipeUp),
            [if std.objectHas(asciiModeOffParams, 'swipeUp') then generateSwipeForegroundStyleName(root.name, 'Up', 'AsciiModeOff')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.up } + asciiModeOffParams.swipeUp),
            [if std.objectHas(asciiModeOnParams, 'swipeDown') then generateSwipeForegroundStyleName(root.name, 'Down', 'AsciiModeOn')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.down } + asciiModeOnParams.swipeDown),
            [if std.objectHas(asciiModeOffParams, 'swipeDown') then generateSwipeForegroundStyleName(root.name, 'Down', 'AsciiModeOff')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeTextCenter.down } + asciiModeOffParams.swipeDown),
          }
      },

  AddPreeditChangeEvent(newForegroundStyle):
    local isPreeditModeAware = std.objectHas(root.params, 'whenPreeditChanged');
    local preeditChangedParams = if isPreeditModeAware then root.params.whenPreeditChanged else {};
    if !isPreeditModeAware then
      root
    else root {
      [root.name]+: {
        notification+: [
          root.name + 'PreeditChangedNotification',
        ],
      },
      reference+: {
        [root.name + 'PreeditChangedNotification']: {
          notificationType: 'preeditChanged',
          backgroundStyle: root[root.name].backgroundStyle,
          foregroundStyle: root.name + 'PreeditChangedForegroundStyle',
        }
        + utils.extractProperties(preeditChangedParams, ['action']),
        [root.name + 'PreeditChangedForegroundStyle']: newForegroundStyle(root.isDark, root.params + preeditChangedParams),
      },
    },

  AddKeyboardActionEvent(newForegroundStyle):
    local isKeyboardActionAware = std.objectHas(root.params, 'whenKeyboardAction');
    local keyboardActionParams = if isKeyboardActionAware then root.params.whenKeyboardAction else [];
    assert std.type(keyboardActionParams) == 'array' : 'whenKeyboardAction 必须是数组类型';
    if !isKeyboardActionAware then
      root
    else root {
      [root.name]+: {
        notification+: [
          root.name + 'KeyboardAction'+i+'Notification' for i in std.range(0, std.length(keyboardActionParams) - 1)
        ]
      },
      reference+: {
        [root.name + 'KeyboardAction'+i+'Notification']: {
          notificationType: 'keyboardAction',
          backgroundStyle: root[root.name].backgroundStyle,
          foregroundStyle: root.name + 'KeyboardAction'+i+'ForegroundStyle',
        } + utils.extractProperties(keyboardActionParams[i], ['action', 'lockedNotificationMatchState', 'notificationKeyboardAction'])
        + utils.extractProperties(root.params, ['bounds'])
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      }
      + {
        [root.name + 'KeyboardAction'+i+'ForegroundStyle']: newForegroundStyle(root.isDark, root.params + keyboardActionParams[i]),
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      },
    },

  AddRimeOptionChangeEvent(): root {},

  GetButton(): {
    [root.name]: root[root.name],
  },
};

local newToolbarButton(name, isDark=false, params={}) =
  local button = newButton(name, 'system', isDark, params)
    .AddForegroundStyle(newToolbarButtonForegroundStyle)
    .AddPropertiesInParams()
    .AddAsciiModeChangeEvent();
  button.GetButton() + button.reference;

local newAlphabeticButton(name, isDark=false, params={}, needHint=true, swipeTextFollowSetting=false) =
  local button = newButton(name, 'alphabetic', isDark, params)
    .AddBackgroundStyle()
    .AddForegroundStyle(newAlphabeticButtonForegroundStyle)
    .AddHintStyle(needHint)
    .AddSwipeUp(if swipeTextFollowSetting then settings.showSwipeUpText else true)
    .AddSwipeDown(if swipeTextFollowSetting then settings.showSwipeDownText else true)
    .AddPropertiesInParams()
    .AddUppercasedState(newAlphabeticButtonUppercaseForegroundStyle)
    .AddCapsLockedState(newAlphabeticButtonForegroundStyle)
    .AddAnimation()
    .AddLongPress()
    .AddAsciiModeChangeEvent()
    .AddPreeditChangeEvent(newAlphabeticButtonForegroundStyle)
    .AddKeyboardActionEvent(newAlphabeticButtonForegroundStyle);
  button.GetButton() + button.reference;

local newSystemButton(name, isDark=false, params={}) =
  local button = newButton(name, 'system', isDark, params)
    .AddBackgroundStyle()
    .AddForegroundStyle(newSystemButtonForegroundStyle)
    .AddSwipeUp(false)
    .AddSwipeDown(false)
    .AddPropertiesInParams()
    .AddUppercasedState(newSystemButtonForegroundStyle)
    .AddCapsLockedState(newSystemButtonForegroundStyle)
    .AddLongPress()
    .AddAsciiModeChangeEvent()
    .AddPreeditChangeEvent(newSystemButtonForegroundStyle)
    .AddKeyboardActionEvent(newSystemButtonForegroundStyle);
  button.GetButton() + button.reference;

local newColorButton(name, isDark=false, params={}) =
  local button = newButton(name, 'color', isDark, params)
    .AddBackgroundStyle()
    .AddForegroundStyle(newColorButtonForegroundStyle)
    .AddSwipeUp(false)
    .AddSwipeDown(false)
    .AddPropertiesInParams()
    .AddUppercasedState(newColorButtonForegroundStyle)
    .AddCapsLockedState(newColorButtonForegroundStyle)
    .AddLongPress()
    .AddAsciiModeChangeEvent()
    .AddPreeditChangeEvent(newColorButtonForegroundStyle)
    .AddKeyboardActionEvent(newColorButtonForegroundStyle);
  button.GetButton() + button.reference;

local newSpaceButton(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=alphabeticButtonBackgroundStyleName)
            + (
              if std.objectHas(params, 'foregroundStyle') then
                { foregroundStyle: params.foregroundStyle }
              else
                utils.newForegroundStyle(style=name + 'ForegroundStyle')
            )
            + (
              if std.objectHas(params, 'uppercasedStateAction') then
                utils.newForegroundStyle('uppercasedStateForegroundStyle', name + 'UppercaseForegroundStyle')
              else {}
            )
            + (
              if std.objectHas(params, 'swipeUp') then
                { swipeUpAction: params.swipeUp.action }
              else {}
            )
            + (
              if std.objectHas(params, 'swipeDown') then
                { swipeDownAction: params.swipeDown.action }
              else {}
            )
            + utils.newAnimation(animation=[buttonAnimationName])
            + utils.extractProperties(
              params,
              [
                'size',
                'bounds',
                'action',
                'uppercasedStateAction',
                'repeatAction',
                'preeditStateAction',
                'capsLockedStateForegroundStyle',
                'preeditStateForegroundStyle',
                'notification',
              ]
            ),
  }
  + {
    [spaceButtonForegroundStyleName]: newAlphabeticButtonForegroundStyle(isDark, params),
  }
  + (
    if settings.spaceButtonShowSchema then
      {
        [spaceButtonRimeSchemaForegroundStyleName]: newSpaceButtonRimeSchemaForegroundStyle(isDark),
      }
    else {}
  )
  + (
    if std.objectHas(params, 'uppercasedStateAction') then
      {
        [name + 'UppercaseForegroundStyle']: newAlphabeticButtonUppercaseForegroundStyle(isDark, params) + getKeyboardActionText(params, 'uppercasedStateAction'),
      }
    else {}
  );

local newSymbolicCollection(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)
            + { cellStyle: name + 'CellStyle' }
            + utils.extractProperties(
              params,
              [
                'type',
                'size',
                'insets',
                'dataSource',
              ]
            ),
    [name + 'CellStyle']:
            // utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)+
            utils.newForegroundStyle(style=name + 'CellForegroundStyle'),
    [name + 'CellForegroundStyle']: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.numericCollectionTextFontSize,
    } + params, isDark),
  };


local rimeSchemaChangedNotification =
  if settings.spaceButtonShowSchema then
  {
    rimeSchemaChangedNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      backgroundStyle: alphabeticButtonBackgroundStyleName,
      foregroundStyle: spaceButtonForegroundStyle,
    },
  }
  else
  {};

local preeditChangedForEnterButtonNotification = {
  preeditChangedForEnterButtonNotification: {
    notificationType: 'preeditChanged',
    backgroundStyle: colorButtonBackgroundStyleName,
    foregroundStyle: colorButtonForegroundStyleName,
  },
};

local commitCandidateForegroundStyleName = 'commitCandidateForegroundStyle';
local preeditChangedForSpaceButtonNotification = {
  preeditChangedForSpaceButtonNotification: {
    notificationType: 'preeditChanged',
    backgroundStyle: alphabeticButtonBackgroundStyleName,
    foregroundStyle: commitCandidateForegroundStyleName,
  },
};

local newCommitCandidateForegroundStyle(isDark=false, params={}) = {
  [commitCandidateForegroundStyleName]: utils.newTextStyle({
    normalColor: colors.standardButtonForegroundColor,
    highlightColor: colors.standardButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + params,
};


{
  getKeyboardActionText: getKeyboardActionText,
  keyboardBackgroundStyleName: keyboardBackgroundStyleName,
  newKeyboardBackgroundStyle: newKeyboardBackgroundStyle,

  floatingKeyboardButtonBackgroundStyleName: floatingKeyboardButtonBackgroundStyleName,
  newFloatingKeyboardButtonBackgroundStyle: newFloatingKeyboardButtonBackgroundStyle,

  buttonAnimationName: buttonAnimationName,
  newButtonAnimation: newButtonAnimation,

  alphabeticButtonBackgroundStyleName: alphabeticButtonBackgroundStyleName,
  newAlphabeticButtonBackgroundStyle: newAlphabeticButtonBackgroundStyle,

  newAlphabeticButtonForegroundStyle: newAlphabeticButtonForegroundStyle,

  newAlphabeticButtonAlternativeForegroundStyle: newAlphabeticButtonAlternativeForegroundStyle,
  newAlphabeticButtonUppercaseForegroundStyle: newAlphabeticButtonUppercaseForegroundStyle,

  generateSwipeForegroundStyleNames: generateSwipeForegroundStyleNames,

  alphabeticHintBackgroundStyleName: alphabeticHintBackgroundStyleName,
  newAlphabeticHintBackgroundStyle: newAlphabeticHintBackgroundStyle,

  newAlphabeticButtonHintStyle: newAlphabeticButtonHintStyle,
  newLongPressSymbolsBackgroundStyle: newLongPressSymbolsBackgroundStyle,
  newLongPressSymbolsSelectedBackgroundStyle: newLongPressSymbolsSelectedBackgroundStyle,

  systemButtonBackgroundStyleName: systemButtonBackgroundStyleName,
  newSystemButtonBackgroundStyle: newSystemButtonBackgroundStyle,

  colorButtonBackgroundStyleName: colorButtonBackgroundStyleName,
  newColorButtonBackgroundStyle: newColorButtonBackgroundStyle,

  colorButtonForegroundStyleName: colorButtonForegroundStyleName,
  newColorButtonForegroundStyle: newColorButtonForegroundStyle,

  newTextSystemButtonForegroundStyle: newTextSystemButtonForegroundStyle,
  newImageSystemButtonForegroundStyle: newImageSystemButtonForegroundStyle,
  newAssetImageSystemButtonForegroundStyle: newAssetImageSystemButtonForegroundStyle,
  newSystemButtonForegroundStyle: newSystemButtonForegroundStyle,

  newFloatingKeyboardButton: newFloatingKeyboardButton,
  toolbarSlideButtonsName: toolbarSlideButtonsName,
  newToolbarSlideButtons: newToolbarSlideButtons,
  newToolbarButton: newToolbarButton,

  newAlphabeticButton: newAlphabeticButton,
  newSystemButton: newSystemButton,
  newColorButton: newColorButton,

  newSymbolicCollection: newSymbolicCollection,

  newSpaceButton: newSpaceButton,
  spaceButtonForegroundStyle: spaceButtonForegroundStyle,
  spaceButtonRimeSchemaForegroundStyleName: spaceButtonRimeSchemaForegroundStyleName,
  newSpaceButtonRimeSchemaForegroundStyle: newSpaceButtonRimeSchemaForegroundStyle,

  newCommitCandidateForegroundStyle: newCommitCandidateForegroundStyle,

  // notification
  rimeSchemaChangedNotification: rimeSchemaChangedNotification,
  preeditChangedForEnterButtonNotification: preeditChangedForEnterButtonNotification,
  preeditChangedForSpaceButtonNotification: preeditChangedForSpaceButtonNotification,
}
