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
local alphabeticKeyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          {
            Cell: params.keyboard.qButton.name,
          },
          {
            Cell: params.keyboard.wButton.name,
          },
          {
            Cell: params.keyboard.eButton.name,
          },
          {
            Cell: params.keyboard.rButton.name,
          },
          {
            Cell: params.keyboard.tButton.name,
          },
          {
            Cell: params.keyboard.yButton.name,
          },
          {
            Cell: params.keyboard.uButton.name,
          },
          {
            Cell: params.keyboard.iButton.name,
          },
          {
            Cell: params.keyboard.oButton.name,
          },
          {
            Cell: params.keyboard.pButton.name,
          },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          {
            Cell: params.keyboard.aButton.name,
          },
          {
            Cell: params.keyboard.sButton.name,
          },
          {
            Cell: params.keyboard.dButton.name,
          },
          {
            Cell: params.keyboard.fButton.name,
          },
          {
            Cell: params.keyboard.gButton.name,
          },
          {
            Cell: params.keyboard.hButton.name,
          },
          {
            Cell: params.keyboard.jButton.name,
          },
          {
            Cell: params.keyboard.kButton.name,
          },
          {
            Cell: params.keyboard.lButton.name,
          },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          {
            Cell: params.keyboard.shiftButton.name,
          },
          {
            Cell: params.keyboard.zButton.name,
          },
          {
            Cell: params.keyboard.xButton.name,
          },
          {
            Cell: params.keyboard.cButton.name,
          },
          {
            Cell: params.keyboard.vButton.name,
          },
          {
            Cell: params.keyboard.bButton.name,
          },
          {
            Cell: params.keyboard.nButton.name,
          },
          {
            Cell: params.keyboard.mButton.name,
          },
          {
            Cell: params.keyboard.backspaceButton.name,
          },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          {
            Cell: params.keyboard.numericButton.name,
          },
          {
            Cell: params.keyboard.commaButton.name,
          },
          {
            Cell: params.keyboard.spaceButton.name,
          },
          {
            Cell: params.keyboard.asciiModeButton.name,
          },
          {
            Cell: params.keyboard.enterButton.name,
          },
        ],
      },
    },
  ],
};


local newKeyLayout(isDark=false, isPortrait=true) =
  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;
  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + alphabeticKeyboardLayout
  // First Row
  + basicStyle.newAlphabeticButton(
    params.keyboard.qButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.qButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.wButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.wButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.eButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.eButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.rButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.rButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.tButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.tButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.yButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.yButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.uButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.uButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.iButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.iButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.oButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.oButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.pButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.pButton.params + hintStyle
  )

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
  + basicStyle.newAlphabeticButton(params.keyboard.sButton.name, isDark, portraitNormalButtonSize + params.keyboard.sButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.dButton.name, isDark, portraitNormalButtonSize + params.keyboard.dButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.fButton.name, isDark, portraitNormalButtonSize + params.keyboard.fButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.gButton.name, isDark, portraitNormalButtonSize + params.keyboard.gButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.hButton.name, isDark, portraitNormalButtonSize + params.keyboard.hButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.jButton.name, isDark, portraitNormalButtonSize + params.keyboard.jButton.params + hintStyle)
  + basicStyle.newAlphabeticButton(params.keyboard.kButton.name, isDark, portraitNormalButtonSize + params.keyboard.kButton.params + hintStyle)
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

  + basicStyle.newAlphabeticButton(
    params.keyboard.zButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.zButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.xButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.xButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.cButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.cButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.vButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.vButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.bButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.bButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.nButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.nButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    params.keyboard.mButton.name,
    isDark,
    portraitNormalButtonSize + params.keyboard.mButton.params + hintStyle
  )
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
    + basicStyle.newCommitCandidateForegroundStyle(isDark, { text: '$rimeCandidate' })
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
    // + basicStyle.asciiModeChangedNotification // 这个通知要或不要，没有看出区别
    + basicStyle.returnKeyboardTypeChangedNotification
    + basicStyle.preeditChangedForEnterButtonNotification
    + basicStyle.preeditChangedForSpaceButtonNotification,
}
