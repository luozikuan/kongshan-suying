local symbolicButtons = import '../../Buttons/LayoutSymbolic.libsonnet';
local commonButtons = import '../../Buttons/Common.libsonnet';
local fonts = import '../../Constants/Fonts.libsonnet';
local basicStyle = import '../../Styles/BasicStyle.libsonnet';
local preedit = import '../Preedit.libsonnet';
local toolbar = import '../Toolbar.libsonnet';
local utils = import '../../Utils/Utils.libsonnet';
local settings = import '../../Settings.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

local KeyboardType = {
  Chinese: 0,
  English: 1,
};

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: symbolicButtons.leftBracketButton.name },
          { Cell: symbolicButtons.rightBracketButton.name },
          { Cell: symbolicButtons.leftBraceButton.name },
          { Cell: symbolicButtons.rightBraceButton.name },
          { Cell: symbolicButtons.leftCornerBracketButton.name },
          { Cell: symbolicButtons.rightCornerBracketButton.name },
          { Cell: symbolicButtons.percentButton.name },
          { Cell: symbolicButtons.caretButton.name },
          { Cell: symbolicButtons.multipleSymButton.name },
          { Cell: symbolicButtons.divideSymButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: symbolicButtons.underscoreButton.name },
          { Cell: symbolicButtons.backSlashButton.name },
          { Cell: symbolicButtons.pipeButton.name },
          { Cell: symbolicButtons.tildeButton.name },
          { Cell: symbolicButtons.lessThanButton.name },
          { Cell: symbolicButtons.greaterThanButton.name },
		  { Cell: symbolicButtons.backQuoteButton.name },
          { Cell: symbolicButtons.yenButton.name },
          { Cell: symbolicButtons.euroButton.name },
          { Cell: symbolicButtons.poundButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.numericButton.name },
          { Cell: symbolicButtons.longDashButton.name },
          { Cell: symbolicButtons.centerDotButton.name },
          { Cell: symbolicButtons.almostEqualButton.name },
          { Cell: symbolicButtons.leftBookTitleMarkButton.name },
          { Cell: symbolicButtons.rightBookTitleMarkButton.name },
          { Cell: symbolicButtons.sectionSymButton.name },
          { Cell: symbolicButtons.temperatureButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.gotoPrimaryKeyboardButton.name },
          { Cell: symbolicButtons.ellipsisButton.name },
          { Cell: symbolicButtons.symbolicSpaceButton.name },
          { Cell: symbolicButtons.etcButton.name },
          { Cell: commonButtons.enterButton.name },
        ],
      },
    },
  ],
};

local getButtonSize(name) =
  local extra = {
    [commonButtons.numericButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '151/168.75', alignment: 'left' },
    },
    [commonButtons.backspaceButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '151/168.75', alignment: 'right' },
    },
	[symbolicButtons.ellipsisButton.name]: portraitNormalButtonSize,
	[symbolicButtons.etcButton.name]: portraitNormalButtonSize,
    [commonButtons.enterButton.name]: { size: { width: '250/1125' } },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    {}
  );

local newKeyLayout(isDark=false, isPortrait=false, keyboardType=KeyboardType.Chinese) =
  local isAlphabetic = keyboardType == KeyboardType.English;
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout
  // 符号键
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getButtonSize(button.name)
        + utils.processButtonParams(isAlphabetic, button.params) + basicStyle.hintStyleSize,
      ),
    [
      symbolicButtons.leftBracketButton,
      symbolicButtons.rightBracketButton,
      symbolicButtons.leftBraceButton,
      symbolicButtons.rightBraceButton,
      symbolicButtons.leftCornerBracketButton,
      symbolicButtons.rightCornerBracketButton,
      symbolicButtons.percentButton,
      symbolicButtons.caretButton,
      symbolicButtons.multipleSymButton,
      symbolicButtons.divideSymButton,
      symbolicButtons.underscoreButton,
      symbolicButtons.backSlashButton,
      symbolicButtons.pipeButton,
      symbolicButtons.tildeButton,
      symbolicButtons.lessThanButton,
      symbolicButtons.greaterThanButton,
	  symbolicButtons.backQuoteButton,
      symbolicButtons.yenButton,
      symbolicButtons.euroButton,
      symbolicButtons.poundButton,
      symbolicButtons.longDashButton,
      symbolicButtons.centerDotButton,
      symbolicButtons.almostEqualButton,
      symbolicButtons.leftBookTitleMarkButton,
      symbolicButtons.rightBookTitleMarkButton,
      symbolicButtons.sectionSymButton,
      symbolicButtons.temperatureButton,
      symbolicButtons.ellipsisButton,
      symbolicButtons.symbolicSpaceButton,
      symbolicButtons.etcButton,
	],
    {})
  // 功能键
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        getButtonSize(button.name)
        + utils.processButtonParams(isAlphabetic, button.params)
      ),
    [
      commonButtons.numericButton,
      commonButtons.backspaceButton,
      commonButtons.enterButton,
    ],
    basicStyle.newColorButton(
      commonButtons.gotoPrimaryKeyboardButton.name,
      isDark,
      { size: { width: '225/1125' } }
      + utils.processButtonParams(isAlphabetic, commonButtons.gotoPrimaryKeyboardButton.params)
    ));

{
  // 枚举键盘类型
  KeyboardType:: KeyboardType,

  // 从拼音键盘切过来时，keyboardType 为 KeyboardType.Chinese；从英文键盘切过来时，keyboardType 为 KeyboardType.English
  new(isDark, isPortrait, keyboardType=KeyboardType.Chinese):
    local insets = if isPortrait then commonButtons.backgroundInsets.portrait else commonButtons.backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait, 'symbolic')
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait, keyboardType)
    // Notifications
}
