local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local utils = import '../Utils/Utils.libsonnet';

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

local newClassifiedCollection(name, isDark=true, isPortrait=true, params={}) = {
    [name]: {
      type: 'classifiedSymbols',
      backgroundStyle: systemButtonBackgroundStyleName,
      cellStyle: 'classifiedSymbolsCellStyle',
    } + params,
    classifiedSymbolsCellStyle: {
      backgroundStyle: 'classifiedSymbolsCellBackgroundStyle',
      foregroundStyle: 'classifiedSymbolsCellForegroundStyle',
    },
    classifiedSymbolsCellBackgroundStyle: utils.newGeometryStyle({
      highlightColor: colors.systemButtonHighlightedBackgroundColor,
      cornerRadius: buttonCornerRadius,
    } + params + {
      insets: {
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
      }
    }, isDark),
    classifiedSymbolsCellForegroundStyle: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
    }, isDark),
  };

local newSubClassifiedCollection(name, isDark=true, isPortrait=true, params={}) = {
    [name]: {
      type: 'subClassifiedSymbols',
      backgroundStyle: systemButtonBackgroundStyleName,
      cellStyle: 'subClassifiedSymbolsCellStyle',
      maximumRow: 4,
      maximumColumn: if isPortrait then 5 else 10,
    } + params,
    subClassifiedSymbolsCellStyle: {
      backgroundStyle: 'subClassifiedSymbolsCellBackgroundStyle',
      foregroundStyle: 'subClassifiedSymbolsCellForegroundStyle',
    },
    subClassifiedSymbolsCellBackgroundStyle: utils.newGeometryStyle({
      highlightColor: colors.systemButtonHighlightedBackgroundColor,
      cornerRadius: buttonCornerRadius,
    } + params, isDark),
    subClassifiedSymbolsCellForegroundStyle: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
    }, isDark),
  };

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
  local _CreateHintStyleReference(hintStyleName, param) =
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
      reference+: _CreateHintStyleReference(root.name + 'HintStyle', root.params),
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

  local _BackgroundStyleName(param) =
    if std.objectHas(param, 'backgroundStyle') then
      param.backgroundStyle
    else if std.objectHas(root[root.name], 'backgroundStyle') then
      root[root.name].backgroundStyle
    else
      null,

  // ====== 通知相关的通用辅助函数 ======

  // 从事件参数中提取 swipeUpAction 和 swipeDownAction
  local _buildSwipeActions(eventParams) = std.prune({
    [if std.objectHas(eventParams, 'swipeUp') && std.objectHas(eventParams.swipeUp, 'action') then 'swipeUpAction']: eventParams.swipeUp.action,
    [if std.objectHas(eventParams, 'swipeDown') && std.objectHas(eventParams.swipeDown, 'action') then 'swipeDownAction']: eventParams.swipeDown.action,
  }),

  // 构建前景样式名列表（主前景 + 上下划前景）
  local _buildForegroundStyleList(baseForegroundName, suffix, eventParams) =
    [baseForegroundName + suffix + 'ForegroundStyle']
    + (
      if std.objectHas(eventParams, 'swipeUp') && root.showSwipeUpText then
        [generateSwipeForegroundStyleName(baseForegroundName, 'Up', suffix)]
      else []
    ) + (
      if std.objectHas(eventParams, 'swipeDown') && root.showSwipeDownText then
        [generateSwipeForegroundStyleName(baseForegroundName, 'Down', suffix)]
      else []
    ),

  // 构建前景样式名替换映射（用于 replaceGivenPairs）
  local _buildForegroundReplacementMap(suffix, eventParams) = {
    [root.name + 'ForegroundStyle']: root.name + suffix + 'ForegroundStyle',
    [if std.objectHas(eventParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up')]: generateSwipeForegroundStyleName(root.name, 'Up', suffix),
    [if std.objectHas(eventParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down')]: generateSwipeForegroundStyleName(root.name, 'Down', suffix),
  },

  // 构建通知对象体（所有事件类型共用的核心结构）
  // notificationTypeFields: 事件类型特有的字段，如 {notificationType: 'preeditChanged'}
  // eventParams: 事件参数
  // foregroundStyleList: 前景样式名列表
  // extraExtractKeys: 额外需要从 eventParams 中提取的属性名列表
  // needUpdateHintStyle: 是否需要更新 hintStyle
  // hintStyleName: hintStyle 名称（仅 needUpdateHintStyle 为 true 时使用）
  local _buildNotificationBody(notificationTypeFields, eventParams, foregroundStyleList, extraExtractKeys=[], needUpdateHintStyle=false, hintStyleName='') =
    std.prune(notificationTypeFields + {
      backgroundStyle: _BackgroundStyleName(eventParams),
      foregroundStyle: foregroundStyleList,
    })
    + _buildSwipeActions(eventParams)
    + utils.extractProperties(eventParams, ['action'] + extraExtractKeys)
    + utils.extractProperties(root.params, ['bounds'])
    + (
      if needUpdateHintStyle then
        { hintStyle: hintStyleName }
      else {}
    ),

  // 构建通知伴随的样式引用（主前景样式 + 上下划前景样式 + 提示样式）
  // suffix: 样式名后缀
  // eventParams: 事件参数
  // newForegroundStyle: 前景样式构造函数 (isDark, params, highPriorityParams) => style
  // needUpdateHintStyle: 是否需要生成 hintStyle 引用
  local _buildNotificationCompanionStyles(suffix, eventParams, newForegroundStyle, needUpdateHintStyle=false) =
    {
      [root.name + suffix + 'ForegroundStyle']: newForegroundStyle(root.isDark, root.params, eventParams),
    }
    + {
      [if std.objectHas(eventParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up', suffix)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, eventParams.swipeUp),
      [if std.objectHas(eventParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down', suffix)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, eventParams.swipeDown),
    }
    + (
      if needUpdateHintStyle then
        _CreateHintStyleReference(root.name + suffix + 'HintStyle', root.params + eventParams)
      else {}
    ),

  // ====== 事件处理方法 ======

  AddPreeditChangeEvent(newForegroundStyle):
    local isPreeditModeAware = std.objectHas(root.params, 'whenPreeditChanged');
    if !isPreeditModeAware then
      root
    else
      local suffix = 'PreeditChanged';
      local eventParams = root.params.whenPreeditChanged;
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      local foregroundList = _buildForegroundStyleList(root.name, suffix, eventParams);
      root {
      [root.name]+: {
        notification+: [
          root.name + suffix + 'Notification',
        ],
      },
      reference+: {
        [root.name + suffix + 'Notification']:
          _buildNotificationBody(
            { notificationType: 'preeditChanged' },
            eventParams,
            foregroundList,
            needUpdateHintStyle=needUpdateHintStyle,
            hintStyleName=root.name + suffix + 'HintStyle',
          ),
      }
      + _buildNotificationCompanionStyles(suffix, eventParams, newForegroundStyle, needUpdateHintStyle),
    },

  AddKeyboardActionEvent(newForegroundStyle):
    local isKeyboardActionAware = std.objectHas(root.params, 'whenKeyboardAction');
    if !isKeyboardActionAware then
      root
    else
      local keyboardActionParams = root.params.whenKeyboardAction;
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
        [root.name + 'KeyboardAction'+i+'Notification']:
          _buildNotificationBody(
            { notificationType: 'keyboardAction' },
            keyboardActionParams[i],
            replaceGivenPairs(oldForegroundStyle, _buildForegroundReplacementMap('KeyboardAction'+i, keyboardActionParams[i])),
            extraExtractKeys=['lockedNotificationMatchState', 'notificationKeyboardAction'],
            needUpdateHintStyle=needUpdateHintStyle,
            hintStyleName=root.name + 'KeyboardAction'+i+'HintStyle',
          )
        for i in std.range(0, std.length(keyboardActionParams) - 1)
      }
      + std.foldl(
        function(acc, i)
          local suffix = 'KeyboardAction'+i;
          acc + _buildNotificationCompanionStyles(suffix, keyboardActionParams[i], newForegroundStyle, needUpdateHintStyle),
        std.range(0, std.length(keyboardActionParams) - 1),
        {}
      ),
    },

  // rime option 变化时生成 notification 及 foreground style
  local _rimeOptionChangedForegroundStyleName(name, rimeOptionName, value) =
    name + rimeOptionName + (if value then 'On' else 'Off') + 'ForegroundStyle',

  local _rimeOptionChangedNotificationName(name, rimeOptionName, value) =
    name + rimeOptionName + (if value then 'On' else 'Off') + 'Notification',

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
        _buildForegroundReplacementMap(rimeOptionStr, rimeOptionParams) + {
          // 覆盖默认的 ForegroundStyle 名称为 rime option 专用名称
          [root.name + 'ForegroundStyle']: _rimeOptionChangedForegroundStyleName(root.name, rimeOptionName, rimeOptionValue),
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
            _rimeOptionChangedNotificationName(root.name, rimeOptionName, rimeOptionValue),
          ],
        },
        reference+: {
          [_rimeOptionChangedNotificationName(root.name, rimeOptionName, rimeOptionValue)]:
            _buildNotificationBody(
              {
                notificationType: 'rime',
                rimeNotificationType: 'optionChanged',
                rimeOptionName: rimeOptionName,
                rimeOptionValue: rimeOptionValue,
              },
              rimeOptionParams,
              rimeOptionChangedForeground,
              needUpdateHintStyle=needUpdateHintStyle,
              hintStyleName=root.name + rimeOptionStr + 'HintStyle',
            )
            + utils.extractProperties(root[root.name], ['capsLockedStateForegroundStyle', 'uppercasedStateForegroundStyle']),
        }
        + {
          [_rimeOptionChangedForegroundStyleName(root.name, rimeOptionName, rimeOptionValue)]: newAlphabeticButtonForegroundStyle(root.isDark, root.params, rimeOptionParams),
        }
        + {
          [if std.objectHas(rimeOptionParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up', rimeOptionStr)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, rimeOptionParams.swipeUp),
          [if std.objectHas(rimeOptionParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down', rimeOptionStr)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, rimeOptionParams.swipeDown),
        } + (
          if needUpdateHintStyle then
            _CreateHintStyleReference(root.name + rimeOptionStr + 'HintStyle', root.params + rimeOptionParams)
          else {}
        ),
      },

  // schema 变化时生成 notification 及 foreground style
  local _rimeSchemaTagetName(schemaChangeParams) =
    if std.objectHas(schemaChangeParams, 'rimeSchemaID') then
      schemaChangeParams.rimeSchemaID
    else
      schemaChangeParams.rimeSchemaName,

  local _rimeSchemaChangedForegroundStyleName(name, schemaTargetName) =
    name + schemaTargetName + 'ForegroundStyle',

  local _rimeSchemaChangedNotificationName(name, schemaTargetName) =
    name + schemaTargetName + 'Notification',

  AddSchemaChangeEvent():
    local hasSchemaChangeParams = std.objectHas(root.params, 'whenRimeSchemaChanged');
    if !hasSchemaChangeParams then
      root
    else
      local schemaChangeParams = root.params.whenRimeSchemaChanged;
      assert std.objectHas(schemaChangeParams, 'rimeSchemaID') || std.objectHas(schemaChangeParams, 'rimeSchemaName') : '必须提供 rimeSchemaID 或 rimeSchemaName 参数，当前 whenRimeSchemaChanged 为 ' + std.toString(schemaChangeParams);
      local schemaTargetName = _rimeSchemaTagetName(schemaChangeParams);
      local schemaChangeName = 'RimeSchemaChangedTo' + schemaTargetName;
      local oldForegroundStyle = root[root.name].foregroundStyle;
      local schemaChangedForeground = replaceGivenPairs(
        oldForegroundStyle,
        _buildForegroundReplacementMap(schemaChangeName, schemaChangeParams) + {
          // 覆盖默认的 ForegroundStyle 名称为 schema change 专用名称
          [root.name + 'ForegroundStyle']: _rimeSchemaChangedForegroundStyleName(root.name, schemaChangeName),
        }
      );
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      root {
        [root.name]+: {
          notification+: [
            _rimeSchemaChangedNotificationName(root.name, schemaChangeName),
          ],
        },
        reference+: {
          [_rimeSchemaChangedNotificationName(root.name, schemaChangeName)]:
            _buildNotificationBody(
              {
                notificationType: 'rime',
                rimeNotificationType: 'schemaChanged',
              }
              + utils.extractProperties(schemaChangeParams, ['rimeSchemaID', 'rimeSchemaName']),
              schemaChangeParams,
              schemaChangedForeground,
              needUpdateHintStyle=needUpdateHintStyle,
              hintStyleName=root.name + schemaChangeName + 'HintStyle',
            )
            + utils.extractProperties(root[root.name], ['capsLockedStateForegroundStyle', 'uppercasedStateForegroundStyle']),
        }
        + {
          [_rimeSchemaChangedForegroundStyleName(root.name, schemaChangeName)]: newAlphabeticButtonForegroundStyle(root.isDark, root.params, schemaChangeParams),
        }
        + {
          [if std.objectHas(schemaChangeParams, 'swipeUp') && root.showSwipeUpText then generateSwipeForegroundStyleName(root.name, 'Up', schemaChangeName)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeUpTextCenter }, schemaChangeParams.swipeUp),
          [if std.objectHas(schemaChangeParams, 'swipeDown') && root.showSwipeDownText then generateSwipeForegroundStyleName(root.name, 'Down', schemaChangeName)]: newAlphabeticButtonAlternativeForegroundStyle(root.isDark, { center: swipeDownTextCenter }, schemaChangeParams.swipeDown),
        } + (
          if needUpdateHintStyle then
            _CreateHintStyleReference(root.name + schemaChangeName + 'HintStyle', root.params + schemaChangeParams)
          else {}
        ),
      },

  // 回车键类型变化时生成 notification 及 foreground style
  // whenReturnKeyChanged 是一个数组，每个元素包含：
  //   returnKeyType: [int] 或 int — 要匹配的回车键类型
  //   以及其他通知参数（action, text, systemImageName, backgroundStyle 等）
  //
  // 回车键类型值：
  // 1-Go  2-Google  3-Join  4-Next  5-Route
  // 6-Search  7-Send  8-Yahoo  9-Done  10-EmergencyCall  11-Continue
  AddReturnKeyTypeChangeEvent(newForegroundStyle):
    local hasReturnKeyParams = std.objectHas(root.params, 'whenReturnKeyChanged');
    if !hasReturnKeyParams then
      root
    else
      local returnKeyParams = root.params.whenReturnKeyChanged;
      assert std.type(returnKeyParams) == 'array' : 'whenReturnKeyChanged 必须是数组类型';
      local needUpdateHintStyle = std.objectHas(root[root.name], 'hintStyle');
      root {
      [root.name]+: {
        notification+: [
          root.name + 'ReturnKeyType'+i+'Notification' for i in std.range(0, std.length(returnKeyParams) - 1)
        ]
      },
      reference+: {
        [root.name + 'ReturnKeyType'+i+'Notification']:
          assert std.objectHas(returnKeyParams[i], 'returnKeyType') : 'whenReturnKeyChanged[' + i + '] 必须包含 returnKeyType';
          local returnKeyType = returnKeyParams[i].returnKeyType;
          _buildNotificationBody(
            {
              notificationType: 'returnKeyType',
              returnKeyType: if std.type(returnKeyType) == 'array' then returnKeyType else [returnKeyType],
            },
            returnKeyParams[i],
            _buildForegroundStyleList(root.name, 'ReturnKeyType'+i, returnKeyParams[i]),
            needUpdateHintStyle=needUpdateHintStyle,
            hintStyleName=root.name + 'ReturnKeyType'+i+'HintStyle',
          )
        for i in std.range(0, std.length(returnKeyParams) - 1)
      }
      + std.foldl(
        function(acc, i)
          acc + _buildNotificationCompanionStyles('ReturnKeyType'+i, returnKeyParams[i], newForegroundStyle, needUpdateHintStyle),
        std.range(0, std.length(returnKeyParams) - 1),
        {}
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
    .AddReturnKeyTypeChangeEvent(newAlphabeticButtonForegroundStyle)
    .AddRimeOptionChangeEvent()
    .AddSchemaChangeEvent();
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
    .AddReturnKeyTypeChangeEvent(newSystemButtonForegroundStyle)
    .AddRimeOptionChangeEvent()
    .AddSchemaChangeEvent();
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
    .AddReturnKeyTypeChangeEvent(newColorButtonForegroundStyle)
    .AddRimeOptionChangeEvent()
    .AddSchemaChangeEvent();
  button.GetButton() + button.reference;


local spaceButtonRimeSchemaForegroundStyleName = 'spaceButtonRimeSchemaForegroundStyle';
local newSpaceButtonRimeSchemaForegroundStyle(schemaNameText, isDark=false) =
  {
    [spaceButtonRimeSchemaForegroundStyleName]: utils.newTextStyle({
      text: schemaNameText,
      fontSize: fonts.alternativeTextFontSize,
      center: settings.spaceButtonSchemaNameCenter,
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
    }, isDark),
  };

local showSchemaName = settings.spaceButtonSchemaNameCenter != null;
local showSchemaNameAtCenter = utils.normalizeCenter(settings.spaceButtonSchemaNameCenter) == utils.normalizeCenter({}); // 特殊处理显示在中间的，直接将其显示在空格文本上，不用额外增加一个前景样式
local needCornerSchemaName = showSchemaName && !showSchemaNameAtCenter;

local spaceButtonForegroundStyleName = 'spaceButtonForegroundStyle';
local spaceButtonForegroundStyle = [
  spaceButtonForegroundStyleName,
]
+ (
  if needCornerSchemaName then [
    spaceButtonRimeSchemaForegroundStyleName,
  ]
  else []
  );

local newSpaceButtonForegroundStyle(params, schemaNameText, isDark=false) =
  std.mergePatch(params,
    if needCornerSchemaName then {
      foregroundStyleName: spaceButtonForegroundStyle,

      foregroundStyle: {
        [spaceButtonRimeSchemaForegroundStyleName]: utils.newTextStyle({
          text: schemaNameText,
          fontSize: fonts.alternativeTextFontSize,
          center: settings.spaceButtonSchemaNameCenter,
          normalColor: colors.alternativeForegroundColor,
          highlightColor: colors.alternativeHighlightedForegroundColor,
        }, isDark),
      },
    }
    else if showSchemaName then {
      text: schemaNameText,
      systemImageName: null,
      fontSize: fonts.systemButtonTextFontSize,
    }
    else {});

local rimeSchemaChangedNotification =
  {
    [if settings.spaceButtonSchemaNameCenter != null then 'rimeSchemaChangedNotification']: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      backgroundStyle: alphabeticButtonBackgroundStyleName,
      foregroundStyle: spaceButtonForegroundStyle,
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

  newSystemButtonForegroundStyle: newSystemButtonForegroundStyle,

  spaceButtonForegroundStyle: spaceButtonForegroundStyle,
  newSpaceButtonForegroundStyle: newSpaceButtonForegroundStyle,

  newClassifiedCollection: newClassifiedCollection,
  newSubClassifiedCollection: newSubClassifiedCollection,

  // notification
  rimeSchemaChangedNotification: rimeSchemaChangedNotification,
}
