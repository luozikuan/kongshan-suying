local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local backgroundInsets = {
  portrait: { top: 3, left: 4, bottom: 3, right: 4 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
};

local hintStyle = {
  hintStyle: {
    size: { width: 50, height: 50 },
  },
};

local chineseSymbolicOffset = {
  center: { x: 0.65 },
};

local getSymbol(symbol, useRimeEngine=false, alias='') =
  local label = if std.length(alias) == 0 then symbol else alias;
  {
    label: label,
    action: {
      [if useRimeEngine then 'character' else 'symbol']: symbol
    },
  };

local symbolsName = 'symbols';
local newSymbols(useRimeEngine=false) = {
  [symbolsName]: [
    getSymbol('+', useRimeEngine),
    getSymbol('-', useRimeEngine),
    getSymbol('*', useRimeEngine, '×'),
    getSymbol('/', useRimeEngine),
    getSymbol('=', useRimeEngine),
    getSymbol('(', useRimeEngine),
    getSymbol(')', useRimeEngine),
    getSymbol('%', useRimeEngine),
    getSymbol('^', useRimeEngine),
    getSymbol('&', useRimeEngine),
    getSymbol('!', useRimeEngine),
    getSymbol('>', useRimeEngine),
    getSymbol('<', useRimeEngine),
    getSymbol('{', useRimeEngine),
    getSymbol('}', useRimeEngine),
    getSymbol('[', useRimeEngine),
    getSymbol(']', useRimeEngine),
    getSymbol('~', useRimeEngine),
    ],
};

local collection = {
  name: 'collection',
  params: {
    type: 'symbols',
    size: { height: '3/4' },
    dataSource: symbolsName,
    useRimeEngine: false, // 是否使用 Rime 引擎处理符号
  }
};

local numericSideColumnStyleName = 'numericSideColumnStyle';
local numericMiddleColumnStyleName = 'numericMiddleColumnStyle';

local numericKeyboardLayout = {
  [numericSideColumnStyleName]: {
    size: { width: '29/183' },
  },
  [numericMiddleColumnStyleName]: {
    size: { width: '125/549' },
  },
  keyboardLayout: [
    {
      VStack: {
        style: numericSideColumnStyleName,
        subviews: [
          { Cell: collection.name, },
          { Cell: params.keyboard.goBackButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          { Cell: params.keyboard.oneButton.name, },
          { Cell: params.keyboard.fourButton.name, },
          { Cell: params.keyboard.sevenButton.name, },
          { Cell: params.keyboard.symbolicButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          { Cell: params.keyboard.twoButton.name, },
          { Cell: params.keyboard.fiveButton.name, },
          { Cell: params.keyboard.eightButton.name, },
          { Cell: params.keyboard.zeroButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          { Cell: params.keyboard.threeButton.name, },
          { Cell: params.keyboard.sixButton.name, },
          { Cell: params.keyboard.nineButton.name, },
          { Cell: params.keyboard.dotButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: numericSideColumnStyleName,
        subviews: [
          { Cell: params.keyboard.backspaceButton.name, },
          { Cell: params.keyboard.numericSpaceButton.name, },
          { Cell: params.keyboard.numericColonButton.name, },
          { Cell: params.keyboard.enterButton.name, },
        ],
      },
    },
  ],
};


local newKeyLayout(isDark=false, isPortrait=false) =

  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;

  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + numericKeyboardLayout
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        button.params + hintStyle
      ),
    params.keyboard.numericButtons,
    {})

  // First Column
  + basicStyle.newSymbolicCollection(
    collection.name,
    isDark,
    collection.params
  )
  + newSymbols(collection.params.useRimeEngine)
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        button.params
      ),
    [
      params.keyboard.goBackButton,
      params.keyboard.symbolicButton,
      params.keyboard.dotButton,
      params.keyboard.backspaceButton,
      params.keyboard.numericSpaceButton,
      params.keyboard.numericColonButton,
      params.keyboard.enterButton,
    ],
    {});

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark)
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticButtonHintStyle(isDark)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newBlueButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newBlueButtonForegroundStyle(isDark, params.keyboard.enterButton.params)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + newKeyLayout(isDark, isPortrait)
    + basicStyle.newEnterButtonForegroundStyle(isDark, params.keyboard.enterButton.params)
    + basicStyle.newCommitCandidateForegroundStyle(isDark, { text: '选定' })
    // Notifications
    + basicStyle.returnKeyboardTypeChangedNotification
    + basicStyle.preeditChangedForEnterButtonNotification
    + basicStyle.preeditChangedForSpaceButtonNotification,
}
