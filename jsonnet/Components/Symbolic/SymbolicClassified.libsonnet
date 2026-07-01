local symbolicButtons = import '../../Buttons/LayoutSymbolicClassified.libsonnet';
local commonButtons = import '../../Buttons/Common.libsonnet';
local basicStyle = import '../../Styles/BasicStyle.libsonnet';
local preedit = import '../Preedit.libsonnet';
local toolbar = import '../Toolbar.libsonnet';
local toolbarParams = import '../../Buttons/Toolbar.libsonnet';
local utils = import '../../Utils/Utils.libsonnet';

local lastRowHStackStyle = {
  local this = self,
  name: 'lastRowHStackStyle',
  style: {
    [this.name]: {
      size: {
        height: '1/5',
      },
    },
  },
};

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: symbolicButtons.categoryCollection.name },
          { Cell: symbolicButtons.descriptionCollection.name },
        ],
      },
    },
    {
      HStack: {
        style: lastRowHStackStyle.name,
        subviews: [
          { Cell: commonButtons.gotoPrimaryKeyboardButton.name },
          { Cell: symbolicButtons.pageUp.name },
          { Cell: symbolicButtons.pageDown.name },
          { Cell: symbolicButtons.lockButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
  ],
};

local newKeyLayout(isDark=false, isPortrait=true, extraParams={}) =
  {
    keyboardHeight: toolbarParams.toolbar.height
      + if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout

  // Collection cells
  + basicStyle.newClassifiedCollection(
      symbolicButtons.categoryCollection.name, isDark, isPortrait,
      (if isPortrait then { size: { width: '1/5' } } else { size: { width: '1/8' } })
      + symbolicButtons.categoryCollection.params
      + extraParams)
  + basicStyle.newSubClassifiedCollection(
      symbolicButtons.descriptionCollection.name, isDark, isPortrait,
      symbolicButtons.descriptionCollection.params
      + extraParams)

  + symbolicButtons.dataSource

  // System buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(button.name, isDark, button.params),
    [
      symbolicButtons.pageUp,
      symbolicButtons.pageDown,
      commonButtons.backspaceButton,
    ],
    basicStyle.newSystemButton(
      symbolicButtons.lockButton.name,
      isDark,
      symbolicButtons.lockButton.params + {
        foregroundStyle: {
          unlockButtonForegroundStyle: basicStyle.newSystemButtonForegroundStyle(isDark, { systemImageName: 'lock.open' }),
          lockButtonForegroundStyle: basicStyle.newSystemButtonForegroundStyle(isDark, { systemImageName: 'lock' }),
        },
      }))

  + basicStyle.newColorButton(
    commonButtons.gotoPrimaryKeyboardButton.name,
    isDark,
    commonButtons.gotoPrimaryKeyboardButton.params
  );

{
  new(isDark, isPortrait):
    local insets = if isPortrait then commonButtons.backgroundInsets.portrait else commonButtons.backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    // + toolbar.new(isDark, isPortrait, 'symbolic')
    + lastRowHStackStyle.style
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait, extraParams),
}
