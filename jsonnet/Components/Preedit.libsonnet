local colors = import '../Constants/Colors.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local basicStyle = import '../Styles/BasicStyle.libsonnet';
local utils = import '../Utils/Utils.libsonnet';

local preeditBackgroundStyleName = basicStyle.keyboardBackgroundStyleName;
local preeditForegroundStyleName = 'preeditForegroundStyle';

local newPreedit(isDark=false, params={}) = {
  preeditHeight: toolbarParams.preedit.height,
  preeditStyle: {
             insets: toolbarParams.preedit.insets,
           }
           + utils.newBackgroundStyle(style=preeditBackgroundStyleName)
           + utils.newForegroundStyle(style=preeditForegroundStyleName)
           + params,
  [preeditForegroundStyleName]: utils.newTextStyle({
    normalColor: colors.preeditForegroundColor,
    fontSize: toolbarParams.preedit.fontSize,
  }, isDark),
};

{
  new: newPreedit,
}
