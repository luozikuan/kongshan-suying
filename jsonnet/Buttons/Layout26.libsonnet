# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文26键布局和英文26键布局中的字母键
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
      action: { character: 'q' },
      uppercased: { action: { character: 'Q' } },
      swipeUp: { action: { character: '1' } },
      swipeDown: {
        action: 'tab',
        systemImageName: { ios: 'arrow.right.to.line', android: 'keyboard_tab'}
      },
      longPress: [
        { action: { character: 'Q' } },
      ],
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      action: { character: 'w' },
      uppercased: { action: { character: 'W' } },
      swipeUp: { action: { character: '2' } },
      longPress: [
        { action: { character: 'W' } },
      ],
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      action: { character: 'e' },
      uppercased: { action: { character: 'E' } },
      swipeUp: { action: { character: '3' } },
      longPress: [
        { action: { character: 'E' } },
      ],
    },
  },
  rButton: {
    name: 'rButton',
    params: {
      action: { character: 'r' },
      uppercased: { action: { character: 'R' } },
      swipeUp: { action: { character: '4' } },
      longPress: [
        { action: { character: 'R' } },
      ],
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      action: { character: 't' },
      uppercased: { action: { character: 'T' } },
      swipeUp: { action: { character: '5' } },
      longPress: [
        { action: { character: 'T' } },
      ],
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      action: { character: 'y' },
      uppercased: { action: { character: 'Y' } },
      swipeUp: { action: { character: '6' } },
      longPress: [
        { action: { character: 'Y' } },
      ],
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      action: { character: 'u' },
      uppercased: { action: { character: 'U' } },
      swipeUp: { action: { character: '7' } },
      longPress: [
        { action: { character: 'U' } },
      ],
    },
  },
  iButton: {
    name: 'iButton',
    params: {
      action: { character: 'i' },
      uppercased: { action: { character: 'I' } },
      swipeUp: { action: { character: '8' } },
      swipeDown: { action: { character: '|' } },
      longPress: [
        { action: { character: 'I' } },
      ],
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      action: { character: 'o' },
      uppercased: { action: { character: 'O' } },
      swipeUp: { action: { character: '9' } },
      swipeDown: { action: { character: '<' } },
      longPress: [
        { action: { character: 'O' } },
      ],
    },
  },
  pButton: {
    name: 'pButton',
    params: {
      action: { character: 'p' },
      uppercased: { action: { character: 'P' } },
      swipeUp: { action: { character: '0' } },
      swipeDown: { action: { character: '>' } },
      longPress: [
        { action: { character: 'P' } },
      ],
    },
  },

  // 第二行字母键 (ASDF)
  aButton: {
    name: 'aButton',
    params: {
      action: { character: 'a' },
      uppercased: { action: { character: 'A' } },
      swipeUp: { action: { character: '!' } },
      swipeDown: {
        action: { shortcut: '#selectText' },
        text: '全',
        systemImageName: { ios: 'selection.pin.in.out', android: 'select_all'},
      },
      longPress: [
        { action: { character: 'A' }, selected: true },
        { action: { shortcut: '#左手模式' }, systemImageName: { ios: 'keyboard.onehanded.left', android: 'mobile_hand_left'} },
      ],
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      action: { character: 's' },
      uppercased: { action: { character: 'S' } },
      swipeUp: { action: { character: '^' } },
      swipeDown: { action: { character: '%' } },
      longPress: [
        { action: { character: 'S' } },
      ],
    },
  },
  dButton: {
    name: 'dButton',
    params: {
      action: { character: 'd' },
      uppercased: { action: { character: 'D' } },
      swipeUp: { action: { character: '/' } },
      swipeDown: { action: { character: '\\' } },
      longPress: [
        { action: { character: 'D' } },
      ],
    },
  },
  fButton: {
    name: 'fButton',
    params: {
      action: { character: 'f' },
      uppercased: { action: { character: 'F' } },
      swipeUp: { action: { character: ';' } },
      swipeDown: { action: { character: ':' } },
      longPress: [
        { action: { character: 'F' } },
      ],
    },
  },
  gButton: {
    name: 'gButton',
    params: {
      action: { character: 'g' },
      uppercased: { action: { character: 'G' } },
      swipeUp: { action: { character: '(' } },
      swipeDown: { action: { character: ')' } },
      longPress: [
        { action: { character: 'G' } },
      ],
    },
  },
  hButton: {
    name: 'hButton',
    params: {
      action: { character: 'h' },
      uppercased: { action: { character: 'H' } },
      swipeUp: { action: { character: '-' } },
      swipeDown: { action: { character: '_' } },
      longPress: [
        { action: { character: 'H' } },
      ],
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      action: { character: 'j' },
      uppercased: { action: { character: 'J' } },
      swipeUp: { action: { character: '#' } },
      swipeDown: { action: { character: '+' } },
      longPress: [
        { action: { character: 'J' } },
      ],
    },
  },
  kButton: {
    name: 'kButton',
    params: {
      action: { character: 'k' },
      uppercased: { action: { character: 'K' } },
      swipeUp: { action: { character: '{' } },
      swipeDown: { action: { character: '}' } },
      longPress: [
        { action: { character: 'K' } },
      ],
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      action: { character: 'l' },
      uppercased: { action: { character: 'L' } },
      swipeUp: { action: { character: '"' } },
      swipeDown: { action: { character: "'" } },
      longPress: [
        { action: { shortcut: '#右手模式' }, systemImageName: { ios: 'keyboard.onehanded.right', android: 'mobile_hand_right'} },
        { action: { character: 'L' }, selected: true },
      ],
    },
  },

  // 第三行字母键 (ZXCV)
  zButton: {
    name: 'zButton',
    params: {
      action: { character: 'z' },
      uppercased: { action: { character: 'Z' } },
      swipeUp: { action: { character: '@' } },
      swipeDown: {
        action: { shortcut: '#undo' },
        text: '撤',
        systemImageName: { ios: 'arrow.uturn.left', android: 'undo'}
      },
      longPress: [
        { action: { character: 'Z' } },
      ],
    },
  },
  xButton: {
    name: 'xButton',
    params: {
      action: { character: 'x' },
      uppercased: { action: { character: 'X' } },
      swipeUp: { action: { character: '*' } },
      swipeDown: {
        action: { shortcut: '#cut' },
        text: '剪',
        systemImageName: { ios: 'scissors', android: 'content_cut'}
      },
      longPress: [
        { action: { character: 'X' } },
      ],
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      action: { character: 'c' },
      uppercased: { action: { character: 'C' } },
      swipeUp: { action: { character: '`' } },
      swipeDown: {
        action: { shortcut: '#copy' },
        text: '复',
        systemImageName: { ios: 'doc.on.doc', android: 'content_copy'}
      },
      longPress: [
        { action: { character: 'C' } },
      ],
    },
  },
  vButton: {
    name: 'vButton',
    params: {
      action: { character: 'v' },
      uppercased: { action: { character: 'V' } },
      swipeUp: { action: { character: '=' } },
      swipeDown: {
        action: { shortcut: '#paste' },
        text: '贴',
        systemImageName: { ios: 'doc.on.clipboard', android: 'content_paste'}
      },
      longPress: [
        { action: { character: 'V' } },
      ],
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      action: { character: 'b' },
      uppercased: { action: { character: 'B' } },
      swipeUp: { action: { character: '[' } },
      swipeDown: { action: { character: ']' } },
      longPress: [
        { action: { character: 'B' } },
      ],
    },
  },
  nButton: {
    name: 'nButton',
    params: {
      action: { character: 'n' },
      uppercased: { action: { character: 'N' } },
      swipeUp: { action: { character: '&' } },
      swipeDown: { action: { character: '~' } },
      longPress: [
        { action: { character: 'N' } },
      ],
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      action: { character: 'm' },
      uppercased: { action: { character: 'M' } },
      swipeUp: { action: { character: '?' } },
      swipeDown: { action: { character: '$' } },
      longPress: [
        { action: { character: 'M' } },
      ],
    },
  },

  letterButtons: [
    self.qButton, self.wButton, self.eButton, self.rButton, self.tButton,
    self.yButton, self.uButton, self.iButton, self.oButton, self.pButton,
    self.aButton, self.sButton, self.dButton, self.fButton, self.gButton,
    self.hButton, self.jButton, self.kButton, self.lButton,
    self.zButton, self.xButton, self.cButton, self.vButton, self.bButton,
    self.nButton, self.mButton,
  ],
}
