local buttons = import '../Buttons/LayoutBopomofo.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '3/33' },
};

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: buttons.bpmfOneButton.name },
          { Cell: buttons.bpmfTwoButton.name },
          { Cell: buttons.bpmfThreeButton.name },
          { Cell: buttons.bpmfFourButton.name },
          { Cell: buttons.bpmfFiveButton.name },
          { Cell: buttons.bpmfSixButton.name },
          { Cell: buttons.bpmfSevenButton.name },
          { Cell: buttons.bpmfEightButton.name },
          { Cell: buttons.bpmfNineButton.name },
          { Cell: buttons.bpmfZeroButton.name },
          { Cell: buttons.bpmfDashButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.qButton.name },
          { Cell: buttons.wButton.name },
          { Cell: buttons.eButton.name },
          { Cell: buttons.rButton.name },
          { Cell: buttons.tButton.name },
          { Cell: buttons.yButton.name },
          { Cell: buttons.uButton.name },
          { Cell: buttons.iButton.name },
          { Cell: buttons.oButton.name },
          { Cell: buttons.pButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.aButton.name },
          { Cell: buttons.sButton.name },
          { Cell: buttons.dButton.name },
          { Cell: buttons.fButton.name },
          { Cell: buttons.gButton.name },
          { Cell: buttons.hButton.name },
          { Cell: buttons.jButton.name },
          { Cell: buttons.kButton.name },
          { Cell: buttons.lButton.name },
          { Cell: buttons.bpmfSemicolonButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.zButton.name },
          { Cell: buttons.xButton.name },
          { Cell: buttons.cButton.name },
          { Cell: buttons.vButton.name },
          { Cell: buttons.bButton.name },
          { Cell: buttons.nButton.name },
          { Cell: buttons.mButton.name },
          { Cell: buttons.bpmfCommaButton.name },
          { Cell: buttons.bpmfPeriodButton.name },
          { Cell: buttons.bpmfSlashButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.numericButton.name },
          { Cell: buttons.commaButton.name },
          { Cell: buttons.spaceButton.name },
          { Cell: commonButtons.alphabeticButton.name },
          { Cell: buttons.enterButton.name },
        ],
      },
    },
  ],
};

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.qButton.name]: {
      size:
        { width: '4/33' },
      bounds:
        { width: '3/4', alignment: 'right' },
    },
    [buttons.pButton.name]: {
      size:
        { width: '5/33' },
      bounds:
        { width: '3/5', alignment: 'left' },
    },
    [buttons.aButton.name]: {
      size:
        { width: '5/33' },
      bounds:
        { width: '3/5', alignment: 'right' },
    },
    [buttons.bpmfSemicolonButton.name]: {
      size:
        { width: '4/33' },
      bounds:
        { width: '3/4', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );

local newKeyLayout(isDark=false, isPortrait=true) =
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getAlphabeticButtonSize(button.name) + button.params + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText),
      buttons.letterButtons,
      {})

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    portraitNormalButtonSize
    + commonButtons.backspaceButton.params,
  )

  // Last Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: { percentage: 0.2 } } }
    + commonButtons.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    buttons.commaButton.name,
    isDark,
    { size: { width: { percentage: 0.1 } } }
    + buttons.commaButton.params + basicStyle.hintStyleSize,
    swipeTextFollowSetting=false,
  )
  + basicStyle.newAlphabeticButton(
    buttons.spaceButton.name,
    isDark,
    basicStyle.newSpaceButtonForegroundStyle(buttons.spaceButton.params, '$rimeSchemaName', isDark),
    needHint=false,
  )
  +
  basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark,
    { size: { width: { percentage: 0.1 } } }
    + commonButtons.alphabeticButton.params
  )
  + basicStyle.newColorButton(
    buttons.enterButton.name,
    isDark,
    { size: { width: { percentage: 0.22 } } }
    + buttons.enterButton.params
  )
;

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 3, left: 2, bottom: 3, right: 2 },
  landscape: { top: 2, left: 2, bottom: 2, right: 2 },
}
else
{
  portrait: { top: 3, left: 3, bottom: 3, right: 3 },
  landscape: { top: 4, left: 6, bottom: 4, right: 6 },
};

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

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
    + basicStyle.rimeSchemaChangedNotification
    + basicStyle.returnKeyTypeChangedNotification,
}
