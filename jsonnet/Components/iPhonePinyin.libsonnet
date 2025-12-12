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

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
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

local getAlphabeticButtonSize(name) =
  local extra = {
    [params.keyboard.aButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'right' },
    },
    [params.keyboard.lButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );


local newKeyLayout(isDark=false, isPortrait=true) =
  local keyboardHeight = if isPortrait then params.keyboard.height.iPhone.portrait else params.keyboard.height.iPhone.landscape;
  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)

  // letter Buttons
  + std.foldl(function(acc, button)
      local swipeStyleName = basicStyle.generateSwipeForegroundStyleNames(button.name, button.params);
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getAlphabeticButtonSize(button.name) + button.params + hintStyle + alphabeticTextCenterWhenShowSwipeText +
        (
          if settings.uppercaseForChinese then {
            foregroundStyleName: [{
              styleName: [utils.asciiModeForegroundStyleName(button.name, value)] + swipeStyleName,
              conditionKey: 'rime$ascii_mode',
              conditionValue: value,
            } for value in [true, false]
            ],
            notification: [
              utils.asciiModeChangedNotificationName(button.name, true),
              utils.asciiModeChangedNotificationName(button.name, false),
            ]
          }
          else {}
        ))
      + utils.newAsciiModeChangedNotification(button.name, true, {
        backgroundStyleName: basicStyle.alphabeticButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(button.name, true)] + swipeStyleName,
        [if std.objectHas(getAlphabeticButtonSize(button.name), 'bounds') then 'bounds' else null]: getAlphabeticButtonSize(button.name).bounds,
      })
      + utils.newAsciiModeChangedNotification(button.name, false, {
        backgroundStyleName: basicStyle.alphabeticButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(button.name, false)] + swipeStyleName,
        [if std.objectHas(getAlphabeticButtonSize(button.name), 'bounds') then 'bounds' else null]: getAlphabeticButtonSize(button.name).bounds,})
      + (
        if settings.uppercaseForChinese then
          utils.newAsciiModeForegroundStyle(button.name,
            basicStyle.newAlphabeticButtonUppercaseForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params, 'uppercasedStateAction') + getAlphabeticButtonSize(button.name) + alphabeticTextCenterWhenShowSwipeText,
            basicStyle.newAlphabeticButtonForegroundStyle(isDark, button.params) + getAlphabeticButtonSize(button.name) + alphabeticTextCenterWhenShowSwipeText)
        else {}
      )
      ,
      params.keyboard.letterButtons,
      {})

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
        size: { width: '225/1125' },
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
    portraitNormalButtonSize + params.keyboard.commaButton.params + {
      foregroundStyleName: [{
        styleName: [
          utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name, value),
          utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name + 'SwipeUp', value)
        ],
        conditionKey: 'rime$ascii_mode',
        conditionValue: value,
      } for value in [true, false]
      ],
      notification: [
        utils.asciiModeChangedNotificationName(params.keyboard.commaButton.name, true),
        utils.asciiModeChangedNotificationName(params.keyboard.commaButton.name, false),
      ]
    }
  )
  + utils.newAsciiModeChangedNotification(params.keyboard.commaButton.name, true, {
    backgroundStyleName: basicStyle.alphabeticButtonBackgroundStyleName,
    foregroundStyleName: [
      utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name, true),
      utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name + 'SwipeUp', true)
    ],
  })
  + utils.newAsciiModeChangedNotification(params.keyboard.commaButton.name, false, {
    backgroundStyleName: basicStyle.alphabeticButtonBackgroundStyleName,
    foregroundStyleName: [
      utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name, false),
      utils.asciiModeForegroundStyleName(params.keyboard.commaButton.name + 'SwipeUp', false)
    ],
  })
  + utils.newAsciiModeForegroundStyle(params.keyboard.commaButton.name,
      basicStyle.newAlphabeticButtonForegroundStyle(isDark, params.keyboard.commaButton.params)
        + { text: '，', center: { x: 0.68, y: 0.4 } },
      basicStyle.newAlphabeticButtonForegroundStyle(isDark, params.keyboard.commaButton.params)
        + { center: { y: 0.48 }})
  + utils.newAsciiModeForegroundStyle(params.keyboard.commaButton.name + 'SwipeUp',
      basicStyle.newAlphabeticButtonAlternativeForegroundStyle(isDark, params.keyboard.commaButton.params.swipeUp)
        + { text: '。', center: { x: 0.56, y: 0.22 } },
      basicStyle.newAlphabeticButtonAlternativeForegroundStyle(isDark, params.keyboard.commaButton.params.swipeUp)
        + { center: { y: 0.28 }})

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
    portraitNormalButtonSize
    + params.keyboard.asciiModeButton.params + {
      foregroundStyle: [{
        styleName: utils.asciiModeForegroundStyleName(params.keyboard.asciiModeButton.name, value),
        conditionKey: 'rime$ascii_mode',
        conditionValue: value,
      } for value in [true, false]
      ],
      notification: [
        utils.asciiModeChangedNotificationName(params.keyboard.asciiModeButton.name, true),
        utils.asciiModeChangedNotificationName(params.keyboard.asciiModeButton.name, false),
      ]
    }
  )
  + utils.newAsciiModeChangedNotification(params.keyboard.asciiModeButton.name, true, {
    backgroundStyleName: basicStyle.systemButtonBackgroundStyleName,
    foregroundStyleName: utils.asciiModeForegroundStyleName(params.keyboard.asciiModeButton.name, true),
  })
  + utils.newAsciiModeChangedNotification(params.keyboard.asciiModeButton.name, false, {
    backgroundStyleName: basicStyle.systemButtonBackgroundStyleName,
    foregroundStyleName: utils.asciiModeForegroundStyleName(params.keyboard.asciiModeButton.name, false),
  })
  + utils.newAsciiModeForegroundStyle(params.keyboard.asciiModeButton.name,
      basicStyle.newAssetImageSystemButtonForegroundStyle(isDark, { assetImageName: 'chineseState2' }),
      basicStyle.newAssetImageSystemButtonForegroundStyle(isDark, { assetImageName: 'englishState2' })
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
    + toolbar.new(isDark, isPortrait)
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticButtonHintStyle(isDark)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonForegroundStyle(isDark, params=params.keyboard.enterButton.params)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait)
    + basicStyle.newSpaceButtonRimeSchemaForegroundStyle(isDark)
    + basicStyle.newEnterButtonForegroundStyle(isDark, params.keyboard.enterButton.params)
    + basicStyle.newCommitCandidateForegroundStyle(isDark, { text: settings.spaceButtonComposingText })
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
    + basicStyle.preeditChangedForEnterButtonNotification
    + basicStyle.preeditChangedForSpaceButtonNotification,
}
