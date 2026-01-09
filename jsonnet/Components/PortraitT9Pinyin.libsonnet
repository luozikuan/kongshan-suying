local fonts = import '../Constants/Fonts.libsonnet';
local params = import '../Constants/Keyboard.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
  };

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

// 9 键布局
local alphabeticKeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          {
            Cell: params.keyboard.t9SymbolsCollection.name,
          },
          {
            Cell: params.keyboard.numericButton.name,
          },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          {
            HStack: {
              subviews: [
                {
                  Cell: params.keyboard.t9OneButton.name,
                },
                {
                  Cell: params.keyboard.t9TwoButton.name,
                },
                {
                  Cell: params.keyboard.t9ThreeButton.name,
                },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                {
                  Cell: params.keyboard.t9FourButton.name,
                },
                {
                  Cell: params.keyboard.t9FiveButton.name,
                },
                {
                  Cell: params.keyboard.t9SixButton.name,
                },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                {
                  Cell: params.keyboard.t9SevenButton.name,
                },
                {
                  Cell: params.keyboard.t9EightButton.name,
                },
                {
                  Cell: params.keyboard.t9NineButton.name,
                },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                {
                  Cell: params.keyboard.symbolicButton.name,
                },
                {
                  Cell: params.keyboard.spaceButton.name,
                },
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
          {
            Cell: params.keyboard.backspaceButton.name,
          },
          {
            Cell: params.keyboard.t9ZeroButton.name,
          },
          {
            Cell: params.keyboard.enterButton.name,
          },
        ],
      },
    },
  ],
};


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =

  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;

  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }

  + alphabeticKeyboardLayout

  + basicStyle.newSymbolicCollection(
    params.keyboard.t9SymbolsCollection.name,
    isDark,
    params.keyboard.t9SymbolsCollection.params + extraParams
  )

  // t9 Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        alphabeticTextCenterWhenShowSwipeText + button.params + {
          fontSize: fonts.t9ButtonTextFontSize,
        },
        needHint=false,
      ),
    params.keyboard.t9Buttons,
    {})

  + basicStyle.newSystemButton(
    params.keyboard.numericButton.name,
    isDark,
    {
      size: { height: '1/4' },
    } + params.keyboard.numericButton.params
  )

  + basicStyle.newSystemButton(
    params.keyboard.symbolicButton.name,
    isDark, params.keyboard.symbolicButton.params +
    {
      size: { width: '1/3' },
    }
  )

  + basicStyle.newAlphabeticButton(
    params.keyboard.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle(isDark),
    }
    + params.keyboard.spaceButton.params,
    needHint=false
  )

  + basicStyle.newSystemButton(
    params.keyboard.backspaceButton.name,
    isDark,
    params.keyboard.backspaceButton.params,
  )

  + basicStyle.newColorButton(
    params.keyboard.enterButton.name,
    isDark,
    {
      size: { height: '2/4' },
    } + params.keyboard.enterButton.params
  );

local extraParams = {
  insets: params.keyboard.button.backgroundInsets.iPhone.landscape,
};

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
    + narrowVStackStyle.style
    + wideVStackStyle.style
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
    + basicStyle.rimeSchemaChangedNotification,
}
