local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local utils = import 'Utils.libsonnet';

local buttonCornerRadius = 8.5;

local swipeTextCenterNameToCenter = {
  'top':         {          y: 0.23 },
  'topLeft':     { x: 0.25, y: 0.25 },
  'topRight':    { x: 0.75, y: 0.25 },
  'bottom':      {          y: 0.77 },
  'bottomLeft':  { x: 0.25, y: 0.75 },
  'bottomRight': { x: 0.75, y: 0.75 },
  'hide':        null,
};

local swipeUpTextCenter = std.get(swipeTextCenterNameToCenter, settings.swipeUpTextCenter, null);
local swipeDownTextCenter = std.get(swipeTextCenterNameToCenter, settings.swipeDownTextCenter, null);

local textCenterWhenShowSwipeText = utils.calcMainTextCenter(swipeUpTextCenter, swipeDownTextCenter);


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

// 按优先级生成样式
// 此函数特别重要！错误地改动可能导致按键显示异常
// 请勿随意改动此函数，除非你非常清楚自己在做什么
local newStyleByPriority(isDark=false, params={}, highPriorityParams={}, systemImageParams={}, assetImageParams={}, textParams={}) =
  local tryAddTextInHighPriorityParams = getKeyboardActionText(highPriorityParams);
  if std.objectHas(highPriorityParams, 'systemImageName') && settings.preferIcon then
    utils.newSystemImageStyle(systemImageParams + params + highPriorityParams, isDark)
  else if std.objectHas(highPriorityParams, 'assetImageName') then
    utils.newAssetImageStyle(assetImageParams + params + highPriorityParams, isDark)
  else if std.objectHas(tryAddTextInHighPriorityParams, 'text') then
    utils.newTextStyle(textParams + params + highPriorityParams + tryAddTextInHighPriorityParams, isDark)
  else if std.objectHas(highPriorityParams, 'systemImageName') then
    // 不喜欢 icon，但是按文本显示失败，再次尝试显示 icon
    utils.newSystemImageStyle(systemImageParams + params + highPriorityParams, isDark)

  else if std.objectHas(params, 'systemImageName') && settings.preferIcon then
    utils.newSystemImageStyle(systemImageParams + params, isDark)
  else if std.objectHas(params, 'assetImageName') then
    utils.newAssetImageStyle(assetImageParams + params, isDark)
  else if std.objectHas(getKeyboardActionText(params), 'text') then
    utils.newTextStyle(textParams + params + getKeyboardActionText(params), isDark)
  else if std.objectHas(params, 'systemImageName') then
    // 不喜欢 icon，但是按文本显示失败，再次尝试显示 icon
    utils.newSystemImageStyle(systemImageParams + params, isDark)
  else
    assert false : 'newStyleByPriority 生成样式失败，params 和 highPriorityParams 中缺乏必要的字段，当前参数为 params=' + std.toString(params) + '，highPriorityParams=' + std.toString(highPriorityParams);
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
    insets: toolbarParams.floatingKeyboard.button.backgroundInsets.portrait,
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
local newAlphabeticButtonBackgroundStyle(isDark=false, params={}) =
  assert std.objectHas(params, 'insets') : '必须提供 insets 参数';
{
  [alphabeticButtonBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardButtonBackgroundColor,
    highlightColor: colors.standardButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 字母键按钮前景样式
local newAlphabeticButtonForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    },
    assetImageParams={
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    },
    textParams={
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonTextFontSize,
    },
  );

// 字母键按钮上下划提示前景样式
local newAlphabeticButtonAlternativeForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeImageFontSize,
    },
    assetImageParams={},
    textParams={
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeTextFontSize,
    }
  );

// 生成上下划提示前景名称
local generateSwipeForegroundStyleName(name, direction='Up', suffix='') =
  assert direction == 'Up' || direction == 'Down' : 'direction 必须是 Up 或 Down';
  name + suffix + 'Swipe' + direction + 'ForegroundStyle';



// 大写字母键按钮前景样式
local newAlphabeticButtonUppercaseForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    },
    assetImageParams={},
    textParams={
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonUppercasedTextFontSize,
    }
  );

// 字母提示大小
local hintStyleSize = {
  hintStyle: {
    size: { width: self.height, height: toolbarParams.toolbar.height },
  },
};

// 字母提示背景样式
local alphabeticHintBackgroundStyleName = 'alphabeticHintBackgroundStyle';
local newAlphabeticHintBackgroundStyle(isDark=false, params={}) = {
  [alphabeticHintBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutBackgroundColor,
    normalBorderColor: colors.standardCalloutBorderColor,
    highlightBorderColor: colors.standardCalloutBorderColor,
    borderSize: 0.5,
    shadowRadius: 3,
    normalShadowColor: colors.standardButtonShadowColor,
    highlightShadowColor: colors.standardButtonShadowColor,
  } + params, isDark),
};

// 字母提示前景样式
local newAlphabeticButtonHintStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintImageFontSize,
    },
    assetImageParams={},
    textParams={
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintTextFontSize,
    });

// 长按背景样式
local longPressSymbolsBackgroundStyleName = 'longPressSymbolsBackgroundStyle';
local newLongPressSymbolsBackgroundStyle(isDark=false, params={}) = {
  [longPressSymbolsBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutBackgroundColor,
    highlightColor: colors.standardCalloutSelectedBackgroundColor,
    cornerRadius: 10,
    normalBorderColor: colors.standardCalloutBorderColor,
    highlightBorderColor: colors.standardCalloutBorderColor,
    borderSize: 0.5,
    shadowRadius: 3,
    normalShadowColor: colors.standardButtonShadowColor,
    highlightShadowColor: colors.standardButtonShadowColor,
  } + params, isDark),
};

// 长按前景样式
local newLongPressSymbolsForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, utils.excludeProperties(params, ['center', 'normalColor', 'highlightColor', 'fontSize']), highPriorityParams,
    systemImageParams={
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintImageFontSize,
    },
    assetImageParams={},
    textParams={
      normalColor: colors.standardCalloutForegroundColor,
      highlightColor: colors.standardCalloutHighlightedForegroundColor,
      fontSize: fonts.hintTextFontSize,
    });

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
local newSystemButtonBackgroundStyle(isDark=false, params={}) =
  assert std.objectHas(params, 'insets') : '必须提供 insets 参数';
{
  [systemButtonBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.systemButtonBackgroundColor,
    highlightColor: colors.systemButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 系统键按钮前景样式
local newSystemButtonForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    },
    assetImageParams={
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    },
    textParams={
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
    }
  );


local spaceButtonRimeSchemaForegroundStyleName = 'spaceButtonRimeSchemaForegroundStyle';
local newSpaceButtonRimeSchemaForegroundStyle(schemaNameText, isDark=false) =
  if settings.spaceButtonSchemaNameCenter != null then
  {
    [spaceButtonRimeSchemaForegroundStyleName]: utils.newTextStyle({
      text: schemaNameText,
      fontSize: fonts.alternativeTextFontSize,
      center: settings.spaceButtonSchemaNameCenter,
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
    }, isDark),
  }
  else
  {};

local spaceButtonForegroundStyleName = 'spaceButtonForegroundStyle';
local spaceButtonForegroundStyle = [
  spaceButtonForegroundStyleName,
]
+ (
  if settings.spaceButtonSchemaNameCenter != null then
    [
      spaceButtonRimeSchemaForegroundStyleName,
    ]
  else []
  );

// 彩色功能键按钮背景样式
local colorButtonBackgroundStyleName = 'colorButtonBackgroundStyle';
local newColorButtonBackgroundStyle(isDark=false, params={}) =
  assert std.objectHas(params, 'insets') : '必须提供 insets 参数';
{
  [colorButtonBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.colorButtonBackgroundColor,
    highlightColor: colors.colorButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

local colorButtonForegroundStyleName = 'colorButtonForegroundStyle';
local newColorButtonForegroundStyle(isDark=false, params={}, highPriorityParams={}) =
  newStyleByPriority(isDark, params, highPriorityParams,
    systemImageParams={
      normalColor: colors.colorButtonForegroundColor,
      highlightColor: colors.colorButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    },
    assetImageParams={},
    textParams={
      normalColor: colors.colorButtonForegroundColor,
      highlightColor: colors.colorButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
    }
  );

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
  if settings.preferIcon && std.objectHas(params, 'systemImageName') then
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
  } + params + getKeyboardActionText(params), isDark)
  else
    assert false : 'toolbar button 必须指定 systemImageName、text 或 action 中的一个，当前参数为' + std.toString(params);
    {};

local toolbarSlideButtonsName = 'toolbarSlideButtons';
local newToolbarSlideButtons(buttons, slideButtonsMaxCount, isDark=false) =
  assert std.length(buttons) > slideButtonsMaxCount : '滑动按钮数量必须大于 slideButtonsMaxCount';
  {
    [toolbarSlideButtonsName]: {
      type: 'horizontalSymbols',
      size: { width: '%d/%d' % [slideButtonsMaxCount, slideButtonsMaxCount + 2] },
      maxColumns: slideButtonsMaxCount,
      contentRightToLeft: false,
      // backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsToolbarButtonsDataSource',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarCollectionCellStyle',
    },
    horizontalSymbolsToolbarButtonsDataSource:
      [
        {
          label: button.name,
          action: button.params.action,
          styleName: button.name + 'Style',
        } for button in buttons
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

  showSwipeUpText: true,
  showSwipeDownText: true,

  [name]: {}, // 保存按钮相关信息
  reference: {},   // 按钮内的相关引用定义
  globalNames: [], // 引用全局名称列表

  AddBackgroundStyle():
    local hasBackgroundName = std.objectHas(root.params, 'backgroundStyleName');
    local hasBackgroundStyle = std.objectHas(root.params, 'backgroundStyle');
  root {
    [root.name]+:
      if hasBackgroundName then
        assert std.type(root.params.backgroundStyleName) == 'string' : 'backgroundStyleName 必须是字符串，当前为' + root.params.backgroundStyleName;
        { backgroundStyle: root.params.backgroundStyleName }
      else
        { backgroundStyle: root.type + 'ButtonBackgroundStyle' },
    reference+:
      if hasBackgroundStyle then
        assert std.type(root.params.backgroundStyle) == 'object' : 'backgroundStyle 必须是一个对象，当前为' + root.params.backgroundStyle;
        root.params.backgroundStyle
      else {}
  },

  AddForegroundStyle(newButtonForegroundStyle):
    local hasForegroundName = std.objectHas(root.params, 'foregroundStyleName');
    local hasForegroundStyle = std.objectHas(root.params, 'foregroundStyle');
    assert hasForegroundName == hasForegroundStyle : 'foregroundStyleName 和 foregroundStyle 必须同时存在或同时不存在';
    local foregroundName = if hasForegroundName then root.params.foregroundStyleName else [];
    local foregroundStyle = if hasForegroundStyle then root.params.foregroundStyle else {};
  root {
    [root.name]+:
      if hasForegroundName then
        assert std.type(foregroundName) == 'array' : 'foregroundStyleName 必须是数组，当前为' + foregroundName;
        { foregroundStyle: foregroundName }
      else
        { foregroundStyle: [root.name + 'ForegroundStyle'], },
    reference+:
      (if !hasForegroundName || std.member(foregroundName, root.name + 'ForegroundStyle') then
      {
        [root.name + 'ForegroundStyle']: newButtonForegroundStyle(root.isDark, root.params),
      }
      else {}) + foregroundStyle,
    },

  // 内部调用函数，外面不要调用
  CreateHintStyleReference(hintStyleName, param):
    local hintForegroundStyleName = hintStyleName[:-5] + 'Foreground' + hintStyleName[-5:];
    local swipeUpHintForegroundStyleName = if std.objectHas(param, 'swipeUp') then hintStyleName[:-5] + 'SwipeUpForeground' + hintStyleName[-5:] else null;
    local swipeDownHintForegroundStyleName = if std.objectHas(param, 'swipeDown') then hintStyleName[:-5] + 'SwipeDownForeground' + hintStyleName[-5:] else null;
    {
      [hintStyleName]: (
            if std.objectHas(root.params, 'hintStyle') then
              root.params.hintStyle
            else
              {}
          )
          + utils.newBackgroundStyle(style=alphabeticHintBackgroundStyleName)
          + utils.newForegroundStyle(style=hintForegroundStyleName)
          + (
            if std.objectHas(param, 'swipeUp') && root.showSwipeUpText then
              utils.newForegroundStyle(styleName='swipeUpForegroundStyle', style=swipeUpHintForegroundStyleName)
            else {}
          )
          + (
            if std.objectHas(param, 'swipeDown') && root.showSwipeDownText then
              utils.newForegroundStyle(styleName='swipeDownForegroundStyle', style=swipeDownHintForegroundStyleName)
            else {}
          ),
      [hintForegroundStyleName]: newAlphabeticButtonHintStyle(root.isDark, utils.excludeProperties(param, ['center'])),
      [swipeUpHintForegroundStyleName]: newAlphabeticButtonHintStyle(root.isDark, utils.excludeProperties(param.swipeUp, ['center'])),
      [swipeDownHintForegroundStyleName]: newAlphabeticButtonHintStyle(root.isDark, utils.excludeProperties(param.swipeDown, ['center'])),
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
      reference+: root.CreateHintStyleReference(root.name + 'HintStyle', root.params),
    },

  AddPropertiesInParams(): root {
    [root.name]+: utils.extractProperties(
      root.params,
      [
        'size',
        'bounds',
        'action',
        'repeatAction',
        'notification',
      ]
    ),
  },

  AddSwipeUp(showSwipeText):
    local hasSwipeUpParams = std.objectHas(root.params, 'swipeUp');
    if !hasSwipeUpParams then
      root {
        showSwipeUpText: showSwipeText,
      }
    else
      local swipeUpParams = if hasSwipeUpParams then root.params.swipeUp else {};
      root {
        showSwipeUpText: showSwipeText,
        [root.name]+: {
            [if std.objectHas(swipeUpParams, 'action') then 'swipeUpAction']: swipeUpParams.action,
            [if showSwipeText then 'foregroundStyle']+: [generateSwipeForegroundStyleName(root.name, 'Up')],
          },
        reference+: {
            [if showSwipeText then generateSwipeForegroundStyleName(root.name, 'Up')]:
              newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter } + swipeUpParams),
          },
      },

  AddSwipeDown(showSwipeText):
    local hasSwipeDownParams = std.objectHas(root.params, 'swipeDown');
    if !hasSwipeDownParams then
      root {
        showSwipeDownText: showSwipeText,
      }
    else
      local swipeDownParams = if hasSwipeDownParams then root.params.swipeDown else {};
      root {
        showSwipeDownText: showSwipeText,
        [root.name]+: {
            [if std.objectHas(swipeDownParams, 'action') then 'swipeDownAction']: swipeDownParams.action,
            [if showSwipeText then 'foregroundStyle']+: [generateSwipeForegroundStyleName(root.name, 'Down')],
          },
        reference+: {
            [if showSwipeText then generateSwipeForegroundStyleName(root.name, 'Down')]:
              newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter } + swipeDownParams),
          },
      },

  AddUppercasedState(newButtonUppercasedForegroundStyle):
    local hasUppercasedParams = std.objectHas(root.params, 'uppercased');
    if !hasUppercasedParams then
      root
    else
      local uppercasedParams = if hasUppercasedParams then root.params.uppercased else {};
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
          [root.name + 'UppercasedForegroundStyle']: newButtonUppercasedForegroundStyle(root.isDark, root.params, uppercasedParams),
        },
      },

  AddCapsLockedState(newButtonCapsLockedForegroundStyle):
    local hasCapsLockedParams = std.objectHas(root.params, 'capsLocked');
    if !hasCapsLockedParams then
      root
    else
      local capsLockedParams = if hasCapsLockedParams then root.params.capsLocked else {};
      root {
        [root.name]+: {
          capsLockedStateForegroundStyle: root.name + 'CapsLockedForegroundStyle',
        },
        reference+: {
          [root.name + 'CapsLockedForegroundStyle']: newButtonCapsLockedForegroundStyle(root.isDark, root.params, capsLockedParams),
        },
      },

  AddLongPress():
    local hasLongPressParams = std.objectHas(root.params, 'longPress');
    if !hasLongPressParams then
      root
    else
      local longPressParams = if hasLongPressParams then root.params.longPress else [];
      assert std.type(longPressParams) == 'array' : 'longPress 必须是数组类型';
      root {
        [root.name]+: {
          hintSymbolsStyle: root.name + 'LongPressSymbolsStyle',
        },
        reference+: {
          [root.name + 'LongPressSymbolsStyle']:
            local findSelectedIndex =
              local findIndex(arr, idx) =
              if idx >= std.length(arr) then
                std.floor(std.length(arr) / 2) // 默认选中间那一项
              else if std.objectHas(arr[idx], 'selected') && arr[idx].selected == true then
                idx
              else
                findIndex(arr, idx + 1);
            findIndex(longPressParams, 0);
           {
            size: { width: self.height, height: toolbarParams.toolbar.height },
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
            newLongPressSymbolsForegroundStyle(root.isDark, root.params, longPressParams[i]),
            for i in std.range(0, std.length(longPressParams) - 1)
        },
      },

  AddAnimation(): root {
    [root.name]+: utils.newAnimation(animation=[buttonAnimationName]),
    globalNames+: [buttonAnimationName],
  },

  AddPreeditChangeEvent(newForegroundStyle):
    local isPreeditModeAware = std.objectHas(root.params, 'whenPreeditChanged');
    if !isPreeditModeAware then
      root
    else
      local preeditChangedParams = if isPreeditModeAware then root.params.whenPreeditChanged else {};
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      root {
      [root.name]+: {
        notification+: [
          root.name + 'PreeditChangedNotification',
        ],
      },
      reference+: {
        [root.name + 'PreeditChangedNotification']: std.prune({
          notificationType: 'preeditChanged',
          backgroundStyle:
            if std.objectHas(preeditChangedParams, 'backgroundStyle') then
              preeditChangedParams.backgroundStyle
            else if std.objectHas(root[root.name], 'backgroundStyle') then
              root[root.name].backgroundStyle
            else
              null,
          foregroundStyle: [
            root.name + 'PreeditChangedForegroundStyle',
          ] + (
            if std.objectHas(preeditChangedParams, 'swipeUp') && root.showSwipeUpText then
              [generateSwipeForegroundStyleName(root.name, 'Up', 'PreeditChanged')]
            else []
          ) + (
            if std.objectHas(preeditChangedParams, 'swipeDown') && root.showSwipeDownText then
              [generateSwipeForegroundStyleName(root.name, 'Down', 'PreeditChanged')]
            else []
          ),
          [if std.objectHas(preeditChangedParams, 'swipeUp') && std.objectHas(preeditChangedParams.swipeUp, 'action') then 'swipeUpAction']: preeditChangedParams.swipeUp.action,
          [if std.objectHas(preeditChangedParams, 'swipeDown') && std.objectHas(preeditChangedParams.swipeDown, 'action') then 'swipeDownAction']: preeditChangedParams.swipeDown.action,
        })
        + utils.extractProperties(preeditChangedParams, ['action'])
        + utils.extractProperties(root.params, ['bounds']) + (
          if needUpdateHintStyle then
            {
              hintStyle: root.name + 'PreeditChangedHintStyle',
            }
          else {}
        ),
        [root.name + 'PreeditChangedForegroundStyle']: newForegroundStyle(root.isDark, root.params, preeditChangedParams),
      } + (
        if needUpdateHintStyle then
          root.CreateHintStyleReference(root.name + 'PreeditChangedHintStyle', preeditChangedParams)
        else {}
      ) + {
        [if std.objectHas(preeditChangedParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up', 'PreeditChanged')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, preeditChangedParams.swipeUp),
        [if std.objectHas(preeditChangedParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down', 'PreeditChanged')]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, preeditChangedParams.swipeDown),
      },
    },

  AddKeyboardActionEvent(newForegroundStyle):
    local isKeyboardActionAware = std.objectHas(root.params, 'whenKeyboardAction');
    if !isKeyboardActionAware then
      root
    else
      local keyboardActionParams = if isKeyboardActionAware then root.params.whenKeyboardAction else [];
      assert std.type(keyboardActionParams) == 'array' : 'whenKeyboardAction 必须是数组类型';
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      local oldForegroundStyle = if std.type(root[root.name].foregroundStyle[0]) == 'string' then root[root.name].foregroundStyle else root[root.name].foregroundStyle[0].styleName;
      root {
      [root.name]+: {
        notification+: [
          root.name + 'KeyboardAction'+i+'Notification' for i in std.range(0, std.length(keyboardActionParams) - 1)
        ]
      },
      reference+: {
        [root.name + 'KeyboardAction'+i+'Notification']: std.prune({
          notificationType: 'keyboardAction',
          backgroundStyle:
            if std.objectHas(keyboardActionParams[i], 'backgroundStyle') then
              keyboardActionParams[i].backgroundStyle
            else if std.objectHas(root[root.name], 'backgroundStyle') then
              root[root.name].backgroundStyle
            else
              null,
          foregroundStyle: replaceGivenPairs(
            oldForegroundStyle,
            {
              [root.name + 'ForegroundStyle']: root.name + 'KeyboardAction'+i+'ForegroundStyle',
              [if std.objectHas(keyboardActionParams[i], 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up')]: generateSwipeForegroundStyleName(root.name, 'Up', 'KeyboardAction'+i),
              [if std.objectHas(keyboardActionParams[i], 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down')]: generateSwipeForegroundStyleName(root.name, 'Down', 'KeyboardAction'+i),
            }
          ),
          [if std.objectHas(keyboardActionParams[i], 'swipeUp') && std.objectHas(keyboardActionParams[i].swipeUp, 'action') then 'swipeUpAction']: keyboardActionParams[i].swipeUp.action,
          [if std.objectHas(keyboardActionParams[i], 'swipeDown') && std.objectHas(keyboardActionParams[i].swipeDown, 'action') then 'swipeDownAction']: keyboardActionParams[i].swipeDown.action,
        }) + utils.extractProperties(keyboardActionParams[i], ['action', 'lockedNotificationMatchState', 'notificationKeyboardAction'])
        + utils.extractProperties(root.params, ['bounds'])
        + (
          if needUpdateHintStyle then
            {
              hintStyle: root.name + 'KeyboardAction'+i+'HintStyle',
            }
          else {}
        )
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      }
      + {
        [root.name + 'KeyboardAction'+i+'ForegroundStyle']: newForegroundStyle(root.isDark, root.params, keyboardActionParams[i]),
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      } + (
        if needUpdateHintStyle then
          local hintStyleList = [
            root.CreateHintStyleReference(root.name + 'KeyboardAction'+i+'HintStyle', keyboardActionParams[i]) for i in std.range(0, std.length(keyboardActionParams) - 1)
          ];
          std.foldl(
            function(x, y) x + y,
            hintStyleList,
            {}
          )
        else {}
      )
      + {
        [if std.objectHas(keyboardActionParams[i], 'swipeUp') then generateSwipeForegroundStyleName(root.name, 'Up', 'KeyboardAction'+i)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, keyboardActionParams[i].swipeUp),
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      } + {
        [if std.objectHas(keyboardActionParams[i], 'swipeDown') then generateSwipeForegroundStyleName(root.name, 'Down', 'KeyboardAction'+i)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, keyboardActionParams[i].swipeDown),
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      },
    },

  AddRimeOptionChangeEvent():
    local hasRimeOptionParams = std.objectHas(root.params, 'whenRimeOptionChanged');
    if !hasRimeOptionParams then
      root
    else
      local rimeOptionParams = root.params.whenRimeOptionChanged;
      assert std.objectHas(rimeOptionParams, 'optionName') : '必须提供 optionName 参数';
      assert std.objectHas(rimeOptionParams, 'optionValue') : '必须提供 optionValue 参数';
      local rimeOptionName = rimeOptionParams.optionName;
      local rimeOptionValue = rimeOptionParams.optionValue;
      local rimeOptionStr = rimeOptionName + (if rimeOptionValue then 'On' else 'Off');
      assert std.type(rimeOptionValue) == 'boolean' : 'optionValue 参数必须是布尔值，当前类型为 ' + std.type(rimeOptionValue);
      local oldForegroundStyle = root[root.name].foregroundStyle;
      local rimeOptionChangedForeground = replaceGivenPairs(
        oldForegroundStyle,
        {
          [root.name + 'ForegroundStyle']: utils.rimeOptionChangedForegroundStyleName(root.name, rimeOptionName, rimeOptionValue),
          [if std.objectHas(rimeOptionParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up')]: generateSwipeForegroundStyleName(root.name, 'Up', rimeOptionStr),
          [if std.objectHas(rimeOptionParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down')]: generateSwipeForegroundStyleName(root.name, 'Down', rimeOptionStr),
        }
      );
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      root {
        [root.name]+: {
          foregroundStyle: [
            {
              styleName: oldForegroundStyle,
              conditionKey: 'rime$' + rimeOptionName,
              conditionValue: !rimeOptionValue,
            },
            {
              styleName: rimeOptionChangedForeground,
              conditionKey: 'rime$' + rimeOptionName,
              conditionValue: rimeOptionValue,
            },
          ],

          notification: [
            utils.rimeOptionChangedNotificationName(root.name, rimeOptionName, rimeOptionValue),
          ],
        },
        reference+: utils.newRimeOptionChangedNotification(root.name, rimeOptionName, rimeOptionValue, {
          backgroundStyleName: root[root.name].backgroundStyle,
          foregroundStyleName: rimeOptionChangedForeground,
          [if std.objectHas(rimeOptionParams, 'action') then 'action']: rimeOptionParams.action,
          [if std.objectHas(rimeOptionParams, 'swipeUp') && std.objectHas(rimeOptionParams.swipeUp, 'action') then 'swipeUpAction']: rimeOptionParams.swipeUp.action,
          [if std.objectHas(rimeOptionParams, 'swipeDown') && std.objectHas(rimeOptionParams.swipeDown, 'action') then 'swipeDownAction']: rimeOptionParams.swipeDown.action,
          [if needUpdateHintStyle then 'hintStyle']: root.name + rimeOptionStr + 'HintStyle',
        } + utils.extractProperties(root.params, ['bounds'])
        + utils.extractProperties(root[root.name], ['capsLockedStateForegroundStyle', 'uppercasedStateForegroundStyle']))
        + {
          [utils.rimeOptionChangedForegroundStyleName(root.name, rimeOptionName, rimeOptionValue)]: newAlphabeticButtonForegroundStyle(root.isDark, root.params, rimeOptionParams),
        }
        + {
          [if std.objectHas(rimeOptionParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up', rimeOptionStr)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, rimeOptionParams.swipeUp),
          [if std.objectHas(rimeOptionParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down', rimeOptionStr)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, rimeOptionParams.swipeDown),
        } + (
          if needUpdateHintStyle then
            root.CreateHintStyleReference(root.name + rimeOptionStr + 'HintStyle', root.params + rimeOptionParams)
          else {}
        ),
      },

  GetButton(): {
    [root.name]: root[root.name],
  },
};

local newToolbarButton(name, isDark=false, params={}) =
  local button = newButton(name, 'system', isDark, params)
    .AddForegroundStyle(newToolbarButtonForegroundStyle)
    .AddPropertiesInParams()
    .AddRimeOptionChangeEvent();
  button.GetButton() + button.reference;

local newAlphabeticButton(name, isDark=false, params={}, needHint=true, swipeTextFollowSetting=true) =
  local button = newButton(name, 'alphabetic', isDark, params)
    .AddBackgroundStyle()
    .AddForegroundStyle(newAlphabeticButtonForegroundStyle)
    .AddHintStyle(needHint)
    .AddSwipeUp(if swipeTextFollowSetting then swipeUpTextCenter!=null else true)
    .AddSwipeDown(if swipeTextFollowSetting then swipeDownTextCenter!=null else true)
    .AddPropertiesInParams()
    .AddUppercasedState(newAlphabeticButtonUppercaseForegroundStyle)
    .AddCapsLockedState(newAlphabeticButtonForegroundStyle)
    .AddAnimation()
    .AddLongPress()
    .AddPreeditChangeEvent(newAlphabeticButtonForegroundStyle)
    .AddKeyboardActionEvent(newAlphabeticButtonForegroundStyle)
    .AddRimeOptionChangeEvent();
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
    .AddPreeditChangeEvent(newSystemButtonForegroundStyle)
    .AddKeyboardActionEvent(newSystemButtonForegroundStyle)
    .AddRimeOptionChangeEvent();
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
    .AddPreeditChangeEvent(newColorButtonForegroundStyle)
    .AddKeyboardActionEvent(newColorButtonForegroundStyle)
    .AddRimeOptionChangeEvent();
  button.GetButton() + button.reference;

local rimeSchemaChangedNotification =
  {
    [if settings.spaceButtonSchemaNameCenter != null then 'rimeSchemaChangedNotification']: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      backgroundStyle: alphabeticButtonBackgroundStyleName,
      foregroundStyle: spaceButtonForegroundStyle,
    },
  };

local returnKeyTypeChangedNotification =
  {
    returnKeyTypeChangedNotification:{
      notificationType: 'returnKeyType',
      returnKeyType: [],
      backgroundStyle: colorButtonBackgroundStyleName,
      foregroundStyle: colorButtonForegroundStyleName,
    },
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

  hintStyleSize: hintStyleSize,
  textCenterWhenShowSwipeText: textCenterWhenShowSwipeText,
  alphabeticHintBackgroundStyleName: alphabeticHintBackgroundStyleName,
  newAlphabeticHintBackgroundStyle: newAlphabeticHintBackgroundStyle,

  newAlphabeticButtonHintStyle: newAlphabeticButtonHintStyle,
  newLongPressSymbolsBackgroundStyle: newLongPressSymbolsBackgroundStyle,
  newLongPressSymbolsSelectedBackgroundStyle: newLongPressSymbolsSelectedBackgroundStyle,

  systemButtonBackgroundStyleName: systemButtonBackgroundStyleName,
  newSystemButtonBackgroundStyle: newSystemButtonBackgroundStyle,

  newColorButtonBackgroundStyle: newColorButtonBackgroundStyle,

  newFloatingKeyboardButton: newFloatingKeyboardButton,
  toolbarSlideButtonsName: toolbarSlideButtonsName,
  newToolbarSlideButtons: newToolbarSlideButtons,
  newToolbarButton: newToolbarButton,

  newAlphabeticButton: newAlphabeticButton,
  newSystemButton: newSystemButton,
  newColorButton: newColorButton,

  spaceButtonForegroundStyle: spaceButtonForegroundStyle,
  newSpaceButtonRimeSchemaForegroundStyle: newSpaceButtonRimeSchemaForegroundStyle,

  // notification
  rimeSchemaChangedNotification: rimeSchemaChangedNotification,
  returnKeyTypeChangedNotification: returnKeyTypeChangedNotification,
}
