# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含西戈码布局的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';
local commonButtons = import './Common.libsonnet';

{
  local root = self,

  // 按键定义
  qButton: {
    name: 'qButton',
    params: {
      text: 'QKP',
      action: { character: 'q' },
      swipeUp: { action: { character: '(' } },
      swipeDown: { action: { character: ')' } },
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      text: 'T ng',
      action: { character: 't' },
      swipeUp: { action: { character: '!' } },
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      text: 'L',
      action: { character: 'l' },
      swipeUp: { action: { character: '`' } },
    },
  },
  nButton: {
    name: 'nButton',
    params: {
      text: 'Nü ͥ ͦ',
      action: { character: 'n' },
      swipeUp: { action: { character: "'" } },
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      text: 'CʰC',
      action: { character: 'c' },
      swipeUp: { action: { character: '#' } },
    },
  },

  jButton: {
    name: 'jButton',
    params: {
      text: 'JGM',
      action: { character: 'j' },
      swipeUp: { action: { character: ':' } },
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      text: 'D e',
      action: { character: 'e' },
      swipeUp: { action: { character: '\\' } },
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      text: 'B o  ͮ ͣ',
      action: { character: 'o' },
      swipeUp: { action: { character: '@' } },
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      text: 'Y i',
      action: { character: 'y' },
      swipeUp: { action: { character: '"' } },
    },
  },
  zButton: {
    name: 'zButton',
    params: {
      text: 'ZʰZ',
      action: { character: 'z' },
      swipeUp: { action: { character: '_' } },
    },
  },

  xButton: {
    name: 'xButton',
    params: {
      text: 'XHR ua',
      action: { character: 'x' },
      swipeUp: { action: { character: '{' } },
      swipeDown: { action: { character: '}' } },

      whenPreeditChanged: {
        swipeUp: {
          action: { character: '7' },
          text: '一声',
        },
      },
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      text: 'W u',
      action: { character: 'w' },
      swipeUp: { action: { character: '?' } },

      whenPreeditChanged: {
        swipeUp: {
          action: { character: '8' },
          text: '二声',
        },
      },
    },
  },
  aButton: {
    name: 'aButton',
    params: {
      text: 'F a',
      action: { character: 'a' },
      swipeUp: { action: { character: ';' } },

      whenPreeditChanged: {
        swipeUp: {
          action: { character: '9' },
          text: '三声',
        },
      },
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      text: 'SʰS ia',
      action: { character: 's' },
      swipeUp: { action: { character: '^' } },

      whenPreeditChanged: {
        swipeUp: {
          action: { character: '0' },
          text: '四声',
        },
      },
    },
  },

  letterButtons: [
    self.qButton, self.tButton, self.lButton, self.nButton, self.cButton,
    self.jButton, self.eButton, self.oButton, self.yButton, self.zButton,
    self.xButton, self.wButton, self.aButton, self.sButton,
  ],

  commaButton: {
    name: 'commaButton',
    params: std.mergePatch(commonButtons.commaButton.params, {
      whenPreeditChanged: {
        action: { character: 'h' },
        center: { y: 0.5 },
      },
    }),
  },

  alphabeticButton: {
    name: 'alphabeticButton',
    params: std.mergePatch(commonButtons.alphabeticButton.params, {
      longPress: [
        {
          action: { keyboardType: 'symbolic', },
          systemImageName: { ios: 'number', android: 'numbers'},
          text: '符号',
        },
        {
          action: { keyboardType: 'numeric', },
          systemImageName: { ios: 'textformat.123', android: '123'},
          text: '数字',
          selected: true,  # 初始选中项
        },
        {
          action: { keyboardType: 'emojis', },
          // systemImageName: 'face.smiling.inverse', // ios 这个表情经常会异常反色
          systemImageName: { ios: 'face.dashed', android: 'sentiment_excited'},
          text: '表情',
        },
      ],
    }),
  },
}
