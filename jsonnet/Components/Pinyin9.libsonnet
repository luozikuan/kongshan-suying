local fonts = import '../Constants/Fonts.libsonnet';
local pinyin9Buttons = import '../Buttons/Layout9.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';


// 窄 VStack 宽度样式
local narrowVStackStyle = {
  local this = self,
  name: 'narrowVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.18 },
      },
    },
  },
};

// 半宽 VStack 宽度样式，横屏时一半显示拼音输入，一半显示候选字
local halfVStackStyle = {
  local this = self,
  name: 'halfVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.48 },
      },
    },
  },
};

// 9 键布局
local t9KeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: pinyin9Buttons.t9SymbolsCollection.name, },
          { Cell: commonButtons.numericButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9OneButton.name, },
                { Cell: pinyin9Buttons.t9TwoButton.name, },
                { Cell: pinyin9Buttons.t9ThreeButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9FourButton.name, },
                { Cell: pinyin9Buttons.t9FiveButton.name, },
                { Cell: pinyin9Buttons.t9SixButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9SevenButton.name, },
                { Cell: pinyin9Buttons.t9EightButton.name, },
                { Cell: pinyin9Buttons.t9NineButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.cursorRightButton.name, },
                { Cell: pinyin9Buttons.spaceButton.name, },
                { Cell: commonButtons.alphabeticButton.name, },
              ],
            },
          },
        ],
      },
    },
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: commonButtons.backspaceButton.name, },
          { Cell: commonButtons.clearPreeditButton.name, },
          { Cell: commonButtons.enterButton.name, },
        ],
      },
    },
  ],
};

local totalKeyboardLayout(isPortrait=false) =
  if isPortrait then
    t9KeyboardLayout
  else {
    keyboardLayout: [
      // 候选字区
      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: [
            {
              VStack: {
                style: narrowVStackStyle.name,
                subviews: [
                  {
                    Cell: pinyin9Buttons.t9SymbolsCollection.name,
                  },
                ],
              },
            },
            {
              VStack: {
                subviews: [
                  {
                    Cell: pinyin9Buttons.t9CandidatesCollection.name,
                  },
                ],
              },
            },
          ],
        }
      },

      // 中间留白
      {
        VStack: {},
      },

      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: t9KeyboardLayout.keyboardLayout,
        }
      },
    ]
  };


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }

  + totalKeyboardLayout(isPortrait)

  + {
    [pinyin9Buttons.t9SymbolsCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + pinyin9Buttons.t9SymbolsCollection.params + extraParams,

    [if !isPortrait then pinyin9Buttons.t9CandidatesCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + pinyin9Buttons.t9CandidatesCollection.params + extraParams,
  }

  // t9 Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        basicStyle.textCenterWhenShowSwipeText + {
          fontSize: fonts.t9ButtonTextFontSize,
        } + button.params + (
          if settings.uppercaseForChinese then
            { text: std.asciiUpper(button.params.text) }
          else {}
        ),
        needHint=false,
      ),
    pinyin9Buttons.t9Buttons,
    {})

  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    {
      size: { height: '1/4' },
    } + commonButtons.numericButton.params
  )

  + basicStyle.newSystemButton(
    pinyin9Buttons.cursorRightButton.name,
    isDark,
    pinyin9Buttons.cursorRightButton.params +
    {
      size: { width: { percentage: 0.2 } },
    },
  )

  + basicStyle.newAlphabeticButton(
    pinyin9Buttons.spaceButton.name,
    isDark,
    basicStyle.newSpaceButtonForegroundStyle(pinyin9Buttons.spaceButton.params, '$rimeSchemaName', isDark),
    needHint=false,
  )

  + basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark, commonButtons.alphabeticButton.params +
    {
      size: { width: { percentage: 0.2 } },
    }
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    commonButtons.backspaceButton.params,
  )

  + basicStyle.newSystemButton(
    commonButtons.clearPreeditButton.name,
    isDark,
    commonButtons.clearPreeditButton.params,
  )

  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { height: '2/4' },
    } + commonButtons.enterButton.params
  );

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 3, left: 4, bottom: 3, right: 4 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
}
else
{
  portrait: { top: 3, left: 3, bottom: 3, right: 3 },
  landscape: { top: 4, left: 6, bottom: 4, right: 6 },
};

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
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait, extraParams)
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
    + basicStyle.returnKeyTypeChangedNotification,
}
