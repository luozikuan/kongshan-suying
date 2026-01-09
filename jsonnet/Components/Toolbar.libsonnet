local colors = import '../Constants/Colors.libsonnet';
local keyboardParams = import '../Constants/Keyboard.libsonnet';
local settings = import '../Settings.libsonnet';
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

local slideButtons =
  local buttons = keyboardParams.toolbarButton;
  local names=
  [
    // NOTE: 工具栏按钮列表，顺序与 settings.toolbarButtons 中的描述对应
    buttons.toolbarPerformanceButton.name, // 查看性能
    buttons.toolbarRimeSwitcherButton.name, // RimeSwitcher
    buttons.toolbarScriptButton.name, // 脚本
    buttons.toolbarPhraseButton.name, // 常用语
    buttons.toolbarClipboardButton.name, // 剪贴板
    buttons.toolbarCheckUpdateButton.name, // 应用商店中检查元书更新
    buttons.toolbarFeedbackButton.name, // 声音和震动
    buttons.toolbarFinderButton.name, // 打开元书文件管理器
    buttons.toolbarSkinButton.name, // 皮肤
    buttons.toolbarUploadButton.name, // WIFI 文件传输
    buttons.toolbarRimeDeployButton.name, // Rime部署
    buttons.toolbarToggleEmbeddedButton.name, // 内嵌开关
    buttons.toolbarLeftHandButton.name, // 左手模式
    buttons.toolbarRightHandButton.name, // 右手模式
    buttons.toolbarSchemaSelectorButton.name, // 方案切换
    buttons.toolbarKeyboardNumericButton.name, // 数字键盘
    buttons.toolbarKeyboardSymbolicButton.name, // 符号键盘
    buttons.toolbarKeyboardEmojiButton.name, // 表情键盘
    buttons.toolbarRimeSyncButton.name, // Rime同步
    buttons.toolbarSkinPreference.name, // 皮肤微调
    buttons.toolbarKeyboardDefinition.name, // 键盘按键定义
    buttons.toolbarKeyboardT9PinyinButton.name, // T9拼音键盘（测试用）
  ];
[
  buttons[names[buttonCode - 1]]
  for buttonCode in settings.toolbarButtons
];


local toolbarKeyboardLayout = [
  {
    HStack: {
      subviews: [
        { Cell: keyboardParams.toolbarButton.toolbarMenuButton.name, },
        { Cell: basicStyle.toolbarSlideButtonsName, },
        { Cell: keyboardParams.toolbarButton.toolbarDismissButton.name, },
      ],
    },
  },
];

local newButtons(isDark=false) =
  basicStyle.newToolbarButton(
    keyboardParams.toolbarButton.toolbarMenuButton.name,
    isDark,
    keyboardParams.toolbarButton.toolbarMenuButton.params,
  )
  + basicStyle.newToolbarButton(
    keyboardParams.toolbarButton.toolbarDismissButton.name,
    isDark,
    keyboardParams.toolbarButton.toolbarDismissButton.params,
  );


local newToolbar(isDark=false, isPortrait=false, params={}) =
  local slideButtonsMaxCount =
    if isPortrait then settings.toolbarButtonsMaxCount.portrait else settings.toolbarButtonsMaxCount.landscape;
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
      // {
      //   name: '复制', // 一般是对当前候选做处理，比如发送一个快捷键让rime处理这个候选，主要是给rime用，复制不行
      //   action: { shortcut: '#copy' },
      // },
    ],
  }
  + newButtons(isDark)
  + basicStyle.newToolbarSlideButtons(slideButtons, slideButtonsMaxCount, isDark)
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
