# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文18键布局的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  // 按键定义
  qButton: {
    name: 'qButton',
    params: {
      text: 'q',
      action: { character: 'q' },
      swipeUp: { action: { character: '#' } },
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      text: 'w e',
      action: { character: 'w' },
      swipeUp: { action: { character: '1' } },
    },
  },
  rButton: {
    name: 'rButton',
    params: {
      text: 'r t',
      action: { character: 'r' },
      swipeUp: { action: { character: '2' } },
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      text: 'y',
      action: { character: 'y' },
      swipeUp: { action: { character: '3' } },
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      text: 'u',
      action: { character: 'u' },
      swipeUp: { action: { character: '\\' } },
    },
  },
  iButton: {
    name: 'iButton',
    params: {
      text: 'i o',
      action: { character: 'i' },
      swipeUp: { action: { character: ':' } },
    },
  },
  pButton: {
    name: 'pButton',
    params: {
      text: 'p',
      action: { character: 'p' },
      swipeUp: { action: { character: '"' } },
    },
  },

  // 第二行字母键 (ASDF)
  aButton: {
    name: 'aButton',
    params: {
      text: 'a',
      action: { character: 'a' },
      swipeUp: { action: { character: '!' } },
      longPress: [
        {
          action: { shortcut: '#左手模式' },
          systemImageName: { ios: 'keyboard.onehanded.left', android: 'mobile_hand_left'}
        },
      ],
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      text: 's d',
      action: { character: 's' },
      swipeUp: { action: { character: '4' } },
    },
  },
  fButton: {
    name: 'fButton',
    params: {
      text: 'f g',
      action: { character: 'f' },
      swipeUp: { action: { character: '5' } },
    },
  },
  hButton: {
    name: 'hButton',
    params: {
      text: 'h',
      action: { character: 'h' },
      swipeUp: { action: { character: '6' } },
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      text: 'j k',
      action: { character: 'j' },
      swipeUp: { action: { character: '^' } },
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      text: 'l',
      action: { character: 'l' },
      swipeUp: { action: { character: '?' } },
      longPress: [
        {
          action: { shortcut: '#右手模式' },
          systemImageName: { ios: 'keyboard.onehanded.right', android: 'mobile_hand_right'},
        },
      ],
    },
  },

  // 第三行字母键 (ZXCV)
  zButton: {
    name: 'zButton',
    params: {
      text: 'z',
      action: { character: 'z' },
      swipeUp: { action: { character: '@' } },
    },
  },
  xButton: {
    name: 'xButton',
    params: {
      text: 'x c',
      action: { character: 'x' },
      swipeUp: { action: { character: '7' } },
    },
  },
  vButton: {
    name: 'vButton',
    params: {
      text: 'v',
      action: { character: 'v' },
      swipeUp: { action: { character: '8' } },
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      text: 'b n',
      action: { character: 'b' },
      swipeUp: { action: { character: '9' } },
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      text: 'm',
      action: { character: 'm' },
      swipeUp: { action: { character: '0' } },
    },
  },

  letterButtons: [
    self.qButton, self.wButton, self.rButton, self.yButton, self.uButton, self.iButton, self.pButton,
    self.aButton, self.sButton, self.fButton, self.hButton, self.jButton, self.lButton,
    self.zButton, self.xButton, self.vButton, self.bButton, self.mButton,
  ],
}
