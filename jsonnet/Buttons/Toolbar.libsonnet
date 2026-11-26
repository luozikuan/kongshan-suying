# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含 toolbar 和浮动键盘中的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

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
      backgroundInsets: if !settings.iPad then
        {
          portrait: { top: 6, left: 3, bottom: 6, right: 3 },
          landscape: { top: 3, left: 3, bottom: 3, right: 3 },
        }
        else
        {
          portrait: { top: 3, left: 3, bottom: 3, right: 3 },
          landscape: { top: 4, left: 6, bottom: 4, right: 6 },
        },
    },
  },

  // toolbar 或浮动键盘按键定义，按键名需要注意不要和 keyboard 下的按键名冲突，所以加 tb 前缀
  toolbarButton: {
    toolbarMenuButton: {
      name: 'toolbarMenuButton',
      params: {
        action: { floatKeyboardType: 'panel', },
        systemImageName: { ios: 'hexagon.righthalf.filled', android: 'hexagon'},
        // systemImageName: 'swirl.circle.righthalf.filled', // 需要 iOS 17+
        text: '面板',
      },
    },
    toolbarDismissButton: {
      name: 'toolbarDismissButton',
      params: {
        action: 'dismissKeyboard',
        systemImageName: { ios: 'chevron.down', android: 'keyboard_arrow_down'},
        text: '关闭',
      },
    },

    toolbarPerformanceButton: {
      name: 'toolbarPerformanceButton',
      params: {
        action: { shortcut: '#keyboardPerformance' },
        systemImageName: { ios: 'speedometer', android: 'swap_driving_apps_wheel'},
        text: '性能',
      },
    },
    toolbarPhraseButton: {
      name: 'toolbarPhraseButton',
      params: {
        action: { shortcut: '#showPhraseView' },
        systemImageName: { ios: 'heart', android: 'favorite'},
        text: '短语',
      },
    },
    toolbarCommandButton: {
      name: 'toolbarCommandButton',
      params: {
        action: { shortcut: "#toggleCommandView" },
        systemImageName: { ios: 'command', android: 'keyboard_command_key'},
        text: '命令',
      },
    },
    toolbarScriptButton: {
      name: 'toolbarScriptButton',
      params: {
        action: { shortcut: '#toggleScriptView' },
        systemImageName: { ios: 'terminal', android: 'terminal'},
        text: '脚本',
      },
    },
    toolbarClipboardButton: {
      name: 'toolbarClipboardButton',
      params: {
        action: { shortcut: '#showPasteboardView' },
        systemImageName: { ios: 'clipboard', android: 'content_paste_search'},
        text: '剪贴',
      },
    },
    toolbarRimeSwitcherButton: {
      name: 'toolbarRimeSwitcherButton',
      params: {
        action: { shortcut: '#RimeSwitcher' },
        systemImageName: { ios: 'switch.2', android: 'toggle_on'},
        text: '开关',
      },
    },
    toolbarSchemaSelectorButton: {
      name: 'toolbarSchemaSelectorButton',
      params: {
        action: { shortcut: '#方案切换' },
        systemImageName: { ios: 'list.bullet.rectangle', android: 'list_alt'},
        text: '切换',
      },
    },

    toolbarHamster3Button: {
      name: 'toolbarHamster3Button',
      params: {
        action: 'settings',
        systemImageName: { ios: 'atom', android: 'orbit'},
        text: '元书',
      },
    },
    toolbarCheckUpdateButton: {
      name: 'toolbarCheckUpdateButton',
      params: {
        action: { openURL: 'https://ihsiao.com/apps/hamster/v3/docs/logs/' },
        systemImageName: { ios: 'arrow.down.circle', android: 'arrow_circle_down'},
        text: '更新',
      },
    },
    toolbarFeedbackButton: {
      name: 'toolbarFeedbackButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/feedback' },
        systemImageName: { ios: 'iphone.radiowaves.left.and.right', android: 'mobile_vibrate'},
        text: '震动',
      },
    },
    toolbarFinderButton: {
      name: 'toolbarFinderButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
        systemImageName: { ios: 'folder', android: 'folder'},
        text: '文件',
      },
    },
    toolbarSkinPreference: {
      name: 'toolbarSkinPreference',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Settings.libsonnet' },
        systemImageName: { ios: 'wrench.and.screwdriver', android: 'handyman'},
        text: '微调',
      },
    },
    toolbarKeyboardDefinition: {
      name: 'toolbarKeyboardDefinition',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Buttons/README.md' },
        systemImageName: { ios: 'keyboard.badge.ellipsis', android: 'keyboard_external_input'},
        text: '按键',
      },
    },
    toolbarSkinButton: {
      name: 'toolbarSkinButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
        systemImageName: { ios: 'tshirt', android: 'apparel'},
        text: '皮肤',
      },
    },
    toolbarUploadButton: {
      name: 'toolbarUploadButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/wifi' },
        systemImageName: { ios: 'wifi', android: 'wifi'},
        text: '传输',
      },
    },
    toolbarRimeDeployButton: {
      name: 'toolbarRimeDeployButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
        systemImageName: { ios: 'slider.horizontal.2.arrow.trianglehead.counterclockwise', android: 'reset_wrench'},
        text: '部署',
      },
    },
    toolbarRimeInputSchemaButton: {
      name: 'toolbarRimeInputSchemaButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/inputSchema' },
        systemImageName: { ios: 'list.bullet.rectangle.portrait', android: 'list_alt'},
        text: '方案',
      },
    },
    toolbarRimeSyncButton: {
      name: 'toolbarRimeSyncButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=sync' },
        systemImageName: { ios: 'checkmark.icloud', android: 'cloud_done'},
        text: '同步',
      },
    },
    toolbarToggleEmbeddedButton: {
      name: 'toolbarToggleEmbeddedButton',
      params: {
        action: { shortcut: '#toggleEmbeddedInputMode' },
        systemImageName: { ios: 'square.and.pencil', android: 'edit_square'},
        text: '内嵌',
      },
    },
    toolbarLeftHandButton: {
      name: 'toolbarLeftHandButton',
      params: {
        action: { shortcut: '#左手模式' },
        systemImageName: { ios: 'keyboard.onehanded.left', android: 'mobile_hand_left'},
        text: '左手',
      },
    },
    toolbarRightHandButton: {
      name: 'toolbarRightHandButton',
      params: {
        action: { shortcut: '#右手模式' },
        systemImageName: { ios: 'keyboard.onehanded.right', android: 'mobile_hand'},
        text: '右手',
      },
    },
    toolbarKeyboardNumericButton: {
      name: 'toolbarKeyboardNumericButton',
      params: {
        action: { keyboardType: 'numeric', },
        systemImageName: { ios: 'textformat.123', android: '123'},
        text: '数字',

        OnNumeric: {
          action: 'returnPrimaryKeyboard',
          systemImageName: { ios: 'arrow.backward', android: 'arrow_back'},
          text: '返回',
        },

        OnAlphabetic: {
          [if settings.numericLayout == 'row' then 'action']: { keyboardType: 'numericRowEn' },
        }
      },
    },
    toolbarKeyboardSymbolicButton: {
      name: 'toolbarKeyboardSymbolicButton',
      params: {
        action: { keyboardType: 'symbolic', },
        systemImageName: { ios: 'number', android: 'numbers'},
        text: '符号',

        OnSymbolic: {
          action: 'returnPrimaryKeyboard',
          systemImageName: { ios: 'arrow.backward', android: 'arrow_back'},
          text: '返回',
        },
        OnAlphabetic: {
          [if settings.symbolicLayout == 'row' then 'action']: { keyboardType: 'symbolicRowEn' },
        },
      },
    },
    toolbarKeyboardEmojiButton: {
      name: 'toolbarKeyboardEmojiButton',
      params: {
        action: { keyboardType: 'emojis', },
        // systemImageName: 'face.smiling.inverse', // ios 这个表情经常会异常反色
        systemImageName: { ios: 'face.dashed', android: 'sentiment_excited'},
        text: '表情',

        OnEmojis: {
          action: 'returnPrimaryKeyboard',
          systemImageName: { ios: 'arrow.backward', android: 'arrow_back'},
          text: '返回',
        }
      },
    },
    toolbarSelectAllTextButton: {
      name: 'toolbarSelectAllTextButton',
      params: {
        action: { shortcut: '#selectText' },
        systemImageName: { ios: 'selection.pin.in.out', android: 'select_all'},
        text: '全选',
      },
    },
    toolbarCopyTextButton: {
      name: 'toolbarCopyTextButton',
      params: {
        action: { shortcut: '#copy' },
        systemImageName: { ios: 'doc.on.doc', android: 'content_copy'},
        text: '复制',
      },
    },
    toolbarCutTextButton: {
      name: 'toolbarCutTextButton',
      params: {
        action: { shortcut: '#cut' },
        systemImageName: { ios: 'scissors', android: 'content_cut'},
        text: '剪切',
      },
    },
    toolbarPasteTextButton: {
      name: 'toolbarPasteTextButton',
      params: {
        action: { shortcut: '#paste' },
        systemImageName: { ios: 'doc.on.clipboard', android: 'content_paste'},
        text: '粘贴',
      },
    },
    toolbarUndoButton: {
      name: 'toolbarUndoButton',
      params: {
        action: { shortcut: '#undo' },
        systemImageName: { ios: 'arrow.uturn.left', android: 'undo'},
        text: '撤销',
      },
    },
    toolbarRedoButton: {
      name: 'toolbarRedoButton',
      params: {
        action: { shortcut: '#redo' },
        systemImageName: { ios: 'arrow.uturn.right', android: 'redo'},
        text: '重做',
      },
    },
    toolbarMoveCursorLeftButton: {
      name: 'toolbarMoveCursorLeftButton',
      params: {
        action: 'moveCursorBackward',
        repeatAction: 'moveCursorBackward',
        systemImageName: { ios: 'arrowshape.left', android: 'text_select_move_back_character'},
        text: '左移',
      },
    },
    toolbarMoveCursorRightButton: {
      name: 'toolbarMoveCursorRightButton',
      params: {
        action: 'moveCursorForward',
        repeatAction: 'moveCursorForward',
        systemImageName: { ios: 'arrowshape.right', android: 'text_select_move_forward_character'},
        text: '右移',
      },
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
        systemImageName: { ios: 'chevron.forward', android: 'chevron_forward'},
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
        systemImageName: { ios: 'chevron.up', android: 'keyboard_arrow_up'},
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
      pageDownButton: {
        action: { shortcut: '#verticalCandidatesPageDown' },
        systemImageName: { ios: 'chevron.down', android: 'keyboard_arrow_down'},
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
      returnButton: {
        action: { shortcut: '#candidatesBarStateToggle' },
        systemImageName: { ios: 'arrow.backward', android: 'arrow_back'},
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
    },
}
