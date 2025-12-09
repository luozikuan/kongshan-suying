local colors = import 'Colors.libsonnet';
local fonts = import 'Fonts.libsonnet';
local settings = import 'Settings.libsonnet';

{
  local root = self,

  preedit: {
    height: 21,
    insets: {
      top: 2,
      left: 4,
    },
    fontSize: fonts.preeditFontSize,
  },

  toolbar: {
    height: 45,
    insets: {
      top: 6,
    },
  },

  candidateStyle: {
    highlightBackgroundColor: colors.candidateHighlightColor,
    preferredBackgroundColor: colors.candidateHighlightColor,
    preferredIndexColor: colors.candidateForegroundColor,
    preferredTextColor: colors.candidateForegroundColor,
    preferredCommentColor: colors.candidateForegroundColor,
    indexColor: colors.candidateForegroundColor,
    textColor: colors.candidateForegroundColor,
    commentColor: colors.candidateForegroundColor,
    indexFontSize: fonts.candidateIndexFontSize,
    #indexFontWeight: 'ultraLight',
    textFontSize: fonts.candidateTextFontSize,
    #textFontWeight: 'regular',
    commentFontSize: fonts.candidateCommentFontSize,
    #commentFontWeight: 'black',
  },

  horizontalCandidateStyle:
    {
      insets: {
        top: 8,
        left: 3,
        bottom: 1,
      },
      expandButton: {
        systemImageName: 'chevron.forward',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
    },

  verticalCandidateStyle:
    {
      // insets 用于展开候选字后的区域内边距
      // insets: { top: 3, bottom: 3, left: 4, right: 4 },
      bottomRowHeight: 45,
      candidateCollectionStyle: {
        insets: { top: 8, bottom: 8, left: 8, right: 8 },
        backgroundColor: colors.keyboardBackgroundColor,
        maxRows: 5,
        maxColumns: 6,
        separatorColor: colors.candidateSeparatorColor,
      },
      pageUpButton: {
        action: { shortcut: '#verticalCandidatesPageUp' },
        systemImageName: 'chevron.up',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
      pageDownButton: {
        action: { shortcut: '#verticalCandidatesPageDown' },
        systemImageName: 'chevron.down',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
      returnButton: {
        action: { shortcut: '#candidatesBarStateToggle' },
        systemImageName: 'return',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
    },

  floatingKeyboard: {
    floatTargetScale: {
      portrait: { x: 0.8, y: 0.6 },
      landscape: { x: 0.45, y: 0.8 },
    },
    insets: {
      top: 10,
      left: 12,
      bottom: 10,
      right: 12,
    },

    button: {
      backgroundInsets: {
        iPhone: {
          portrait: { top: 6, left: 3, bottom: 6, right: 3 },
          landscape: { top: 3, left: 3, bottom: 3, right: 3 },
        },
        ipad: {
          portrait: { top: 3, left: 3, bottom: 3, right: 3 },
          landscape: { top: 4, left: 6, bottom: 4, right: 6 },
        },
      },
    },
  },

  // toolbar 或浮动键盘按键定义，按键名需要注意不要和 keyboard 下的按键名冲突，所以加 tb 前缀
  toolbarButton: {
    toolbarMenuButton: {
      name: 'toolbarMenuButton',
      params: {
        action: { floatKeyboardType: 'panel', },
        systemImageName: 'swirl.circle.righthalf.filled',
        text: '面板',
      },
    },
    toolbarDismissButton: {
      name: 'toolbarDismissButton',
      params: {
        action: 'dismissKeyboard',
        systemImageName: 'chevron.down',
        text: '关闭',
      },
    },

    toolbarPerformanceButton: {
      name: 'toolbarPerformanceButton',
      params: {
        action: { shortcut: '#keyboardPerformance' },
        systemImageName: 'speedometer',
        text: '性能',
      },
    },
    toolbarPhraseButton: {
      name: 'toolbarPhraseButton',
      params: {
        action: { shortcut: '#showPhraseView' },
        systemImageName: 'heart',
        text: '短语',
      },
    },
    toolbarScriptButton: {
      name: 'toolbarScriptButton',
      params: {
        action: { shortcut: '#toggleScriptView' },
        systemImageName: 'apple.terminal',
        text: '脚本',
      },
    },
    toolbarClipboardButton: {
      name: 'toolbarClipboardButton',
      params: {
        action: { shortcut: '#showPasteboardView' },
        systemImageName: 'clipboard',
        text: '剪贴',
      },
    },
    toolbarRimeSwitcherButton: {
      name: 'toolbarRimeSwitcherButton',
      params: {
        action: { shortcut: '#RimeSwitcher' },
        systemImageName: 'switch.2',
        text: 'RimeSwitcher',
      },
    },
    toolbarSchemaSelectorButton: {
      name: 'toolbarSchemaSelectorButton',
      params: {
        action: { shortcut: '#方案切换' },
        systemImageName: 'list.bullet.rectangle',
        text: '方案切换',
      },
    },

    toolbarHamster3Button: {
      name: 'toolbarHamster3Button',
      params: {
        action: 'settings',
        systemImageName: 'keyboard',
        text: '元书',
      },
    },
    toolbarCheckUpdateButton: {
      name: 'toolbarCheckUpdateButton',
      params: {
        action: { openURL: 'https://apps.apple.com/cn/app/%E5%85%83%E4%B9%A6%E8%BE%93%E5%85%A5%E6%B3%95/id6744464701' },
        systemImageName: 'arrow.down.circle',
        text: '检查更新',
      },
    },
    toolbarFeedbackButton: {
      name: 'toolbarFeedbackButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/feedback' },
        systemImageName: 'iphone.radiowaves.left.and.right',
        text: '按键震动',
      },
    },
    toolbarFinderButton: {
      name: 'toolbarFinderButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
        systemImageName: 'folder',
        text: '文件管理',
      },
    },
    toolbarSkinButton: {
      name: 'toolbarSkinButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
        systemImageName: 'tshirt',
        text: '键盘皮肤',
      },
    },
    toolbarUploadButton: {
      name: 'toolbarUploadButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/wifi' },
        systemImageName: 'wifi',
        text: '无线传输',
      },
    },
    toolbarDeployButton: {
      name: 'toolbarDeployButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
        systemImageName: 'slider.horizontal.2.arrow.trianglehead.counterclockwise',
        text: 'Rime部署',
      },
    },
    toolbarToggleEmbeddedButton: {
      name: 'toolbarToggleEmbeddedButton',
      params: {
        action: { shortcut: '#toggleEmbeddedInputMode' },
        systemImageName: 'square.and.pencil',
        text: '内嵌开关',
      },
    },
    toolbarLeftHandButton: {
      name: 'toolbarLeftHandButton',
      params: {
        action: { shortcut: '#左手模式' },
        systemImageName: 'keyboard.onehanded.left',
        text: '左手模式',
      },
    },
    toolbarRightHandButton: {
      name: 'toolbarRightHandButton',
      params: {
        action: { shortcut: '#右手模式' },
        systemImageName: 'keyboard.onehanded.right',
        text: '右手模式',
      },
    },
    toolbarScriptingSyncButton: {
      name: 'toolbarScriptingSyncButton',
      params: {
        // action: { openURL: 'scripting://run/%E7%9A%AE%E8%82%A4ws%E5%90%8C%E6%AD%A5' },
        action: { openURL: 'scripting://' },
        systemImageName: 'macbook.and.iphone',
        text: '皮肤开发',
      },
    },
    toolbarKeyboardNumericButton: {
      name: 'toolbarKeyboardNumericButton',
      params: {
        action: { keyboardType: 'numeric', },
        systemImageName: 'numbers.rectangle',
        text: '数字键盘',
      },
    },
    toolbarKeyboardSymbolicButton: {
      name: 'toolbarKeyboardSymbolicButton',
      params: {
        action: { keyboardType: 'symbolic', },
        systemImageName: 'number',
        text: '符号键盘',
      },
    },
    toolbarKeyboardEmojiButton: {
      name: 'toolbarKeyboardEmojiButton',
      params: {
        action: { keyboardType: 'emojis', },
        systemImageName: 'face.smiling.inverse',
        text: '表情键盘',
      },
    },
  },

  keyboard: {
    height: {
      iPhone: {
        portrait: 216,  // 54 * 4
        landscape: 160,  // 40 * 4
      },
      iPad: {
        portrait: 311,  // 64 * 4 + 55
        landscape: 414,  // 86 * 4 + 70
      },
    },

    button: {
      backgroundInsets: {
        iPhone: {
          portrait: { top: 5, left: 3, bottom: 5, right: 3 },
          landscape: { top: 3, left: 3, bottom: 3, right: 3 },
        },
        ipad: {
          portrait: { top: 3, left: 3, bottom: 3, right: 3 },
          landscape: { top: 4, left: 6, bottom: 4, right: 6 },
        },
      },
    },

    // 按键定义
    qButton: {
      name: 'qButton',
      params: {
        action: { character: 'q' },
        uppercasedStateAction: { character: 'Q' },
        swipeUp: { action: { character: '1' } },
      },
    },
    wButton: {
      name: 'wButton',
      params: {
        action: { character: 'w' },
        uppercasedStateAction: { character: 'W' },
        swipeUp: { action: { character: '2' } },
      },
    },
    eButton: {
      name: 'eButton',
      params: {
        action: { character: 'e' },
        uppercasedStateAction: { character: 'E' },
        swipeUp: { action: { character: '3' } },
      },
    },
    rButton: {
      name: 'rButton',
      params: {
        action: { character: 'r' },
        uppercasedStateAction: { character: 'R' },
        swipeUp: { action: { character: '4' } },
      },
    },
    tButton: {
      name: 'tButton',
      params: {
        action: { character: 't' },
        uppercasedStateAction: { character: 'T' },
        swipeUp: { action: { character: '5' } },
      },
    },
    yButton: {
      name: 'yButton',
      params: {
        action: { character: 'y' },
        uppercasedStateAction: { character: 'Y' },
        swipeUp: { action: { character: '6' } },
      },
    },
    uButton: {
      name: 'uButton',
      params: {
        action: { character: 'u' },
        uppercasedStateAction: { character: 'U' },
        swipeUp: { action: { character: '7' } },
      },
    },
    iButton: {
      name: 'iButton',
      params: {
        action: { character: 'i' },
        uppercasedStateAction: { character: 'I' },
        swipeUp: { action: { character: '8' } },
      },
    },
    oButton: {
      name: 'oButton',
      params: {
        action: { character: 'o' },
        uppercasedStateAction: { character: 'O' },
        swipeUp: { action: { character: '9' } },
      },
    },
    pButton: {
      name: 'pButton',
      params: {
        action: { character: 'p' },
        uppercasedStateAction: { character: 'P' },
        swipeUp: { action: { character: '0' } },
      },
    },

    // 第二行字母键 (ASDF)
    aButton: {
      name: 'aButton',
      params: {
        action: { character: 'a' },
        uppercasedStateAction: { character: 'A' },
        swipeUp: { action: { character: '!' } },
        swipeDown: { action: { shortcut: '#selectText' }, text: '全' },
      },
    },
    sButton: {
      name: 'sButton',
      params: {
        action: { character: 's' },
        uppercasedStateAction: { character: 'S' },
        swipeUp: { action: { character: '^' } },
        swipeDown: { action: { character: '@' } },
      },
    },
    dButton: {
      name: 'dButton',
      params: {
        action: { character: 'd' },
        uppercasedStateAction: { character: 'D' },
        swipeUp: { action: { character: '/' } },
        swipeDown: { action: { character: '\\' } },
      },
    },
    fButton: {
      name: 'fButton',
      params: {
        action: { character: 'f' },
        uppercasedStateAction: { character: 'F' },
        swipeUp: { action: { character: ';' } },
        swipeDown: { action: { character: ':' } },
      },
    },
    gButton: {
      name: 'gButton',
      params: {
        action: { character: 'g' },
        uppercasedStateAction: { character: 'G' },
        swipeUp: { action: { character: '(' } },
        swipeDown: { action: { character: ')' } },
      },
    },
    hButton: {
      name: 'hButton',
      params: {
        action: { character: 'h' },
        uppercasedStateAction: { character: 'H' },
        swipeUp: { action: { character: '-' } },
        swipeDown: { action: { character: '_' } },
      },
    },
    jButton: {
      name: 'jButton',
      params: {
        action: { character: 'j' },
        uppercasedStateAction: { character: 'J' },
        swipeUp: { action: { character: '#' } },
        swipeDown: { action: { character: '+' } },
      },
    },
    kButton: {
      name: 'kButton',
      params: {
        action: { character: 'k' },
        uppercasedStateAction: { character: 'K' },
        swipeUp: { action: { character: '{' } },
        swipeDown: { action: { character: '}' } },
      },
    },
    lButton: {
      name: 'lButton',
      params: {
        action: { character: 'l' },
        uppercasedStateAction: { character: 'L' },
        swipeUp: { action: { character: '"' } },
        swipeDown: { action: { character: "'" } },
      },
    },

    // 第三行字母键 (ZXCV)
    zButton: {
      name: 'zButton',
      params: {
        action: { character: 'z' },
        uppercasedStateAction: { character: 'Z' },
        swipeUp: { action: { character: '`' } },
        swipeDown: { action: { shortcut: '#undo' }, text: '撤' },
      },
    },
    xButton: {
      name: 'xButton',
      params: {
        action: { character: 'x' },
        uppercasedStateAction: { character: 'X' },
        swipeUp: { action: { character: '*' } },
        swipeDown: { action: { shortcut: '#cut' }, text: '剪' },
      },
    },
    cButton: {
      name: 'cButton',
      params: {
        action: { character: 'c' },
        uppercasedStateAction: { character: 'C' },
        swipeUp: { action: { character: '%' } },
        swipeDown: { action: { shortcut: '#copy' }, text: '复' },
      },
    },
    vButton: {
      name: 'vButton',
      params: {
        action: { character: 'v' },
        uppercasedStateAction: { character: 'V' },
        swipeUp: { action: { character: '=' } },
        swipeDown: { action: { shortcut: '#paste' }, text: '贴' },
      },
    },
    bButton: {
      name: 'bButton',
      params: {
        action: { character: 'b' },
        uppercasedStateAction: { character: 'B' },
        swipeUp: { action: { character: '[' } },
        swipeDown: { action: { character: ']' } },
      },
    },
    nButton: {
      name: 'nButton',
      params: {
        action: { character: 'n' },
        uppercasedStateAction: { character: 'N' },
        swipeUp: { action: { character: '&' } },
        swipeDown: { action: { character: '~' } },
      },
    },
    mButton: {
      name: 'mButton',
      params: {
        action: { character: 'm' },
        uppercasedStateAction: { character: 'M' },
        swipeUp: { action: { character: '?' } },
        swipeDown: { action: { character: '$' } },
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

    // 数字键
    oneButton: {
      name: 'oneButton',
      params: {
        action: { character: '1' },
      },
    },
    twoButton: {
      name: 'twoButton',
      params: {
        action: { character: '2' },
      },
    },
    threeButton: {
      name: 'threeButton',
      params: {
        action: { character: '3' },
      },
    },
    fourButton: {
      name: 'fourButton',
      params: {
        action: { character: '4' },
      },
    },
    fiveButton: {
      name: 'fiveButton',
      params: {
        action: { character: '5' },
      },
    },
    sixButton: {
      name: 'sixButton',
      params: {
        action: { character: '6' },
      },
    },
    sevenButton: {
      name: 'sevenButton',
      params: {
        action: { character: '7' },
      },
    },
    eightButton: {
      name: 'eightButton',
      params: {
        action: { character: '8' },
      },
    },
    nineButton: {
      name: 'nineButton',
      params: {
        action: { character: '9' },
      },
    },
    zeroButton: {
      name: 'zeroButton',
      params: {
        action: { character: '0' },
      },
    },

    numericButtons: [
      self.oneButton, self.twoButton, self.threeButton,
      self.fourButton, self.fiveButton, self.sixButton,
      self.sevenButton, self.eightButton, self.nineButton,
      self.zeroButton,
    ],

    // 特殊功能键
    spaceButton: {
      name: 'spaceButton',
      params: {
        action: 'space',
        systemImageName: 'space',
        center: {x: 0.5, y: 0.5},
        notification: [
          'preeditChangedForSpaceButtonNotification',
        ] + (
          if settings.spaceButtonShowSchema then
            ['rimeSchemaChangedNotification']
          else []
        ),
      },
    },

    // 数字键盘空格
    numericSpaceButton: {
      name: 'numericSpaceButton',
      params: {
        action: 'space',
        systemImageName: 'space',
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
      },
      uppercasedParams: {
        systemImageName: 'shift.fill',
      },
      capsLockedParams: {
        systemImageName: 'capslock.fill',
      },
    },

    asciiModeButton: {
      name: 'asciiModeButton',
      params: {
        action: { shortcut: '#中英切换' },
        assetImageName: 'chineseState2',
        notification: [
          'asciiModeIsFalseChangedNotification',
          'asciiModeIsTrueChangedNotification',
        ],
      },
    },

    dismissButton: {
      name: 'dismissButton',
      params: {
        action: 'dismissKeyboard',
        systemImageName: 'keyboard.chevron.compact.down',
      },
    },

    enterButton: {
      name: 'enterButton',
      params: {
        action: 'enter',
        swipeDown: { action: { shortcut: '#换行' } },
        text: '$returnKeyType',
        center: {x: 0.5, y: 0.45 },
        notification: [
          'preeditChangedForEnterButtonNotification',
        ],
      },
    },

    symbolicButton: {
      name: 'symbolicButton',
      params: {
        action: { keyboardType: 'symbolic' },
        text: '#+=',
      },
    },

    numericButton: {
      name: 'numericButton',
      params: {
        action: { keyboardType: 'numeric' },
        text: '123',
        swipeUp: { action: { keyboardType: 'symbolic' } },
        swipeDown: { action: { keyboardType: 'emojis' } },
      },
    },

    pinyinButton: {
      name: 'pinyinButton',
      params: {
        action: { keyboardType: 'pinyin' },
        text: '拼音',
      },
    },

    otherKeyboardButton: {
      name: 'otherKeyboardButton',
      params: {
        action: 'nextKeyboard',
        systemImageName: 'globe',
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

    // 标点符号键

    // 连接号(减号)
    hyphenButton: {
      name: 'hyphenButton',
      params: {
        action: { character: '-' },
        swipeUp: { action: { character: '——' } },
      },
    },
    // 斜杠
    forwardSlashButton: {
      name: 'forwardSlashButton',
      params: {
        action: { character: '/' },
        swipeUp: { action: { character: '?' } },
      },
    },
    // 冒号
    colonButton: {
      name: 'colonButton',
      params: {
        action: { character: ':' },
      },
    },
    // 数字键盘冒号
    numericColonButton: {
      name: 'numericColonButton',
      params: {
        action: { symbol: ':' },
      },
    },

    // 中文冒号
    chineseColonButton: {
      name: 'chineseColonButton',
      params: {
        action: { symbol: '：' },
      },
    },

    // 分号
    semicolonButton: {
      name: 'semicolonButton',
      params: {
        action: { symbol: ';' },
      },
    },

    // 中文分号
    chineseSemicolonButton: {
      name: 'chineseSemicolonButton',
      params: {
        action: { symbol: '；' },
        swipeUp: { action: { symbol: '：' } },
      },
    },

    // 左括号
    leftParenthesisButton: {
      name: 'leftParenthesisButton',
      params: {
        action: { symbol: '(' },
      },
    },

    // 右括号
    rightParenthesisButton: {
      name: 'rightParenthesisButton',
      params: {
        action: { symbol: ')' },
      },
    },

    // 中文左括号
    leftChineseParenthesisButton: {
      name: 'leftChineseParenthesisButton',
      params: {
        action: { symbol: '（' },
      },
    },

    // 中文右括号
    rightChineseParenthesisButton: {
      name: 'rightChineseParenthesisButton',
      params: {
        action: { symbol: '）' },
      },
    },

    // 美元符号
    dollarButton: {
      name: 'dollarButton',
      params: {
        action: { symbol: '$' },
      },
    },

    // 地址符号
    atButton: {
      name: 'atButton',
      params: {
        action: { symbol: '@' },
      },
    },

    // “ 双引号(有方向性的引号)
    leftCurlyQuoteButton: {
      name: 'leftCurlyQuoteButton',
      params: {
        action: { symbol: '“' },
      },
    },
    // ” 双引号(有方向性的引号)
    rightCurlyQuoteButton: {
      name: 'rightCurlyQuoteButton',
      params: {
        action: { symbol: '”' },
      },
    },
    // " 直引号(没有方向性的引号)
    straightQuoteButton: {
      name: 'straightQuoteButton',
      params: {
        action: { symbol: '"' },
      },
    },
    chineseCommaButton: {
      name: 'chineseCommaButton',
      params: {
        action: { symbol: '，' },
        swipeUp: { action: { symbol: '。' } },
      },
    },
    commaButton: {
      name: 'commaButton',
      params: {
        action: { character: ',' },
        swipeUp: { action: { character: '.' }, text: '' },
        center: {x: 0.5, y: 0.5},
      },
    },
    chinesePeriodButton: {
      name: 'chinesePeriodButton',
      params: {
        action: { symbol: '。' },
        swipeUp: { action: { symbol: '》' } },
      },
    },
    periodButton: {
      name: 'periodButton',
      params: {
        action: { character: '.' },
        swipeUp: { action: { character: ',' } },
      },
    },

    // 顿号(只在中文中使用)
    ideographicCommaButton: {
      name: 'ideographicCommaButton',
      params: {
        action: { symbol: '、' },
        swipeUp: { action: { symbol: '|' } },
      },
    },
    // 中文问号
    chineseQuestionMarkButton: {
      name: 'questionMarkButton',
      params: {
        action: { symbol: '？' },
      },
    },
    // 英文问号
    questionMarkButton: {
      name: 'questionMarkEnButton',
      params: {
        action: { symbol: '?' },
      },
    },
    // 中文感叹号
    chineseExclamationMarkButton: {
      name: 'chineseExclamationMarkButton',
      params: {
        action: { symbol: '！' },
      },
    },
    // 英文感叹号
    exclamationMarkButton: {
      name: 'exclamationMarkButton',
      params: {
        action: { symbol: '!' },
      },
    },
    // ' 直撇号(单引号)
    apostropheButton: {
      name: 'apostropheButton',
      params: {
        action: { symbol: "'" },
      },
    },
    // 中文左单引号(有方向性的单引号)
    leftSingleQuoteButton: {
      name: 'leftSingleQuoteButton',
      params: {
        action: { symbol: '‘' },
        swipeUp: { action: { symbol: '“' } },
      },
    },
    // 中文右单引号(有方向性的单引号)
    rightSingleQuoteButton: {
      name: 'rightSingleQuoteButton',
      params: {
        action: { symbol: '’' },
      },
    },
    // 等号
    equalButton: {
      name: 'equalButton',
      params: {
        action: { character: '=' },
        swipeUp: { action: { character: '+' } },
      },
    },
    numericEqualButton: {
      name: 'numericEqualButton',
      params: {
        action: { symbol: '=' },
      },
    },
    leftBracketButton: {
      name: 'leftBracketButton',
      params: {
        action: { symbol: '[' },
      },
    },
    rightBracketButton: {
      name: 'rightBracketButton',
      params: {
        action: { symbol: ']' },
      },
    },

    // 中文左中括号
    leftChineseBracketButton: {
      name: 'leftChineseBracketButton',
      params: {
        action: { symbol: '【' },
        swipeUp: { action: { symbol: '「' } },
      },
    },

    // 中文右中括号
    rightChineseBracketButton: {
      name: 'rightChineseBracketButton',
      params: {
        action: { symbol: '】' },
        swipeUp: { action: { symbol: '」' } },
      },
    },

    // 英文左大括号
    leftBraceButton: {
      name: 'leftBraceButton',
      params: {
        action: { symbol: '{' },
      },
    },

    // 英文右大括号
    rightBraceButton: {
      name: 'rightBraceButton',
      params: {
        action: { symbol: '}' },
      },
    },

    // 中文左大括号
    leftChineseBraceButton: {
      name: 'leftChineseBraceButton',
      params: {
        action: { symbol: '｛' },
      },
    },

    // 中文右大括号
    rightChineseBraceButton: {
      name: 'rightChineseBraceButton',
      params: {
        action: { symbol: '｝' },
      },
    },


    // 井号
    hashButton: {
      name: 'hashButton',
      params: {
        action: { symbol: '#' },
      },
    },

    // 百分号
    percentButton: {
      name: 'percentButton',
      params: {
        action: { symbol: '%' },
      },
    },

    // ^符号
    caretButton: {
      name: 'caretButton',
      params: {
        action: { symbol: '^' },
      },
    },

    // '*' 符号
    asteriskButton: {
      name: 'asteriskButton',
      params: {
        action: { character: '*' },
      },
    },

    // + 符号
    plusButton: {
      name: 'plusButton',
      params: {
        action: { character: '+' },
      },
    },

    // _ 符号(下划线)
    underscoreButton: {
      name: 'underscoreButton',
      params: {
        action: { symbol: '_' },
      },
    },

    // —— 符号(破折号)
    emDashButton: {
      name: 'emDashButton',
      params: {
        action: { character: '—' },
      },
    },

    // \ 符号(反斜杠)
    backslashButton: {
      name: 'backslashButton',
      params: {
        action: { symbol: '\\' },
      },
    },

    // | 符号(竖线)
    verticalBarButton: {
      name: 'verticalBarButton',
      params: {
        action: { symbol: '|' },
      },
    },

    // ~ 符号
    tildeButton: {
      name: 'tildeButton',
      params: {
        action: { symbol: '~' },
      },
    },

    // < 符号(小于号)
    lessThanButton: {
      name: 'lessThanButton',
      params: {
        action: { symbol: '<' },
      },
    },

    // > 符号(大于号)
    greaterThanButton: {
      name: 'greaterThanButton',
      params: {
        action: { symbol: '>' },
      },
    },

    // 中文左书名号
    leftBookTitleMarkButton: {
      name: 'leftBookTitleMarkButton',
      params: {
        action: { symbol: '《' },
      },
    },

    // 中文右书名号
    rightBookTitleMarkButton: {
      name: 'rightBookTitleMarkButton',
      params: {
        action: { symbol: '》' },
      },
    },

    // € 符号(欧元符号)
    euroButton: {
      name: 'euroButton',
      params: {
        action: { symbol: '€' },
      },
    },

    // £ 符号(英镑符号)
    poundButton: {
      name: 'poundButton',
      params: {
        action: { symbol: '£' },
      },
    },

    // 人民币符号
    rmbButton: {
      name: 'rmbButton',
      params: {
        action: { symbol: '¥' },
      },
    },

    // & 符号(和号)
    ampersandButton: {
      name: 'ampersandButton',
      params: {
        action: { symbol: '&' },
      },
    },

    // . 小数点符号
    dotButton: {
      name: 'dotButton',
      params: {
        action: { symbol: '.' },
      },
    },

    // · 中点符号
    middleDotButton: {
      name: 'middleDotButton',
      params: {
        action: { symbol: '·' },
      },
    },

    // …… 符号(省略号)
    ellipsisButton: {
      name: 'ellipsisButton',
      params: {
        action: { symbol: '…' },
      },
    },

    // ` 符号(重音符)
    graveButton: {
      name: 'graveButton',
      params: {
        action: { character: '`' },
        swipeUp: { action: { character: '~' } },
      },
    },

    // ± 符号(正负号)
    plusMinusButton: {
      name: 'plusMinusButton',
      params: {
        action: { symbol: '±' },
      },
    },

    // 「 中文左引号
    leftChineseAngleQuoteButton: {
      name: 'leftChineseAngleQuoteButton',
      params: {
        action: { symbol: '「' },
      },
    },

    // 」 中文右引号
    rightChineseAngleQuoteButton: {
      name: 'rightChineseAngleQuoteButton',
      params: {
        action: { symbol: '」' },
      },
    },

    // 数字键盘符号列表
    numericSymbolsCollection: {
      name: 'numericSymbolsCollection',
      params: {
        type: 'numericSymbols',
      },
    },

    // 数字键盘横向时全部部分视图
    numericCategorySymbolCollection: {
      name: 'numericCategorySymbolCollection',
      params: {
        type: 'categorySymbols',
      },
    },
  },
}
