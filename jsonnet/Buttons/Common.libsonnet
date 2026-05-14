# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含一些通用按键，如空格、backspace、enter
# shift、返回键、各种切换键盘键等等
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  // 键盘高度（不含工具栏）
  keyboardHeight: if !settings.iPad then
    {
      portrait: 216,  // 54 * 4
      landscape: 160,  // 40 * 4
    }
    else
    {
      portrait: 256,  // 64 * 4
      landscape: 344,  // 86 * 4
    },

  // 按键背景内边距
  backgroundInsets: if !settings.iPad then
    {
      portrait: { top: 5, left: 3, bottom: 5, right: 3 },
      landscape: { top: 3, left: 3, bottom: 3, right: 3 },
    }
    else
    {
      portrait: { top: 3, left: 3, bottom: 3, right: 3 },
      landscape: { top: 4, left: 6, bottom: 4, right: 6 },
    },

  // 特殊功能键
  spaceButton: {
    name: 'spaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
      center: {x: 0.5, y: 0.5},
      notification:
        (if settings.spaceButtonSchemaNameCenter != null then
          ['rimeSchemaChangedNotification']
        else []),

      whenPreeditChanged: {
        text: settings.spaceButtonComposingText,
        fontSize: fonts.systemButtonTextFontSize,

        swipeUp: {
          action: { shortcut: '#次选上屏' },
          text: '次选',
        },
      },
    },
  },

  tabButton: {
    name: 'tabButton',
    params: {
      action: 'tab',
      systemImageName: 'arrow.right.to.line',
    },
  },

  backspaceButton: {
    name: 'backspaceButton',
    params: {
      action: 'backspace',
      repeatAction: self.action,
      systemImageName: 'delete.left',
      highlightSystemImageName: 'delete.left.fill',
	  whenPreeditChanged: {
		swipeUp: {
          action: { sendKeys: 'Control+Backspace' } // 删除一个音节
		},
	  },
    },
  },

  shiftButton: {
    name: 'shiftButton',
    params: settings.shiftButtonParams,
  },

  enterButton: {
    name: 'enterButton',
    params: {
      action: 'enter',
      text: '$returnKeyType',

      swipeUp: { action: { shortcut: '#行首' } },
      swipeDown: { action: { shortcut: '#行尾' } },

      longPress: [
        {
          action: { shortcut: '#换行' },
          systemImageName: 'return',
          text: '换行',
        },
      ],

      whenPreeditChanged: {
        text: '确认',
        backgroundStyle: 'systemButtonBackgroundStyle',
        normalColor: colors.systemButtonForegroundColor,
      },

      whenReturnKeyChanged: [
        {
          // NOTE: 此通知仅用来更新 enterButton 的前景文字 $returnKeyType
          //       匹配不上 returnKeyType:[] 中指定的值，就会使用默认的文字 $returnKeyType
          returnKeyType: [],
        },
      ],
    },
  },

  functionButton: {
    name: 'functionButton',
    params: {
      action: { shortcut: '#selectText' },
      systemImageName: 'selection.pin.in.out',

      whenKeyboardAction: [
        {
          notificationKeyboardAction: {
            shortcut: '#selectText'
          },
          action: { shortcut: '#cut' },
          systemImageName: 'scissors',
        },
      ],
    },
  },

  goBackButton: {
    name: 'goBackButton',
    params: {
      action: 'returnLastKeyboard',
      systemImageName: 'arrow.uturn.backward',
    },
  },

  gotoPrimaryKeyboardButton: {
    name: 'gotoPrimaryKeyboardButton',
    params: {
      action: 'returnPrimaryKeyboard',
      systemImageName: 'arrow.backward',
      text: '返回',
    },
  },

  iOSNextKeyboardButton: {
    name: 'iOSNextKeyboardButton',
    params: {
      action: 'nextKeyboard',
      systemImageName: 'globe',
    },
  },

  numericButton: {
    name: 'numericButton',
    params: {
      action: { keyboardType: 'numeric' },
      text: if settings.preferIcon then '123' else '数字',
      swipeUp: { action: { keyboardType: 'symbolic' } },
      swipeDown: { action: { keyboardType: 'emojis' } },
    }
    + ( // 对于 iPad 设备，长按数字键可以切换到 iOS 系统键盘列表中的下一个键盘
      if settings.iPad then {
        longPress: [
          {
            systemImageName: 'globe',
            action: 'nextKeyboard',
            selected: true,
          },
        ],
      }
      else {}
    )
    ,
  },

  symbolicButton: {
    name: 'symbolicButton',
    params: {
      action: { keyboardType: 'symbolic' },
      text: if settings.preferIcon then '#+=' else '符号',
    },
  },

  alphabeticButton: {
    name: 'alphabeticButton',
    params: {
      action: { keyboardType: 'alphabetic' },
      assetImageName: 'chineseState2',
      swipeUp: { action: { shortcut: '#方案切换' } },

      [if !std.startsWith(settings.keyboardLayout, '26') then 'swipeDown']: {
        action: { keyboardType: 'temp26Key' },
      }
    },
  },

  pinyinButton: {
    name: 'pinyinButton',
    params: {
      action: { keyboardType: 'pinyin' },
      assetImageName: 'englishState2',
    },
  },

  asciiModeButton: {
    name: 'asciiModeButton',
    params: {
      action: { shortcut: '#中英切换' },
      assetImageName: 'chineseState2',
      swipeUp: { action: { shortcut: '#方案切换' } },

      whenRimeOptionChanged: {
        optionName: 'ascii_mode',
        optionValue: true,
        assetImageName: 'englishState2'
      },
    },
  },

  commaButton: {
    name: 'commaButton',
    params: {
      action: { character: ',', },
      text: '，',
      center: { y: 0.52 },

      swipeUp: {
        action: { character: '.' },
        text: '。',
        center: { y: 0.3 }
      },

      OnAlphabetic: {
        text: ',', center: { y: 0.48 },
        swipeUp: { text: '.', center: { y: 0.28 } },
      },
    },
  },

  clearPreeditButton: {
    name: 'clearPreeditButton',
    params: {
      action: { shortcut: '#换行' },
      text: '换行',

      whenPreeditChanged: {
        action: { shortcut: '#重输' },
        text: '重输',
      },
    },
  },

}
