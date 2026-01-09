local params = import '../Constants/Keyboard.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

local hintStyle = {
  hintStyle: {
    size: { width: self.height, height: params.toolbar.height },
  },
};

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
  };

// 标准26键布局
local rows = [
  [
    params.keyboard.qButton,
    params.keyboard.wButton,
    params.keyboard.eButton,
    params.keyboard.rButton,
    params.keyboard.tButton,
    params.keyboard.yButton,
    params.keyboard.uButton,
    params.keyboard.iButton,
    params.keyboard.oButton,
    params.keyboard.pButton,
  ],
  [
    params.keyboard.aButton,
    params.keyboard.sButton,
    params.keyboard.dButton,
    params.keyboard.fButton,
    params.keyboard.gButton,
    params.keyboard.hButton,
    params.keyboard.jButton,
    params.keyboard.kButton,
    params.keyboard.lButton,
  ],
  [
    params.keyboard.shiftButton,
    params.keyboard.zButton,
    params.keyboard.xButton,
    params.keyboard.cButton,
    params.keyboard.vButton,
    params.keyboard.bButton,
    params.keyboard.nButton,
    params.keyboard.mButton,
    params.keyboard.backspaceButton,
  ],
  [
    params.keyboard.numericButton,
  ]
  + (
    if settings.showFunctionButton then
      [params.keyboard.functionButton]
    else
      []
  )
  +
  [
    params.keyboard.commaButton,
    params.keyboard.spaceButton,
    params.keyboard.asciiModeButton,
    params.keyboard.enterButton,
  ],
];

local getAlphabeticButtonSize(name) =
  local extra = {
    [params.keyboard.aButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'right' },
    },
    [params.keyboard.lButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );


local newKeyLayout(isDark=false, isPortrait=true) =
  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;
  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getAlphabeticButtonSize(button.name) + button.params + hintStyle + alphabeticTextCenterWhenShowSwipeText +
        (
          if settings.uppercaseForChinese then
            basicStyle.newAlphabeticButtonUppercaseForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params.uppercased)
            + {
              [if settings.uppercaseForChinese then 'whenAsciiModeOn']: basicStyle.newAlphabeticButtonForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params),
            }
          else {}
        )
        ,
        swipeTextFollowSetting=true),
      params.keyboard.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    params.keyboard.shiftButton.name,
    isDark,
    (
      if settings.usePCLayout then portraitNormalButtonSize else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'left' },
      }
    )
    + params.keyboard.shiftButton.params
  )

  + basicStyle.newSystemButton(
    params.keyboard.backspaceButton.name,
    isDark,
    (
      if settings.usePCLayout then
      {
        size: { width: '225/1125' },
      }
      else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'right' },
      }
    )
    + params.keyboard.backspaceButton.params,
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    params.keyboard.numericButton.name,
    isDark,
    (
      if settings.showFunctionButton then
        { size: { width: '191.25/1125' } }
      else
        { size: { width: '225/1125' } }
    )
    + params.keyboard.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    params.keyboard.commaButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.commaButton.params + hintStyle
  )
  + (
    if settings.showFunctionButton then
      basicStyle.newAlphabeticButton(
        params.keyboard.functionButton.name,
        isDark,
        portraitNormalButtonSize + params.keyboard.functionButton.params + hintStyle
      )
    else
      {}
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle(isDark),
    }
    + params.keyboard.spaceButton.params,
    needHint=false,
  )
  + basicStyle.newSystemButton(
    params.keyboard.asciiModeButton.name,
    isDark,
    portraitNormalButtonSize
    + params.keyboard.asciiModeButton.params
  )
  + basicStyle.newColorButton(
    params.keyboard.enterButton.name,
    isDark,
    {
      size: { width: '250/1125' },
    } + params.keyboard.enterButton.params
  )
;

{
  new(isDark, isPortrait):
    local insets = if isPortrait then params.keyboard.button.backgroundInsets.iPhone.portrait else params.keyboard.button.backgroundInsets.iPhone.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait)
    // Notifications
    + basicStyle.rimeSchemaChangedNotification,
}
