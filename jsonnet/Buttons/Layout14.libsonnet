# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文14键布局的按键
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
      text: 'q w',
      action: { character: 'q' },
      swipeUp: { action: { character: '1' } },
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      text: 'e r',
      action: { character: 'e' },
      swipeUp: { action: { character: '2' } },
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      text: 't y',
      action: { character: 't' },
      swipeUp: { action: { character: '3' } },
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      text: 'u i',
      action: { character: 'u' },
      swipeUp: { action: { character: '4' } },
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      text: 'o p',
      action: { character: 'o' },
      swipeUp: { action: { character: '5' } },
    },
  },

  // 第二行字母键 (ASDF)
  aButton: {
    name: 'aButton',
    params: {
      text: 'a s',
      action: { character: 'a' },
      swipeUp: { action: { character: '6' } },
      longPress: [
        {
          action: { shortcut: '#左手模式' },
          systemImageName: { ios: 'keyboard.onehanded.left', android: 'mobile_hand_left'},
        },
      ],
    },
  },
  dButton: {
    name: 'dButton',
    params: {
      text: 'd f',
      action: { character: 'd' },
      swipeUp: { action: { character: '7' } },
    },
  },
  gButton: {
    name: 'gButton',
    params: {
      text: 'g h',
      action: { character: 'g' },
      swipeUp: { action: { character: '8' } },
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      text: 'j k',
      action: { character: 'j' },
      swipeUp: { action: { character: '9' } },
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      text: 'l',
      action: { character: 'l' },
      swipeUp: { action: { character: '0' } },
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
      text: 'z x',
      action: { character: 'z' },
      swipeUp: { action: { character: '@' } },
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      text: 'c v',
      action: { character: 'c' },
      swipeUp: { action: { character: '"' } },
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      text: 'b n',
      action: { character: 'b' },
      swipeUp: { action: { character: '!' } },
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      text: 'm',
      action: { character: 'm' },
      swipeUp: { action: { character: '?' } },
    },
  },

  letterButtons: [
    self.qButton, self.eButton, self.tButton, self.uButton, self.oButton,
    self.aButton, self.dButton, self.gButton, self.jButton, self.lButton,
    self.zButton, self.cButton, self.bButton, self.mButton,
  ],
}
