local numericButtons = import '../Buttons/LayoutNumeric.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';
local settings = import '../Settings.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

local keyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.numericSymbolsCollection.name, },
          { Cell: commonButtons.gotoPrimaryKeyboardButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.oneButton.name, },
          { Cell: numericButtons.fourButton.name, },
          { Cell: numericButtons.sevenButton.name, },
          { Cell: numericButtons.numericSpaceButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.twoButton.name, },
          { Cell: numericButtons.fiveButton.name, },
          { Cell: numericButtons.eightButton.name, },
          { Cell: numericButtons.zeroButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.threeButton.name, },
          { Cell: numericButtons.sixButton.name, },
          { Cell: numericButtons.nineButton.name, },
          { Cell: numericButtons.dotButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.aHexButton.name, },
          { Cell: numericButtons.cHexButton.name, },
          { Cell: numericButtons.eHexButton.name, },
          { Cell: numericButtons.backSlashHexButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: numericButtons.bHexButton.name, },
          { Cell: numericButtons.dHexButton.name, },
          { Cell: numericButtons.fHexButton.name, },
          { Cell: numericButtons.xHexButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          { Cell: commonButtons.backspaceButton.name, },
          { Cell: numericButtons.numericEqualButton.name, },
          { Cell: numericButtons.numericColonButton.name, },
          { Cell: commonButtons.enterButton.name, },
        ],
      },
    },
  ],
};

local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        {
          fontSize: fonts.numericButtonTextFontSize,
        }
        + button.params + basicStyle.hintStyleSize
        + (
          if utils.numericActionNeedSymbol(settings.keyboardLayout) then
          {
            action: utils.replaceCharacterToSymbolRecursive(button.params.action),
            whenPreeditChanged: {
              action: button.params.action,
            },
          }
          else {}
        ),
        needHint=false,
      ),
    numericButtons.numericButtons + [
      numericButtons.aHexButton,
      numericButtons.bHexButton,
      numericButtons.cHexButton,
      numericButtons.dHexButton,
      numericButtons.eHexButton,
      numericButtons.fHexButton,
    ],
    {})
  + {
    [numericButtons.numericSymbolsCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + numericButtons.numericSymbolsCollection.params + extraParams,
  }
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        button.params
      ),
    [
      numericButtons.numericSpaceButton,
      numericButtons.dotButton,
      numericButtons.backSlashHexButton,
      numericButtons.xHexButton,
      commonButtons.backspaceButton,
      numericButtons.numericEqualButton,
      numericButtons.numericColonButton,
      commonButtons.enterButton,
    ],
    basicStyle.newColorButton(
        commonButtons.gotoPrimaryKeyboardButton.name,
        isDark,
        commonButtons.gotoPrimaryKeyboardButton.params + {
          size: { height: '1/4' },
        }
      ));

{
  new(isDark, isPortrait):
    local insets = if isPortrait then commonButtons.backgroundInsets.portrait else commonButtons.backgroundInsets.landscape;

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
    + newKeyLayout(isDark, isPortrait, extraParams)
    // Notifications
}
