local colors = import '../Constants/Colors.libsonnet';
local keyboardParams = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';


local newCandidateStyle(param={}, isDark=false) =
  utils.extractProperties(
    param,
    [
      'insets',
      'indexFontSize',
      'indexFontWeight',
      'textFontSize',
      'textFontWeight',
      'commentFontSize',
      'commentFontWeight',
    ]
  )
  + utils.extractColors(
    param,
    [
      'backgroundColor',
      'separatorColor',
      'highlightBackgroundColor',
      'preferredBackgroundColor',
      'preferredIndexColor',
      'preferredTextColor',
      'preferredCommentColor',
      'indexColor',
      'textColor',
      'commentColor',
    ],
    isDark
  );

local toolbarBackgroundStyleName = basicStyle.keyboardBackgroundStyleName;
local horizontalCandidateBackgroundStyleName = basicStyle.keyboardBackgroundStyleName;
local verticalCandidateBackgroundStyleName = basicStyle.keyboardBackgroundStyleName;

// MARK: - 横排候选字

local horizontalCandidatesCollectionViewName = 'horizontalCandidates';
local expandButtonName = 'expandButton';
local horizontalCandidatesLayout = [
  {
    HStack: {
      subviews: [
        {
          Cell: horizontalCandidatesCollectionViewName,
        },
        {
          Cell: expandButtonName,
        },
      ],
    },
  },
];

local newHorizontalCandidatesCollectionView(isDark=false) = {
  [horizontalCandidatesCollectionViewName]: {
    type: 'horizontalCandidates',
    candidateStyle: 'horizontalCandidateStyle',
  },
  horizontalCandidateStyle: newCandidateStyle(keyboardParams.candidateStyle, isDark),
};

local newExpandButton(isDark) = {
  [expandButtonName]:
    {
      size: { width: 44 },
      action: { shortcut: '#candidatesBarStateToggle' },
    }
    + utils.newForegroundStyle(style=expandButtonName + 'ForegroundStyle'),
  [expandButtonName + 'ForegroundStyle']:
    utils.newSystemImageStyle(keyboardParams.horizontalCandidateStyle.expandButton, isDark),
};


// MARK: - 纵排候选字

local verticalCandidateCollectionViewName = 'verticalCandidates';
local verticalLastRowStyleName = 'verticalLastRowStyle';
local verticalCandidatePageUpButtonStyleName = 'verticalPageUpButtonStyle';
local verticalCandidatePageDownButtonStyleName = 'verticalPageDownButtonStyle';
local verticalCandidateReturnButtonStyleName = 'verticalReturnButtonStyle';
local verticalCandidateBackspaceButtonStyleName = 'verticalBackspaceButtonStyle';

local verticalCandidatesLayout = [
  {
    HStack: {
      subviews: [
        {
          Cell: verticalCandidateCollectionViewName,
        },
      ],
    },
  },
  {
    HStack: {
      style: verticalLastRowStyleName,
      subviews: [
        {
          Cell: verticalCandidatePageUpButtonStyleName,
        },
        {
          Cell: verticalCandidatePageDownButtonStyleName,
        },
        {
          Cell: verticalCandidateReturnButtonStyleName,
        },
        {
          Cell: verticalCandidateBackspaceButtonStyleName,
        },
      ],
    },
  },
];


local newVerticalCandidateCollectionStyle(isDark) = {
  [verticalCandidateCollectionViewName]:
    {
      type: 'verticalCandidates',
      insets: keyboardParams.verticalCandidateStyle.candidateCollectionStyle.insets,
      maxRows: keyboardParams.verticalCandidateStyle.candidateCollectionStyle.maxRows,
      maxColumns: keyboardParams.verticalCandidateStyle.candidateCollectionStyle.maxColumns,
      candidateStyle: 'verticalCandidateStyle',
    } +
    utils.extractColors(
      keyboardParams.verticalCandidateStyle.candidateCollectionStyle,
      [
        'separatorColor',
      ],
      isDark
    ),
  verticalCandidateStyle: newCandidateStyle(keyboardParams.candidateStyle { insets: { left: 6, right: 6, top: 4, bottom: 4 } }, isDark),
};

local verticalLastRowStyle = {
  [verticalLastRowStyleName]:
    {
      size: { height: keyboardParams.verticalCandidateStyle.bottomRowHeight },
    },
};

local newVerticalCandidatePageUpButtonStyle(isDark) = {
  [verticalCandidatePageUpButtonStyleName]:
    utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
    + utils.newForegroundStyle(style=verticalCandidatePageUpButtonStyleName + 'ForegroundStyle')
    + {
      action: keyboardParams.verticalCandidateStyle.pageUpButton.action,
    },
  [verticalCandidatePageUpButtonStyleName + 'ForegroundStyle']:
    utils.newSystemImageStyle(keyboardParams.verticalCandidateStyle.pageUpButton, isDark),
};

local newVerticalCandidatePageDownButtonStyle(isDark) = {
  [verticalCandidatePageDownButtonStyleName]:
    utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
    + utils.newForegroundStyle(style=verticalCandidatePageDownButtonStyleName + 'ForegroundStyle')
    + {
      action: keyboardParams.verticalCandidateStyle.pageDownButton.action,
    },
  [verticalCandidatePageDownButtonStyleName + 'ForegroundStyle']:
    utils.newSystemImageStyle(keyboardParams.verticalCandidateStyle.pageDownButton, isDark),
};


local newVerticalCandidateReturnButtonStyle(isDark) = {
  [verticalCandidateReturnButtonStyleName]:
    utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
    + utils.newForegroundStyle(style=verticalCandidateReturnButtonStyleName + 'ForegroundStyle')
    + {
      action: keyboardParams.verticalCandidateStyle.returnButton.action,
    },
  [verticalCandidateReturnButtonStyleName + 'ForegroundStyle']:
    utils.newSystemImageStyle(keyboardParams.verticalCandidateStyle.returnButton, isDark),
};

local newVerticalCandidateBackspaceButtonStyle(isDark) = {
  [verticalCandidateBackspaceButtonStyleName]:
    utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
    + utils.newForegroundStyle(style=verticalCandidateBackspaceButtonStyleName + 'ForegroundStyle')
    + {
      action: 'backspace',
    },
  [verticalCandidateBackspaceButtonStyleName + 'ForegroundStyle']:
    utils.newSystemImageStyle(
      {
        systemImageName: 'delete.left',
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: keyboardParams.verticalCandidateStyle.pageUpButton.fontSize,
      },
      isDark
    ),
};


local toolbarKeyboard = {
  toolbarMenuButton: {
    name: 'toolbarMenuButton',
    params: {
      action: { floatKeyboardType: 'panel', },
      systemImageName: 'hexagon.righthalf.filled',
    },
  },
  toolbarDismissButton: {
    name: 'toolbarDismissButton',
    params: {
      action: 'dismissKeyboard',
      systemImageName: 'chevron.down',
    },
  },
  toolbarPerformanceButton: {
    name: 'toolbarPerformanceButton',
    params: {
      action: { shortcut: '#keyboardPerformance' },
      systemImageName: 'speedometer',
    },
  },
  toolbarPhraseButton: {
    name: 'toolbarPhraseButton',
    params: {
      action: { shortcut: '#showPhraseView' },
      systemImageName: 'heart',
    },
  },
  toolbarScriptButton: {
    name: 'toolbarScriptButton',
    params: {
      action: { shortcut: '#toggleScriptView' },
      systemImageName: 'apple.terminal',
    },
  },
  toolbarClipboardButton: {
    name: 'toolbarClipboardButton',
    params: {
      action: { shortcut: '#showPasteboardView' },
      systemImageName: 'clipboard',
    },
  },
  toolbarRimeSwitcherButton: {
    name: 'toolbarRimeSwitcherButton',
    params: {
      action: { shortcut: '#方案切换' },
      systemImageName: 'switch.2',
    },
  },
};

local toolbarKeyboardLayout = [
  {
    HStack: {
      subviews: [
        {
          Cell: toolbarKeyboard.toolbarMenuButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarPerformanceButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarRimeSwitcherButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarScriptButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarPhraseButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarClipboardButton.name,
        },
        {
          Cell: toolbarKeyboard.toolbarDismissButton.name,
        },
      ],
    },
  },
];

local newButtons(isDark=false) =
  basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarMenuButton.name,
    isDark,
    toolbarKeyboard.toolbarMenuButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarPerformanceButton.name,
    isDark,
    toolbarKeyboard.toolbarPerformanceButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarRimeSwitcherButton.name,
    isDark,
    toolbarKeyboard.toolbarRimeSwitcherButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarScriptButton.name,
    isDark,
    toolbarKeyboard.toolbarScriptButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarPhraseButton.name,
    isDark,
    toolbarKeyboard.toolbarPhraseButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarClipboardButton.name,
    isDark,
    toolbarKeyboard.toolbarClipboardButton.params,
  )
  + basicStyle.newToolbarButton(
    toolbarKeyboard.toolbarDismissButton.name,
    isDark,
    toolbarKeyboard.toolbarDismissButton.params,
  );


local newToolbar(isDark=false, params={}) =
  {
    toolbarHeight: keyboardParams.toolbar.height,
    toolbarStyle: {
             insets: keyboardParams.toolbar.insets,
           }
           + utils.newBackgroundStyle(style=toolbarBackgroundStyleName),
    toolbarLayout: toolbarKeyboardLayout,
    horizontalCandidatesStyle:
      utils.extractProperties(keyboardParams.horizontalCandidateStyle + params, ['insets'])
      {
        backgroundStyle: horizontalCandidateBackgroundStyleName,
      },
    horizontalCandidatesLayout: horizontalCandidatesLayout,
    verticalCandidatesStyle:
      utils.extractProperties(keyboardParams.verticalCandidateStyle + params, ['insets'])
      {
        backgroundStyle: verticalCandidateBackgroundStyleName,
      },
    verticalCandidatesLayout: verticalCandidatesLayout,
    candidateContextMenu: [
      {
        name: '复制',
        action: '#copy',
      },
    ],
  }
  + newButtons(isDark)
  + newHorizontalCandidatesCollectionView(isDark)
  + newExpandButton(isDark)
  + newVerticalCandidateCollectionStyle(isDark)
  + verticalLastRowStyle
  + newVerticalCandidatePageUpButtonStyle(isDark)
  + newVerticalCandidatePageDownButtonStyle(isDark)
  + newVerticalCandidateReturnButtonStyle(isDark)
  + newVerticalCandidateBackspaceButtonStyle(isDark);

// 导出
{
  new: newToolbar,
}
