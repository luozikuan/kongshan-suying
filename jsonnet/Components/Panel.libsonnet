local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';


local panelKeyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          {
            Cell: params.toolbarButton.toolbarHamster3Button.name,
          },
          {
            Cell: params.toolbarButton.toolbarCheckUpdateButton.name,
          },
          {
            Cell: params.toolbarButton.toolbarFeedbackButton.name,
          },
          {
            Cell: params.toolbarButton.toolbarFinderButton.name,
          },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          {
            Cell: params.toolbarButton.toolbarSkinButton.name,
          },
          {
            Cell: params.toolbarButton.toolbarUploadButton.name,
          },
          {
            Cell: params.toolbarButton.toolbarDeployButton.name,
          },
          {
            Cell: params.toolbarButton.toolbarToggleEmbeddedButton.name,
          }
        ],
      },
    }
  ]
};

local newKeyLayout(isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then params.floatingKeyboard.floatTargetScale.portrait else params.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: params.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName)
  }
  + panelKeyboardLayout
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarHamster3Button.name,
    isDark,
    params.toolbarButton.toolbarHamster3Button.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarCheckUpdateButton.name,
    isDark,
    params.toolbarButton.toolbarCheckUpdateButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarFeedbackButton.name,
    isDark,
    params.toolbarButton.toolbarFeedbackButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarFinderButton.name,
    isDark,
    params.toolbarButton.toolbarFinderButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarSkinButton.name,
    isDark,
    params.toolbarButton.toolbarSkinButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarUploadButton.name,
    isDark,
    params.toolbarButton.toolbarUploadButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarDeployButton.name,
    isDark,
    params.toolbarButton.toolbarDeployButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    params.toolbarButton.toolbarToggleEmbeddedButton.name,
    isDark,
    params.toolbarButton.toolbarToggleEmbeddedButton.params
  );

{
  new(isDark=false, isPortrait=false):
    basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
    + newKeyLayout(isDark, isPortrait)
}
