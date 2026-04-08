local numericButtons = import '../Buttons/LayoutNumeric.libsonnet';
local symbolicButtons = import '../Buttons/LayoutSymbolic.libsonnet';
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

local KeyboardType = {
  Chinese: 0,
  English: 1,
};

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: numericButtons.oneButton.name },
          { Cell: numericButtons.twoButton.name },
          { Cell: numericButtons.threeButton.name },
          { Cell: numericButtons.fourButton.name },
          { Cell: numericButtons.fiveButton.name },
          { Cell: numericButtons.sixButton.name },
          { Cell: numericButtons.sevenButton.name },
          { Cell: numericButtons.eightButton.name },
          { Cell: numericButtons.nineButton.name },
          { Cell: numericButtons.zeroButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: numericButtons.hyphenButton.name },
          { Cell: numericButtons.forwardSlashButton.name },
          { Cell: numericButtons.colonButton.name },
          { Cell: numericButtons.semicolonButton.name },
          { Cell: numericButtons.leftParenthesisButton.name },
          { Cell: numericButtons.rightParenthesisButton.name },
          { Cell: numericButtons.moneyButton.name },
          { Cell: numericButtons.atButton.name },
          { Cell: numericButtons.leftCurlyQuoteButton.name },
          { Cell: numericButtons.rightCurlyQuoteButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.symbolicButton.name },
          { Cell: numericButtons.plusButton.name },
          { Cell: numericButtons.asteriskButton.name },
          { Cell: numericButtons.ideographicCommaButton.name },
          { Cell: numericButtons.hashButton.name },
          { Cell: numericButtons.questionMarkButton.name },
          { Cell: numericButtons.exclamationMarkButton.name },
          { Cell: numericButtons.dotButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.gotoPrimaryKeyboardButton.name },
          { Cell: numericButtons.chinesePeriodButton.name },
          { Cell: numericButtons.numericSpaceButton.name },
          { Cell: numericButtons.numericEqualButton.name },
          { Cell: commonButtons.enterButton.name },
        ],
      },
    },
  ],
};

local getButtonSize(name) =
  local extra = {
    [numericButtons.chinesePeriodButton.name]: portraitNormalButtonSize,
    [numericButtons.numericEqualButton.name]: portraitNormalButtonSize,
    [commonButtons.symbolicButton.name]: {
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
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        {
          fontSize: fonts.numericButtonTextFontSize,
        }
        + utils.processButtonParams(isAlphabetic, button.params) + basicStyle.hintStyleSize
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
      ),
    numericButtons.numericButtons,
    {})
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getButtonSize(button.name)
        + utils.processButtonParams(isAlphabetic, button.params) + basicStyle.hintStyleSize
      ),
    [
      numericButtons.hyphenButton,
      numericButtons.forwardSlashButton,
      numericButtons.colonButton,
      numericButtons.semicolonButton,
      numericButtons.leftParenthesisButton,
      numericButtons.rightParenthesisButton,
      numericButtons.moneyButton,
      numericButtons.atButton,
      numericButtons.leftCurlyQuoteButton,
      numericButtons.rightCurlyQuoteButton,

      numericButtons.plusButton,
      numericButtons.asteriskButton,
      numericButtons.ideographicCommaButton,
      numericButtons.hashButton,
      numericButtons.questionMarkButton,
      numericButtons.exclamationMarkButton,
      numericButtons.dotButton,

      numericButtons.chinesePeriodButton,
      numericButtons.numericEqualButton,
    ],
    basicStyle.newAlphabeticButton(
      numericButtons.numericSpaceButton.name,
      isDark,
      utils.processButtonParams(isAlphabetic, numericButtons.numericSpaceButton.params),
      needHint=false,
    ))
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        getButtonSize(button.name)
        + utils.processButtonParams(isAlphabetic, button.params)
      ),
    [
      commonButtons.symbolicButton,
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
    + toolbar.new(isDark, isPortrait)
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
