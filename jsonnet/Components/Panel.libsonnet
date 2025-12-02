local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';

local rows = [
  [
    params.toolbarButton.toolbarHamster3Button,
    params.toolbarButton.toolbarFeedbackButton,
    params.toolbarButton.toolbarCheckUpdateButton,
    params.toolbarButton.toolbarFinderButton,
  ],
  [
    params.toolbarButton.toolbarSkinButton,
    params.toolbarButton.toolbarUploadButton,
    params.toolbarButton.toolbarDeployButton,
    params.toolbarButton.toolbarToggleEmbeddedButton,
  ],
];

local newKeyLayout(isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then params.floatingKeyboard.floatTargetScale.portrait else params.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: params.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)
  + std.foldl(function(acc, button) acc +
      basicStyle.newFloatingKeyboardButton(button.name, isDark, button.params),
      std.flattenArrays(rows),
      {});

{
  new(isDark=false, isPortrait=false):
    basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
    + newKeyLayout(isDark, isPortrait)
}
