local buttons = import '../Buttons/LayoutSigma.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local firstRowStyle = {
  local this = self,
  name: 'firstRowStyle',
  style: {
    [this.name]: {
      size: {
        height: { percentage: 0.25 },
      },
    },
  },
};

local secondRowStyle = {
  local this = self,
  name: 'secondRowStyle',
  style: {
    [this.name]: {
      size: {
        height: { percentage: 0.27 },
      },
    },
  },
};

local thirdRowStyle = {
  local this = self,
  name: 'thirdRowStyle',
  style: {
    [this.name]: {
      size: {
        height: { percentage: 0.25 },
      },
    },
  },
};

local fourthRowStyle = {
  local this = self,
  name: 'fourthRowStyle',
  style: {
    [this.name]: {
      size: {
        height: { percentage: 0.23 },
      },
    },
  },
};

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        style: firstRowStyle.name,
        subviews: [
          { Cell: buttons.qButton.name },
          { Cell: buttons.tButton.name },
          { Cell: buttons.lButton.name },
          { Cell: buttons.nButton.name },
          { Cell: buttons.cButton.name },
        ],
      },
    },
    {
      HStack: {
        style: secondRowStyle.name,
        subviews: [
          { Cell: buttons.jButton.name },
          { Cell: buttons.eButton.name },
          { Cell: buttons.oButton.name },
          { Cell: buttons.yButton.name },
          { Cell: buttons.zButton.name },
        ],
      },
    },
    {
      HStack: {
        style: thirdRowStyle.name,
        subviews: [
          { Cell: buttons.xButton.name },
          { Cell: buttons.wButton.name },
          { Cell: buttons.aButton.name },
          { Cell: buttons.sButton.name },
        ],
      },
    },
    {
      HStack: {
        style: fourthRowStyle.name,
        subviews: [
          { Cell: commonButtons.enterButton.name },
          { Cell: commonButtons.commaButton.name },
          { Cell: commonButtons.spaceButton.name },
          { Cell: buttons.alphabeticButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
  ],
};

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.qButton.name]: { size: { width: { percentage: 0.18 } } },
    [buttons.tButton.name]: { size: { width: { percentage: 0.23 } } },
    [buttons.lButton.name]: { size: { width: { percentage: 0.18 } } },
    [buttons.nButton.name]: { size: { width: { percentage: 0.23 } } },
    [buttons.cButton.name]: { size: { width: { percentage: 0.18 } } },

    [buttons.jButton.name]: { size: { width: { percentage: 0.16 } } },
    [buttons.eButton.name]: { size: { width: { percentage: 0.20 } } },
    [buttons.oButton.name]: { size: { width: { percentage: 0.28 } } },
    [buttons.yButton.name]: { size: { width: { percentage: 0.20 } } },
    [buttons.zButton.name]: { size: { width: { percentage: 0.16 } } },

    [buttons.xButton.name]: { size: { width: { percentage: 0.22 } } },
    [buttons.wButton.name]: { size: { width: { percentage: 0.28 } } },
    [buttons.aButton.name]: { size: { width: { percentage: 0.28 } } },
    [buttons.sButton.name]: { size: { width: { percentage: 0.22 } } },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    {}
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
        getAlphabeticButtonSize(button.name) + button.params + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText,
        needHint=false),
      buttons.letterButtons,
      {})

  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    { size: { width: { percentage: 0.2 } } }
    + commonButtons.enterButton.params
  )

  + basicStyle.newAlphabeticButton(
    buttons.commaButton.name,
    isDark,
    { size: { width: { percentage: 0.12 } } }
    + buttons.commaButton.params + basicStyle.hintStyleSize,
    swipeTextFollowSetting=false,
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    basicStyle.newSpaceButtonForegroundStyle(commonButtons.spaceButton.params, '$rimeSchemaName', isDark),
    needHint=false,
  )
  + basicStyle.newSystemButton(
    buttons.alphabeticButton.name,
    isDark,
    { size: { width: { percentage: 0.12 } } }
    + buttons.alphabeticButton.params
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    { size: { width: { percentage: 0.22 } } }
    + commonButtons.backspaceButton.params,
  )
;

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 3, left: 3, bottom: 3, right: 3 },
  landscape: { top: 2, left: 3, bottom: 2, right: 3 },
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
    + firstRowStyle.style
    + secondRowStyle.style
    + thirdRowStyle.style
    + fourthRowStyle.style
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
