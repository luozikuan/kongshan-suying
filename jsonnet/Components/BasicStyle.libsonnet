local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local keyboardParams = import '../Constants/Keyboard.libsonnet';
local settings = import '../Constants/Settings.libsonnet';
local utils = import 'Utils.libsonnet';

local buttonCornerRadius = 8.5;

local swipeTextCenter = {
  up: { x: 0.28, y: 0.28 },
  down: { x: 0.72, y: 0.28 },
};

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
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
  else
    utils.newTextStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonTextFontSize,
    } + alphabeticTextCenterWhenShowSwipeText
      + params, isDark) + getKeyboardActionText(params);

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

// 大写字母键按钮前景样式
local newAlphabeticButtonUppercaseForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.standardButtonForegroundColor,
    highlightColor: colors.standardButtonHighlightedForegroundColor,
    fontSize: fonts.standardButtonUppercasedTextFontSize,
  } + alphabeticTextCenterWhenShowSwipeText
    + params, isDark);

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

local enterButtonForegroundStyleName = 'enterButtonForegroundStyle';
local newEnterButtonForegroundStyle(isDark=false, params={}) = {
  [enterButtonForegroundStyleName]: utils.newTextStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + getKeyboardActionText(params),
};

// 中英切换键按钮前景样式
local asciiModeButtonForegroundStyleName = 'asciiModeButtonForegroundStyle';
local newAsciiModeButtonForegroundStyle(isDark=false, params={}) = {
  [asciiModeButtonForegroundStyleName]: utils.newAssetImageStyle({
      assetImageName: 'chineseState2',
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    } + params, isDark) + getKeyboardActionText(params),
};

local asciiModeButtonEnglishStateForegroundStyleName = 'asciiModeButtonEnglishStateForegroundStyle';
local newAsciiModeButtonEnglishStateForegroundStyle(isDark=false, params={}) = {
  [asciiModeButtonEnglishStateForegroundStyleName]: utils.newAssetImageStyle({
      assetImageName: 'englishState2',
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonImageFontSize,
    } + params, isDark) + getKeyboardActionText(params),
};

local asciiModeButtonForegroundStyle = [
  {
    styleName: asciiModeButtonForegroundStyleName,
    conditionKey: 'rime$ascii_mode',
    conditionValue: false,
  },
  {
    styleName: asciiModeButtonEnglishStateForegroundStyleName,
    conditionKey: 'rime$ascii_mode',
    conditionValue: true,
  },
];

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

// 蓝色功能键按钮背景样式
local blueButtonBackgroundStyleName = 'blueButtonBackgroundStyle';
local newBlueButtonBackgroundStyle(isDark=false, params={}) = {
  [blueButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.blueButtonBackgroundColor,
    highlightColor: colors.blueButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

local blueButtonForegroundStyleName = 'blueButtonForegroundStyle';
local newBlueButtonForegroundStyle(isDark=false, params={}) = {
  [blueButtonForegroundStyleName]: utils.newTextStyle({
    normalColor: colors.blueButtonForegroundColor,
    highlightColor: colors.blueButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + getKeyboardActionText(params),
};

local enterButtonBackgroundStyle = [
  {
    styleName: systemButtonBackgroundStyleName,
    conditionKey: '$returnKeyType',
    conditionValue: [0, 2, 3, 5, 6, 8, 11],
  },
  {
    styleName: blueButtonBackgroundStyleName,
    conditionKey: '$returnKeyType',
    conditionValue: [1, 4, 7, 9, 10],
  },
];

local enterButtonForegroundStyle = [
  {
    styleName: enterButtonForegroundStyleName,
    conditionKey: '$returnKeyType',
    conditionValue: [0, 2, 3, 5, 6, 8, 11],
  },
  {
    styleName: blueButtonForegroundStyleName,
    conditionKey: '$returnKeyType',
    conditionValue: [1, 4, 7, 9, 10],
  },
];

// 文本文字系统功能键按钮前景样式
local newTextSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark);

local newImageSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newSystemImageStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonImageFontSize,
  } + params, isDark);


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

local toolbarSlideButtonsName = 'toolbarSlideButtons';
local newToolbarSlideButtons(buttons, isDark=false) =
  local rightToLeft = std.length(buttons) < settings.toolbarButtonsMaxCount;
  {
    [toolbarSlideButtonsName]: {
      type: 'horizontalSymbols',
      size: { width: '%d/%d' % [settings.toolbarButtonsMaxCount, settings.toolbarButtonsMaxCount + 2] },
      maxColumns: settings.toolbarButtonsMaxCount,
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
      [button.name + 'ForegroundStyle']: utils.newSystemImageStyle({
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.toolbarButtonImageFontSize,
      } + button.params, isDark),
    },
    buttons,
    {}
  );

local newToolbarButton(name, isDark=false, params={}) =
  {
    [name]: utils.newForegroundStyle(style=name + 'ForegroundStyle')
            + utils.extractProperties(
              params,
              [
                'action',
                'size',
              ]
            ),
    [name + 'ForegroundStyle']:
      utils.newSystemImageStyle({
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.toolbarButtonImageFontSize,
      } + params, isDark),
  };

local newAlphabeticButton(name, isDark=false, params={}, needHint=false) =
  local swipeUpStyle = if std.objectHas(params, 'swipeUp') && settings.showSwipeUpText then [name + 'SwipeUpForegroundStyle'] else [];
  local swipeDownStyle = if std.objectHas(params, 'swipeDown') && settings.showSwipeDownText then [name + 'SwipeDownForegroundStyle'] else [];
  {
    [name]: utils.newBackgroundStyle(style=alphabeticButtonBackgroundStyleName)
            + (
              if std.objectHas(params, 'foregroundStyleName') then
                { foregroundStyle: params.foregroundStyleName }
              else
                utils.newForegroundStyle(style=[name + 'ForegroundStyle'] + swipeUpStyle + swipeDownStyle)
            )
            + (
              if std.objectHas(params, 'uppercasedStateAction') then
                utils.newForegroundStyle('uppercasedStateForegroundStyle', [name + 'UppercaseForegroundStyle'] + swipeUpStyle + swipeDownStyle)
              else {}
            )
            + (
              if needHint then
                utils.newForegroundStyle('hintStyle', name + 'HintStyle')
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
  + (
    if std.objectHas(params, 'foregroundStyle') then
      params.foregroundStyle
    else
      { [name + 'ForegroundStyle']: newAlphabeticButtonForegroundStyle(isDark, params) }
  )
  + (
    if std.objectHas(params, 'swipeUp') && settings.showSwipeUpText then
      {
        [name + 'SwipeUpForegroundStyle']: newAlphabeticButtonAlternativeForegroundStyle(isDark,
          { center: swipeTextCenter.up } + params.swipeUp),
      }
    else {}
  )
  + (
    if std.objectHas(params, 'swipeDown') && settings.showSwipeDownText then
      {
        [name + 'SwipeDownForegroundStyle']: newAlphabeticButtonAlternativeForegroundStyle(isDark,
          { center: swipeTextCenter.down } + params.swipeDown),
      }
    else {}
  )
  + (
    if std.objectHas(params, 'uppercasedStateAction') then
      {
        [name + 'UppercaseForegroundStyle']: newAlphabeticButtonUppercaseForegroundStyle(isDark, params) + getKeyboardActionText(params, 'uppercasedStateAction'),
      }
    else {}
  )
  + (
    if needHint then
      {

        [name + 'HintStyle']:
          (
            if std.objectHas(params, 'hintStyle') then
              params.hintStyle
            else
              {}
          )
          + utils.newBackgroundStyle(style=alphabeticHintBackgroundStyleName)
          + utils.newForegroundStyle(style=name + 'HintForegroundStyle'),
        [name + 'HintForegroundStyle']: newAlphabeticButtonHintStyle(isDark, params) + getKeyboardActionText(params, isUppercase=true),
      }
    else
      {}
  );

local newSystemButton(name, isDark=false, params={}) =
  {
    [name]: (
              if std.objectHas(params, 'backgroundStyle') then
                { backgroundStyle: params.backgroundStyle }
              else
                utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)
            )
            + (
              if std.objectHas(params, 'foregroundStyle') then
                { foregroundStyle: params.foregroundStyle }
              else
                utils.newForegroundStyle(style=name + 'ForegroundStyle')
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
            + utils.extractProperties(
              params,
              [
                'size',
                'bounds',
                'action',
                'uppercasedStateAction',
                'repeatAction',
                'preeditStateAction',
                'uppercasedStateForegroundStyle',
                'capsLockedStateForegroundStyle',
                'preeditStateForegroundStyle',
                'notification',
              ]
            ),
  }
  + {
    [name + 'ForegroundStyle']: (
      if std.objectHas(params, 'systemImageName') then
        newImageSystemButtonForegroundStyle(isDark, params)
      else
        newTextSystemButtonForegroundStyle(isDark, params) + getKeyboardActionText(params)
    ),
  };

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
                'useRimeEngine',
              ]
            ),
    [name + 'CellStyle']:
            // utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)+
            utils.newForegroundStyle(style=name + 'CellForegroundStyle'),
    [name + 'CellForegroundStyle']: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.systemButtonTextFontSize,
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


local asciiModeChangedNotification = {
  asciiModeChangedNotification: {
    notificationType: 'rime',
    rimeNotificationType: 'optionChanged',
    rimeOptionName: 'ascii_mode',
    rimeOptionValue: [true, false],
    foregroundStyle: asciiModeButtonForegroundStyle,
  },
};

local returnKeyboardTypeChangedNotification = {
  returnKeyTypeChangedNotification: {
    notificationType: 'returnKeyType',
    returnKeyType: [1, 4, 7],
    backgroundStyle: blueButtonBackgroundStyleName,
    foregroundStyle: blueButtonForegroundStyleName,
  },
};

local preeditChangedForEnterButtonNotification = {
  preeditChangedForEnterButtonNotification: {
    notificationType: 'preeditChanged',
    backgroundStyle: enterButtonBackgroundStyle,
    foregroundStyle: enterButtonForegroundStyle,
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
  keyboardBackgroundStyleName: keyboardBackgroundStyleName,
  newKeyboardBackgroundStyle: newKeyboardBackgroundStyle,

  floatingKeyboardButtonBackgroundStyleName: floatingKeyboardButtonBackgroundStyleName,
  newFloatingKeyboardButtonBackgroundStyle: newFloatingKeyboardButtonBackgroundStyle,

  buttonAnimationName: buttonAnimationName,
  newButtonAnimation: newButtonAnimation,

  alphabeticButtonBackgroundStyleName: alphabeticButtonBackgroundStyleName,
  newAlphabeticButtonBackgroundStyle: newAlphabeticButtonBackgroundStyle,

  newAlphabeticButtonForegroundStyle: newAlphabeticButtonForegroundStyle,

  newAlphabeticButtonUppercaseForegroundStyle: newAlphabeticButtonUppercaseForegroundStyle,

  alphabeticHintBackgroundStyleName: alphabeticHintBackgroundStyleName,
  newAlphabeticHintBackgroundStyle: newAlphabeticHintBackgroundStyle,

  newAlphabeticButtonHintStyle: newAlphabeticButtonHintStyle,

  systemButtonBackgroundStyleName: systemButtonBackgroundStyleName,
  newSystemButtonBackgroundStyle: newSystemButtonBackgroundStyle,

  blueButtonBackgroundStyleName: blueButtonBackgroundStyleName,
  newBlueButtonBackgroundStyle: newBlueButtonBackgroundStyle,

  blueButtonForegroundStyleName: blueButtonForegroundStyleName,
  newBlueButtonForegroundStyle: newBlueButtonForegroundStyle,

  newTextSystemButtonForegroundStyle: newTextSystemButtonForegroundStyle,
  newImageSystemButtonForegroundStyle: newImageSystemButtonForegroundStyle,

  newFloatingKeyboardButton: newFloatingKeyboardButton,
  toolbarSlideButtonsName: toolbarSlideButtonsName,
  newToolbarSlideButtons: newToolbarSlideButtons,
  newToolbarButton: newToolbarButton,

  newAlphabeticButton: newAlphabeticButton,

  newSystemButton: newSystemButton,

  newSymbolicCollection: newSymbolicCollection,

  newSpaceButton: newSpaceButton,
  spaceButtonForegroundStyle: spaceButtonForegroundStyle,
  spaceButtonRimeSchemaForegroundStyleName: spaceButtonRimeSchemaForegroundStyleName,
  newSpaceButtonRimeSchemaForegroundStyle: newSpaceButtonRimeSchemaForegroundStyle,

  asciiModeButtonForegroundStyleName: asciiModeButtonForegroundStyleName,
  newAsciiModeButtonForegroundStyle: newAsciiModeButtonForegroundStyle,
  asciiModeButtonEnglishStateForegroundStyleName: asciiModeButtonEnglishStateForegroundStyleName,
  newAsciiModeButtonEnglishStateForegroundStyle: newAsciiModeButtonEnglishStateForegroundStyle,
  asciiModeButtonForegroundStyle: asciiModeButtonForegroundStyle,

  enterButtonBackgroundStyle: enterButtonBackgroundStyle,
  enterButtonForegroundStyle: enterButtonForegroundStyle,
  newEnterButtonForegroundStyle: newEnterButtonForegroundStyle,
  newCommitCandidateForegroundStyle: newCommitCandidateForegroundStyle,

  // notification
  rimeSchemaChangedNotification: rimeSchemaChangedNotification,
  asciiModeChangedNotification: asciiModeChangedNotification,
  returnKeyboardTypeChangedNotification: returnKeyboardTypeChangedNotification,
  preeditChangedForEnterButtonNotification: preeditChangedForEnterButtonNotification,
  preeditChangedForSpaceButtonNotification: preeditChangedForSpaceButtonNotification,
}
