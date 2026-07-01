# =====================================
# 此文件用于自定义符号键盘（行式布局第二页）按键功能。
# 包含从数字键盘切换 #+= 后展示的符号按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  // 第一行符号
  leftBracketButton: {
    name: 'leftBracketButton',
    params: {
      action: { character: '[' },
    },
  },
  rightBracketButton: {
    name: 'rightBracketButton',
    params: {
      action: { character: ']' },
    },
  },
  leftBraceButton: {
    name: 'leftBraceButton',
    params: {
      action: { character: '{' },
    },
  },
  rightBraceButton: {
    name: 'rightBraceButton',
    params: {
      action: { character: '}' },
    },
  },
  leftCornerBracketButton: {
    name: 'leftCornerBracketButton',
    params: {
      action: { symbol: '〔' },
    },
  },
  rightCornerBracketButton: {
    name: 'rightCornerBracketButton',
    params: {
      action: { symbol: '〕' },
    },
  },
  percentButton: {
    name: 'percentButton',
    params: {
      action: { character: '%' },
    },
  },
  caretButton: {
    name: 'caretButton',
    params: {
      action: { character: '^' },
    },
  },
  multipleSymButton: {
    name: 'multipleSymButton',
    params: {
      action: { character: '×' },
    },
  },
  divideSymButton: {
    name: 'divideSymButton',
    params: {
      action: { character: '÷' },
    },
  },

  // 第二行符号
  underscoreButton: {
    name: 'underscoreButton',
    params: {
      action: { symbol: '_' },
    },
  },
  backSlashButton: {
    name: 'backSlashButton',
    params: {
      action: { symbol: '\\' },
    },
  },
  pipeButton: {
    name: 'pipeButton',
    params: {
      action: { symbol: '|' },
    },
  },
  tildeButton: {
    name: 'tildeButton',
    params: {
      action: { character: '~' },
    },
  },
  lessThanButton: {
    name: 'lessThanButton',
    params: {
      action: { character: '<' },
    },
  },
  greaterThanButton: {
    name: 'greaterThanButton',
    params: {
      action: { character: '>' },
    },
  },
  backQuoteButton: {
    name: 'backQuoteButton',
    params: {
      action: { symbol: '`' },
    },
  },
  yenButton: {
    name: 'yenButton',
    params: {
      action: { symbol: '¥' },

      OnAlphabetic: {
        text: '$',
        action: { symbol: '$' } ,
      },
    },
  },
  euroButton: {
    name: 'euroButton',
    params: {
      action: { symbol: '‘', },

      OnAlphabetic: {
        action: { symbol: '€' },
      },
    },
  },
  poundButton: {
    name: 'poundButton',
    params: {
      action: { symbol: '’', },

      OnAlphabetic: {
        action: { symbol: '£' },
      },
    },
  },

  // 第三行符号
  longDashButton: {
    name: 'longDashButton',
    params: {
      text: '—',
      action: { symbol: '——' },
    },
  },
  centerDotButton: {
    name: 'centerDotButton',
    params: {
      action: { symbol: '・' },

      OnAlphabetic: {
        action: { symbol: '·' },
      },
    },
  },
  almostEqualButton: {
    name: 'almostEqualButton',
    params: {
      action: { symbol: '≈' },
    },
  },
  leftBookTitleMarkButton: {
    name: 'leftBookTitleMarkButton',
    params: {
      action: { symbol: '《' },

      OnAlphabetic: {
        action: { symbol: 'i' },
      },
    },
  },
  rightBookTitleMarkButton: {
    name: 'rightBookTitleMarkButton',
    params: {
      action: { symbol: '》' },

      OnAlphabetic: {
        action: { symbol: '?' },
      },
    },
  },
  sectionSymButton: {
	  name: 'sectionSymButton',
    params: {
      action: { symbol: '§' },
    },
  },
  temperatureButton: {
    name: 'temperatureButton',
    params: {
      action: { symbol: '℃' },

      OnAlphabetic: {
        action: { symbol: '℉' },
      },
    },
  },

  // 第四行
  symbolicSpaceButton: {
    name: 'symbolicSpaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
    },
  },
  ellipsisButton: {
    name: 'ellipsisButton',
    params: {
      action: { symbol: '…' },
    },
  },
  etcButton: {
    name: 'etcButton',
    params: {
      action: { symbol: '々' },

      OnAlphabetic: {
        action: { symbol: '¶' },
      },
    },
  },

}
