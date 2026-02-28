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

  // 每行高度
  rowHeight: if !settings.iPad then
    {
      portrait: 54,
      landscape: 40,
    }
    else
    {
      portrait: 64,
      landscape: 86,
    },

  // 特殊功能键
  spaceButton: {
    name: 'spaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
      center: {x: 0.5, y: 0.5},
      notification:
        (if settings.spaceButtonShowSchema then
          ['rimeSchemaChangedNotification']
        else []),

      whenPreeditChanged: {
        text: settings.spaceButtonComposingText,
        fontSize: fonts.systemButtonTextFontSize,

        swipeUp: { action: { shortcut: '#次选上屏' } },
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
      repeatAction: 'backspace',
      systemImageName: 'delete.left',
      highlightSystemImageName: 'delete.left.fill',
      swipeUp: { action: { shortcut: '#deleteText'} },
      swipeDown: { action: { shortcut: '#undo' } },
    },
  },

  shiftButton: {
    name: 'shiftButton',
    params: {
      systemImageName: 'shift',
      action: 'shift',

      uppercased: { systemImageName: 'shift.fill', },
      capsLocked: { systemImageName: 'capslock.fill', },

      whenPreeditChanged: {
        action: settings.segmentAction,
        // systemImageName: 'square.and.line.vertical.and.square',
        text: '分词',
      },
    },
  },

  enterButton: {
    name: 'enterButton',
    params: {
      action: 'enter',
      text: '$returnKeyType',
      notification: [
        'returnKeyTypeChangedNotification',
      ],

      swipeUp: { action: { shortcut: '#行首' } },
      swipeDown: { action: { shortcut: '#行尾' } },

      longPress: [
        {
          action: { shortcut: '#换行' },
          systemImageName: 'paragraphsign',
        },
      ],

      whenPreeditChanged: {
        text: '确认',
        backgroundStyle: 'systemButtonBackgroundStyle',
        normalColor: colors.systemButtonForegroundColor,
      },
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
    },
  },

  numericButton: {
    name: 'numericButton',
    params: {
      action: { keyboardType: 'numeric' },
      text: '123',
      swipeUp: { action: { keyboardType: 'symbolic' } },
      swipeDown: { action: { keyboardType: 'emojis' } },

      // whenPreeditChanged: {
      //   action: settings.segmentAction,
      //   text: '分词',
      // },
    },
  },

  symbolicButton: {
    name: 'symbolicButton',
    params: {
      action: { keyboardType: 'symbolic' },
      text: '#+=',
    },
  },

  segmentButton: {
    name: 'segmentButton',
    params: {
      action: settings.segmentAction,
      text: '分词',
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

      whenAlphabetic: {
        text: ',', center: { y: 0.48 },
        swipeUp: { text: '.', center: { y: 0.28 } },
      },
    },
  },

  clearPreeditButton: {
    name: 'clearPreeditButton',
    params: {
      action: { shortcut: '#重输' },
      text: '重输',
    },
  },

}
