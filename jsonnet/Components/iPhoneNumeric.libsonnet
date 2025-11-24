local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

local hintStyle = {
  hintStyle: {
    size: { width: 50, height: 50 },
  },
};

local chineseSymbolicOffset = {
  center: { x: 0.65 },
};

local symbols = {
  name: 'symbols',
  values: {
    symbols: [
      '+', '-', { label: '×', action: { character: "*" } }, '/', '=', '(', ')',
      '%', '^', '&', '!', '>', '<', '{', '}', '[', ']', '~',
    ],
  },
};

local collection = {
  name: 'collection',
  params: {
    type: 'symbols',
    size: { height: '3/4' },
    dataSource: symbols.name,
    useRimeEngine: false,
  }
};

local numericSideColumnStyleName = 'numericSideColumnStyle';
local numericMiddleColumnStyleName = 'numericMiddleColumnStyle';

local numericKeyboardLayout = {
  [numericSideColumnStyleName]: {
    width: '29/183',
  },
  [numericMiddleColumnStyleName]: {
    width: '125/549',
  },
  keyboardLayout: [
    {
      VStack: {
        style: numericSideColumnStyleName,
        subviews: [
          {
            Cell: collection.name,
          },
          {
            Cell: params.keyboard.goBackButton.name,
          },
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          {
            Cell: params.keyboard.oneButton.name,
          },
          {
            Cell: params.keyboard.fourButton.name,
          },
          {
            Cell: params.keyboard.sevenButton.name,
          },
          {
            Cell: params.keyboard.symbolicButton.name,
          }
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          {
            Cell: params.keyboard.twoButton.name,
          },
          {
            Cell: params.keyboard.fiveButton.name,
          },
          {
            Cell: params.keyboard.eightButton.name,
          },
          {
            Cell: params.keyboard.zeroButton.name,
          }
        ],
      },
    },
    {
      VStack: {
        style: numericMiddleColumnStyleName,
        subviews: [
          {
            Cell: params.keyboard.threeButton.name,
          },
          {
            Cell: params.keyboard.sixButton.name,
          },
          {
            Cell: params.keyboard.nineButton.name,
          },
          {
            Cell: params.keyboard.dotButton.name,
          }
        ],
      },
    },
    {
      VStack: {
        style: numericSideColumnStyleName,
        subviews: [
          {
            Cell: params.keyboard.backspaceButton.name,
          },
          {
            Cell: params.keyboard.numericSpaceButton.name,
          },
          {
            Cell: params.keyboard.numericColonButton.name,
          },
          {
            Cell: params.keyboard.enterButton.name,
          },
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
  + basicStyle.newAlphabeticButton(
    params.keyboard.oneButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.oneButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.twoButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.twoButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.threeButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.threeButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.fourButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.fourButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.fiveButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.fiveButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.sixButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.sixButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.sevenButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.sevenButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.eightButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.eightButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.nineButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.nineButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.zeroButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.zeroButton.params + hintStyle
  )

  // First Column
  + basicStyle.newSymbolicCollection(
    collection.name,
    isDark,
    collection.params
  )
  + symbols.values
  + basicStyle.newSystemButton(
    params.keyboard.goBackButton.name,
    isDark,
    params.keyboard.goBackButton.params
  )
  // Second Column
  + basicStyle.newSystemButton(
    params.keyboard.symbolicButton.name,
    isDark,
    params.keyboard.symbolicButton.params
  )

  // Fourth Column
  + basicStyle.newSystemButton(
    params.keyboard.dotButton.name,
    isDark,
    params.keyboard.dotButton.params
  )

  // Last Column
  + basicStyle.newSystemButton(
    params.keyboard.backspaceButton.name,
    isDark,
    params.keyboard.backspaceButton.params,
  )
  + basicStyle.newSystemButton(
    params.keyboard.numericSpaceButton.name,
    isDark,
    params.keyboard.numericSpaceButton.params
  )
  + basicStyle.newSystemButton(
    params.keyboard.numericColonButton.name,
    isDark,
    params.keyboard.numericColonButton.params
  )
  + basicStyle.newSystemButton(
    params.keyboard.enterButton.name,
    isDark,
    params.keyboard.enterButton.params
  );

local extraParams = {
  insets: params.keyboard.button.backgroundInsets.iPhone.landscape,
};

{
  new(isDark, isPortrait):
    local insets = if isPortrait then params.keyboard.button.backgroundInsets.iPhone.portrait else params.keyboard.button.backgroundInsets.iPhone.landscape;

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
