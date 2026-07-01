local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local basicStyle = import '../Styles/BasicStyle.libsonnet';
local utils = import '../Utils/Utils.libsonnet';

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: toolbarParams.toolbarButton.toolbarHamster3Button.name },
          { Cell: toolbarParams.toolbarButton.toolbarKeyboardDefinition.name },
          { Cell: toolbarParams.toolbarButton.toolbarFeedbackButton.name },
          { Cell: toolbarParams.toolbarButton.toolbarCheckUpdateButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: toolbarParams.toolbarButton.toolbarSkinButton.name },
          { Cell: toolbarParams.toolbarButton.toolbarSkinPreference.name },
          { Cell: toolbarParams.toolbarButton.toolbarUploadButton.name },
          { Cell: toolbarParams.toolbarButton.toolbarToggleEmbeddedButton.name },
        ],
      },
    },
  ],
};

local newKeyLayout(isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then toolbarParams.floatingKeyboard.floatTargetScale.portrait else toolbarParams.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: toolbarParams.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout
  + std.foldl(function(acc, button) acc +
      basicStyle.newFloatingKeyboardButton(button.name, isDark, button.params),
      [
        toolbarParams.toolbarButton.toolbarHamster3Button,
        toolbarParams.toolbarButton.toolbarKeyboardDefinition,
        toolbarParams.toolbarButton.toolbarFeedbackButton,
        toolbarParams.toolbarButton.toolbarCheckUpdateButton,
        toolbarParams.toolbarButton.toolbarSkinButton,
        toolbarParams.toolbarButton.toolbarSkinPreference,
        toolbarParams.toolbarButton.toolbarUploadButton,
        toolbarParams.toolbarButton.toolbarToggleEmbeddedButton,
      ],
      {});

{
  new(isDark=false, isPortrait=false):
    basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
    + newKeyLayout(isDark, isPortrait),
}
