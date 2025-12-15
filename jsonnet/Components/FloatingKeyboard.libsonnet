local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';

local floatingKeyboardButtonsDefine = {
  // 浮动键盘面板按钮定义，格式如下：

  // 第一个浮动键盘名称: [
  //    [按钮行1],
  //    [按钮行2],
  // ],
  // 第二个浮动键盘名称: [
  //    [按钮行1],
  //    [按钮行2],
  // ],

  panel: [
    [
      params.toolbarButton.toolbarHamster3Button,
      params.toolbarButton.toolbarFeedbackButton,
      params.toolbarButton.toolbarCheckUpdateButton,
      params.toolbarButton.toolbarFinderButton,
    ],
    [
      params.toolbarButton.toolbarSkinButton,
      params.toolbarButton.toolbarUploadButton,
      params.toolbarButton.toolbarRimeDeployButton,
      params.toolbarButton.toolbarToggleEmbeddedButton,
    ],
  ],
};

local newKeyLayout(buttonsInRow, isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then params.floatingKeyboard.floatTargetScale.portrait else params.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: params.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(buttonsInRow)
  + std.foldl(function(acc, button) acc +
      basicStyle.newFloatingKeyboardButton(button.name, isDark, button.params),
      std.flattenArrays(buttonsInRow),
      {});

local newFloatingKeyboard(buttonsInRow, isDark=false, isPortrait=false) =
  basicStyle.newKeyboardBackgroundStyle(isDark)
  + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
  + newKeyLayout(buttonsInRow, isDark, isPortrait);

{
  new(isDark=false, isPortrait=false):
    {
      [name]: newFloatingKeyboard(floatingKeyboardButtonsDefine[name], isDark, isPortrait)
      for name in std.objectFields(floatingKeyboardButtonsDefine)
    }
}
