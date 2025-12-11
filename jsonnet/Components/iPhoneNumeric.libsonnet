local params = import '../Constants/Keyboard.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local backgroundInsets = {
  portrait: { top: 3, left: 4, bottom: 3, right: 4 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
};

// 窄 VStack 宽度样式
local narrowVStackStyle = {
  local this = self,
  name: 'narrowVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.17 },
      },
    },
  },
};

// 宽 VStack 宽度样式
local wideVStackStyle = {
  local this = self,
  name: 'wideVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.22 },
      },
    },
  },
};

// 半宽 VStack 宽度样式，横屏时一半显示数字，一半显示符号
local halfVStackStyle = {
  local this = self,
  name: 'halfVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.45 },
      },
    },
  },
};

// 9 键布局
local numericKeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: params.keyboard.numericSymbolsCollection.name, },
          { Cell: params.keyboard.gotoPrimaryKeyboardButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: wideVStackStyle.name,
        subviews: [
          { Cell: params.keyboard.oneButton.name, },
          { Cell: params.keyboard.fourButton.name, },
          { Cell: params.keyboard.sevenButton.name, },
          { Cell: params.keyboard.numericSpaceButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: wideVStackStyle.name,
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
        style: wideVStackStyle.name,
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
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: params.keyboard.backspaceButton.name, },
          { Cell: params.keyboard.numericEqualButton.name, },
          { Cell: params.keyboard.numericColonButton.name, },
          { Cell: params.keyboard.enterButton.name, },
        ],
      },
    },
  ],
};

local totalKeyboardLayout(isPortrait=false) =
  if isPortrait then
    numericKeyboardLayout
  else {
    keyboardLayout: [
      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: numericKeyboardLayout.keyboardLayout,
        }
      },

      // 中间留白
      {
        VStack: {},
      },

      // 符号区
      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: [
            { Cell: params.keyboard.numericCategorySymbolCollection.name, },
          ],
        }
      },
    ]
  };


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =

  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;

  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + totalKeyboardLayout(isPortrait)
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        button.params + {
          fontSize: fonts.numericButtonTextFontSize,
        },
        needHint=false,
      ),
    params.keyboard.numericButtons,
    {})

  + basicStyle.newSymbolicCollection(
    params.keyboard.numericSymbolsCollection.name,
    isDark,
    params.keyboard.numericSymbolsCollection.params + extraParams
  )
  + {
    [params.keyboard.numericCategorySymbolCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + params.keyboard.numericCategorySymbolCollection.params
      + extraParams,
  }
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        button.params
      ),
    [
      params.keyboard.numericSpaceButton,
      params.keyboard.dotButton,
      params.keyboard.backspaceButton,
      params.keyboard.numericEqualButton,
      params.keyboard.numericColonButton,
      params.keyboard.enterButton,
    ],
    basicStyle.newSystemButton(
        params.keyboard.gotoPrimaryKeyboardButton.name,
        isDark,
        params.keyboard.gotoPrimaryKeyboardButton.params + {
          size: { height: '1/4' },
          backgroundStyle: basicStyle.colorButtonBackgroundStyleName,
          foregroundStyle: params.keyboard.gotoPrimaryKeyboardButton.name + basicStyle.colorButtonForegroundStyleName,
        }
      ));

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
    + (
      if !isPortrait then halfVStackStyle.style else {}
    )
    + narrowVStackStyle.style
    + wideVStackStyle.style
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticButtonHintStyle(isDark)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonForegroundStyle(isDark, params=params.keyboard.enterButton.params)
    + basicStyle.newColorButtonForegroundStyle(isDark, params=params.keyboard.gotoPrimaryKeyboardButton.params, namePrefix=params.keyboard.gotoPrimaryKeyboardButton.name)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + newKeyLayout(isDark, isPortrait, extraParams)
    + basicStyle.newEnterButtonForegroundStyle(isDark, params.keyboard.enterButton.params)
    + basicStyle.newCommitCandidateForegroundStyle(isDark, { text: '选定' })
    // Notifications
    + basicStyle.preeditChangedForEnterButtonNotification
    + basicStyle.preeditChangedForSpaceButtonNotification,
}
