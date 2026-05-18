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
        systemImageName: 'hexagon.righthalf.filled',
        // systemImageName: 'swirl.circle.righthalf.filled', // 需要 iOS 17+
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
        systemImageName: 'terminal',
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
        text: '开关',
      },
    },
    toolbarSchemaSelectorButton: {
      name: 'toolbarSchemaSelectorButton',
      params: {
        action: { shortcut: '#方案切换' },
        systemImageName: 'list.bullet.rectangle',
        text: '切换',
      },
    },

    toolbarHamster3Button: {
      name: 'toolbarHamster3Button',
      params: {
        action: 'settings',
        systemImageName: 'atom',
        text: '元书',
      },
    },
    toolbarCheckUpdateButton: {
      name: 'toolbarCheckUpdateButton',
      params: {
        action: { openURL: 'https://apps.apple.com/cn/app/%E5%85%83%E4%B9%A6%E8%BE%93%E5%85%A5%E6%B3%95/id6744464701' },
        systemImageName: 'arrow.down.circle',
        text: '更新',
      },
    },
    toolbarFeedbackButton: {
      name: 'toolbarFeedbackButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/feedback' },
        systemImageName: 'iphone.radiowaves.left.and.right',
        text: '震动',
      },
    },
    toolbarFinderButton: {
      name: 'toolbarFinderButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
        systemImageName: 'folder',
        text: '文件',
      },
    },
    toolbarSkinPreference: {
      name: 'toolbarSkinPreference',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Settings.libsonnet' },
        systemImageName: 'wrench.and.screwdriver',
        text: '微调',
      },
    },
    toolbarKeyboardDefinition: {
      name: 'toolbarKeyboardDefinition',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Buttons/README.md' },
        systemImageName: 'keyboard.badge.ellipsis',
        text: '按键',
      },
    },
    toolbarSkinButton: {
      name: 'toolbarSkinButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
        systemImageName: 'tshirt',
        text: '皮肤',
      },
    },
    toolbarUploadButton: {
      name: 'toolbarUploadButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/wifi' },
        systemImageName: 'wifi',
        text: '传输',
      },
    },
    toolbarRimeDeployButton: {
      name: 'toolbarRimeDeployButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
        systemImageName: 'slider.horizontal.2.arrow.trianglehead.counterclockwise',
        text: '部署',
      },
    },
    toolbarRimeInputSchemaButton: {
      name: 'toolbarRimeInputSchemaButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/inputSchema' },
        systemImageName: 'list.bullet.rectangle.portrait',
        text: '方案',
      },
    },
    toolbarRimeQuickButton: {
      name: 'toolbarRimeQuickButton',
      params: {
        action: settings.quickAction,
        systemImageName: 'figure.roll.runningpace',
        text: '快符',
      },
    },
    toolbarRimeSyncButton: {
      name: 'toolbarRimeSyncButton',
      params: {
        action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=sync' },
        systemImageName: 'checkmark.icloud',
        text: '同步',
      },
    },
    toolbarToggleEmbeddedButton: {
      name: 'toolbarToggleEmbeddedButton',
      params: {
        action: { shortcut: '#toggleEmbeddedInputMode' },
        systemImageName: 'square.and.pencil',
        text: '内嵌',
      },
    },
    toolbarLeftHandButton: {
      name: 'toolbarLeftHandButton',
      params: {
        action: { shortcut: '#左手模式' },
        systemImageName: 'keyboard.onehanded.left',
        text: '左手',
      },
    },
    toolbarRightHandButton: {
      name: 'toolbarRightHandButton',
      params: {
        action: { shortcut: '#右手模式' },
        systemImageName: 'keyboard.onehanded.right',
        text: '右手',
      },
    },
    toolbarKeyboardNumericButton: {
      name: 'toolbarKeyboardNumericButton',
      params: {
        action: { keyboardType: 'numeric', },
        systemImageName: 'textformat.123',
        text: '数字',

        OnNumeric: {
          action: 'returnPrimaryKeyboard',
          systemImageName: 'arrow.backward',
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
        systemImageName: 'number',
        text: '符号',

        OnSymbolic: {
          action: 'returnPrimaryKeyboard',
          systemImageName: 'arrow.backward',
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
		// systemImageName: 'face.smiling.inverse', // 这个表情经常会异常反色
        systemImageName: 'face.dashed',
        text: '表情',

        OnEmojis: {
          action: 'returnPrimaryKeyboard',
          systemImageName: 'arrow.backward',
          text: '返回',
        }
      },
    },
    toolbarSelectAllTextButton: {
      name: 'toolbarSelectAllTextButton',
      params: {
        action: { shortcut: '#selectText' },
        systemImageName: 'selection.pin.in.out',
        text: '全选',
      },
    },
    toolbarCopyTextButton: {
      name: 'toolbarCopyTextButton',
      params: {
        action: { shortcut: '#copy' },
        systemImageName: 'doc.on.doc',
        text: '复制',
      },
    },
    toolbarCutTextButton: {
      name: 'toolbarCutTextButton',
      params: {
        action: { shortcut: '#cut' },
        systemImageName: 'scissors',
        text: '剪切',
      },
    },
    toolbarPasteTextButton: {
      name: 'toolbarPasteTextButton',
      params: {
        action: { shortcut: '#paste' },
        systemImageName: 'doc.on.clipboard',
        text: '粘贴',
      },
    },
    toolbarUndoButton: {
      name: 'toolbarUndoButton',
      params: {
        action: { shortcut: '#undo' },
        systemImageName: 'arrow.uturn.left',
        text: '撤销',
      },
    },
    toolbarRedoButton: {
      name: 'toolbarRedoButton',
      params: {
        action: { shortcut: '#redo' },
        systemImageName: 'arrow.uturn.right',
        text: '重做',
      },
    },
    toolbarMoveCursorLeftButton: {
      name: 'toolbarMoveCursorLeftButton',
      params: {
        action: 'moveCursorBackward',
        repeatAction: 'moveCursorBackward',
        systemImageName: 'arrowshape.left',
        text: '左移',
      },
    },
    toolbarMoveCursorRightButton: {
      name: 'toolbarMoveCursorRightButton',
      params: {
        action: 'moveCursorForward',
        repeatAction: 'moveCursorForward',
        systemImageName: 'arrowshape.right',
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
        systemImageName: 'arrow.backward',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.candidateStateButtonFontSize,
      },
    },
}
