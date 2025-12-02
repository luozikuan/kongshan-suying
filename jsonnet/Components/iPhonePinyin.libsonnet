local params = import '../Constants/Keyboard.libsonnet';
local settings = import '../Constants/Settings.libsonnet';
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

// 标准26键布局
local rows = [
  [
    params.keyboard.qButton,
    params.keyboard.wButton,
    params.keyboard.eButton,
    params.keyboard.rButton,
    params.keyboard.tButton,
    params.keyboard.yButton,
    params.keyboard.uButton,
    params.keyboard.iButton,
    params.keyboard.oButton,
    params.keyboard.pButton,
  ],
  [
    params.keyboard.aButton,
    params.keyboard.sButton,
    params.keyboard.dButton,
    params.keyboard.fButton,
    params.keyboard.gButton,
    params.keyboard.hButton,
    params.keyboard.jButton,
    params.keyboard.kButton,
    params.keyboard.lButton,
  ],
  [
    params.keyboard.shiftButton,
    params.keyboard.zButton,
    params.keyboard.xButton,
    params.keyboard.cButton,
    params.keyboard.vButton,
    params.keyboard.bButton,
    params.keyboard.nButton,
    params.keyboard.mButton,
    params.keyboard.backspaceButton,
  ],
  [
    params.keyboard.numericButton,
    params.keyboard.commaButton,
    params.keyboard.spaceButton,
    params.keyboard.asciiModeButton,
    params.keyboard.enterButton,
  ],
];


local newKeyLayout(isDark=false, isPortrait=true) =
  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;
  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)
  // using default width first
  + std.foldl(function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        portraitNormalButtonSize + button.params + hintStyle),
      params.keyboard.letterButtons,
      {})

  // Second Row
  + basicStyle.newAlphabeticButton(
    params.keyboard.aButton.name,
    isDark,
    {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'right' },
    } + params.keyboard.aButton.params + hintStyle,
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.lButton.name,
    isDark,
    {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'left' },
    } + params.keyboard.lButton.params + hintStyle
  )

  // Third Row
  + basicStyle.newSystemButton(
    params.keyboard.shiftButton.name,
    isDark,
    (
      if settings.usePCLayout then portraitNormalButtonSize else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'left' },
      }
    )
    + params.keyboard.shiftButton.params
    + {
      uppercasedStateForegroundStyle: params.keyboard.shiftButton.name + 'UppercasedForegroundStyle',
    }
    + {
      capsLockedStateForegroundStyle: params.keyboard.shiftButton.name + 'CapsLockedForegroundStyle',
    }
  )
  + {
    [params.keyboard.shiftButton.name + 'UppercasedForegroundStyle']:
      basicStyle.newImageSystemButtonForegroundStyle(isDark, params.keyboard.shiftButton.uppercasedParams),
    [params.keyboard.shiftButton.name + 'CapsLockedForegroundStyle']:
      basicStyle.newImageSystemButtonForegroundStyle(isDark, params.keyboard.shiftButton.capsLockedParams),
  }

  + basicStyle.newSystemButton(
    params.keyboard.backspaceButton.name,
    isDark,
    (
      if settings.usePCLayout then
      {
        size:
          { width: '225/1125' },
        bounds:
          { width: '200/225', alignment: 'right' },
      }
      else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'right' },
      }
    )
    + params.keyboard.backspaceButton.params,
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    params.keyboard.numericButton.name,
    isDark,
    {
      size:
        { width: '225/1125' },
    } + params.keyboard.numericButton.params
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.commaButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.commaButton.params
  )
  + basicStyle.newSpaceButton(
    params.keyboard.spaceButton.name,
    isDark,
    {
      foregroundStyle: basicStyle.spaceButtonForegroundStyle,
    }
    + params.keyboard.spaceButton.params
  )
  + basicStyle.newSystemButton(
    params.keyboard.asciiModeButton.name,
    isDark,
    portraitNormalButtonSize + {
      foregroundStyle: basicStyle.asciiModeButtonForegroundStyle,
    } + params.keyboard.asciiModeButton.params
  )
  + basicStyle.newSystemButton(
    params.keyboard.enterButton.name,
    isDark,
    {
      size: { width: '250/1125' },
      backgroundStyle: basicStyle.enterButtonBackgroundStyle,
      foregroundStyle: basicStyle.enterButtonForegroundStyle,
    } + params.keyboard.enterButton.params
  )
;

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
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait)
    + basicStyle.newSpaceButtonRimeSchemaForegroundStyle(isDark)
    + basicStyle.newAsciiModeButtonForegroundStyle(isDark, params.keyboard.asciiModeButton.params)
    + basicStyle.newAsciiModeButtonEnglishStateForegroundStyle(isDark, params.keyboard.asciiModeButton.params)
    + basicStyle.newEnterButtonForegroundStyle(isDark, params.keyboard.enterButton.params)
    + basicStyle.newCommitCandidateForegroundStyle(isDark, { text: settings.spaceButtonComposingText })
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
    // + basicStyle.asciiModeChangedNotification // 这个通知要或不要，没有看出区别
    + basicStyle.returnKeyboardTypeChangedNotification
    + basicStyle.preeditChangedForEnterButtonNotification
    + basicStyle.preeditChangedForSpaceButtonNotification,
}
