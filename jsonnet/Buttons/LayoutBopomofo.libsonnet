# =====================================
# 此文件用於自定義鍵盤按鍵功能。
# 可根據需要修改下方內容，調整各類按鍵的行為
# 修改完成後，保存本文件，然後回到皮膚界面，
# 長按皮膚，選擇「運行 main.jsonnet」生效。
#
# 包含注音鍵盤中的 41 個按鍵（聲母 + 韻母 + 聲調）
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';
local commonButtons = import './Common.libsonnet';

{
  local root = self,

  // ===== 第一行（數字鍵）：1=ㄅ 2=ㄉ 3=ˇ 4=ˋ 5=ㄓ 6=ˊ 7=˙ 8=ㄚ 9=ㄞ 0=ㄢ -=ㄦ =====
  bpmfOneButton: {
    name: 'bpmfOneButton',
    params: {
      text: 'ㄅ',
      action: { character: '1' },
    },
  },
  bpmfTwoButton: {
    name: 'bpmfTwoButton',
    params: {
      text: 'ㄉ',
      action: { character: '2' },
    },
  },
  bpmfThreeButton: {
    name: 'bpmfThreeButton',
    params: {
      text: 'ˇ',
      action: { character: '3' },
    },
  },
  bpmfFourButton: {
    name: 'bpmfFourButton',
    params: {
      text: 'ˋ',
      action: { character: '4' },
    },
  },
  bpmfFiveButton: {
    name: 'bpmfFiveButton',
    params: {
      text: 'ㄓ',
      action: { character: '5' },
    },
  },
  bpmfSixButton: {
    name: 'bpmfSixButton',
    params: {
      text: 'ˊ',
      action: { character: '6' },
    },
  },
  bpmfSevenButton: {
    name: 'bpmfSevenButton',
    params: {
      text: '˙',
      action: { character: '7' },
    },
  },
  bpmfEightButton: {
    name: 'bpmfEightButton',
    params: {
      text: 'ㄚ',
      action: { character: '8' },
    },
  },
  bpmfNineButton: {
    name: 'bpmfNineButton',
    params: {
      text: 'ㄞ',
      action: { character: '9' },
    },
  },
  bpmfZeroButton: {
    name: 'bpmfZeroButton',
    params: {
      text: 'ㄢ',
      action: { character: '0' },
    },
  },
  bpmfDashButton: {
    name: 'bpmfDashButton',
    params: {
      text: 'ㄦ',
      action: { character: '-' },
    },
  },

  // ===== 第二行（QWERTY）：q=ㄆ w=ㄊ e=ㄍ r=ㄐ t=ㄔ y=ㄗ u=ㄧ i=ㄛ o=ㄟ p=ㄣ =====
  qButton: {
    name: 'qButton',
    params: {
      text: 'ㄆ',
      action: { character: 'q' },
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      text: 'ㄊ',
      action: { character: 'w' },
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      text: 'ㄍ',
      action: { character: 'e' },
    },
  },
  rButton: {
    name: 'rButton',
    params: {
      text: 'ㄐ',
      action: { character: 'r' },
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      text: 'ㄔ',
      action: { character: 't' },
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      text: 'ㄗ',
      action: { character: 'y' },
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      text: 'ㄧ',
      action: { character: 'u' },
    },
  },
  iButton: {
    name: 'iButton',
    params: {
      text: 'ㄛ',
      action: { character: 'i' },
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      text: 'ㄟ',
      action: { character: 'o' },
    },
  },
  pButton: {
    name: 'pButton',
    params: {
      text: 'ㄣ',
      action: { character: 'p' },
    },
  },

  // ===== 第三行（ASDF）：a=ㄇ s=ㄋ d=ㄎ f=ㄑ g=ㄕ h=ㄘ j=ㄨ k=ㄜ l=ㄠ ;=ㄤ =====
  aButton: {
    name: 'aButton',
    params: {
      text: 'ㄇ',
      action: { character: 'a' },
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      text: 'ㄋ',
      action: { character: 's' },
    },
  },
  dButton: {
    name: 'dButton',
    params: {
      text: 'ㄎ',
      action: { character: 'd' },
    },
  },
  fButton: {
    name: 'fButton',
    params: {
      text: 'ㄑ',
      action: { character: 'f' },
    },
  },
  gButton: {
    name: 'gButton',
    params: {
      text: 'ㄕ',
      action: { character: 'g' },
    },
  },
  hButton: {
    name: 'hButton',
    params: {
      text: 'ㄘ',
      action: { character: 'h' },
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      text: 'ㄨ',
      action: { character: 'j' },
    },
  },
  kButton: {
    name: 'kButton',
    params: {
      text: 'ㄜ',
      action: { character: 'k' },
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      text: 'ㄠ',
      action: { character: 'l' },
    },
  },
  bpmfSemicolonButton: {
    name: 'bpmfSemicolonButton',
    params: {
      text: 'ㄤ',
      action: { character: ';' },
    },
  },

  // ===== 第四行（ZXCV）：z=ㄈ x=ㄌ c=ㄏ v=ㄒ b=ㄖ n=ㄙ m=ㄩ ,=ㄝ .=ㄡ /=ㄥ =====
  zButton: {
    name: 'zButton',
    params: {
      text: 'ㄈ',
      action: { character: 'z' },
    },
  },
  xButton: {
    name: 'xButton',
    params: {
      text: 'ㄌ',
      action: { character: 'x' },
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      text: 'ㄏ',
      action: { character: 'c' },
    },
  },
  vButton: {
    name: 'vButton',
    params: {
      text: 'ㄒ',
      action: { character: 'v' },
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      text: 'ㄖ',
      action: { character: 'b' },
    },
  },
  nButton: {
    name: 'nButton',
    params: {
      text: 'ㄙ',
      action: { character: 'n' },
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      text: 'ㄩ',
      action: { character: 'm' },
    },
  },
  bpmfCommaButton: {
    name: 'bpmfCommaButton',
    params: {
      text: 'ㄝ',
      action: { character: ',' },
    },
  },
  bpmfPeriodButton: {
    name: 'bpmfPeriodButton',
    params: {
      text: 'ㄡ',
      action: { character: '.' },
    },
  },
  bpmfSlashButton: {
    name: 'bpmfSlashButton',
    params: {
      text: 'ㄥ',
      action: { character: '/' },
    },
  },

  // 所有注音按鍵
  letterButtons: [
    // 第一行（11 鍵）：數字鍵
    self.bpmfOneButton, self.bpmfTwoButton, self.bpmfThreeButton, self.bpmfFourButton, self.bpmfFiveButton,
    self.bpmfSixButton, self.bpmfSevenButton, self.bpmfEightButton, self.bpmfNineButton, self.bpmfZeroButton,
    self.bpmfDashButton,
    // 第二行（10 鍵）：QWERTY
    self.qButton, self.wButton, self.eButton, self.rButton, self.tButton,
    self.yButton, self.uButton, self.iButton, self.oButton, self.pButton,
    // 第三行（10 鍵）：ASDF
    self.aButton, self.sButton, self.dButton, self.fButton, self.gButton,
    self.hButton, self.jButton, self.kButton, self.lButton, self.bpmfSemicolonButton,
    // 第四行（10 鍵）：ZXCV
    self.zButton, self.xButton, self.cButton, self.vButton, self.bButton,
    self.nButton, self.mButton, self.bpmfCommaButton, self.bpmfPeriodButton, self.bpmfSlashButton,
  ],

  commaButton: {
    name: 'commaButton',
    params: {
      action: { symbol: '，', },
      text: '，',
      center: { y: 0.52 },

      swipeUp: {
        action: { symbol: '。' },
        text: '。',
        center: { y: 0.3 },
      },

      longPress: [
        { action: { symbol: '！' } },
        { action: { symbol: '？' }, selected: true },
        { action: { symbol: '、' } },
        { action: { symbol: '……' } },
      ],

      whenAlphabetic: {
        text: ',', center: { y: 0.48 },
        swipeUp: { text: '.', center: { y: 0.28 } },
      },
    },
  },

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
        text: '一聲',
        fontSize: fonts.systemButtonTextFontSize,
      },
    },
  },

  enterButton: {
    name: 'enterButton',
    params: commonButtons.enterButton.params + {
      // 注音方案中，回車鍵打字時功能爲“選定”而非“确认”
      whenPreeditChanged+: {
        text: '選定',
      },
    },
  },
}
