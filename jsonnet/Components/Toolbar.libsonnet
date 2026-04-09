local colors = import '../Constants/Colors.libsonnet';
local keyboardParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import '../Styles/BasicStyle.libsonnet';
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
          Cell: verticalCandidateReturnButtonStyleName,
        },
        {
          Cell: verticalCandidatePageUpButtonStyleName,
        },
        {
          Cell: verticalCandidatePageDownButtonStyleName,
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

// NOTE: 工具栏按钮列表，顺序与 settings.toolbarButtons 中的描述对应
local toolbarButtonNames = local buttons = keyboardParams.toolbarButton;
[
  buttons.toolbarScriptButton.name, // 脚本
  buttons.toolbarPhraseButton.name, // 常用语
  buttons.toolbarClipboardButton.name, // 剪贴板
  buttons.toolbarSkinButton.name, // 皮肤
  buttons.toolbarFinderButton.name, // 打开元书文件管理器
  buttons.toolbarSchemaSelectorButton.name, // 方案切换
  buttons.toolbarKeyboardNumericButton.name, // 数字键盘
  buttons.toolbarKeyboardSymbolicButton.name, // 符号键盘
  buttons.toolbarKeyboardEmojiButton.name, // 表情键盘
  buttons.toolbarPerformanceButton.name, // 查看性能
  buttons.toolbarLeftHandButton.name, // 左手模式
  buttons.toolbarRightHandButton.name, // 右手模式
  buttons.toolbarRimeSyncButton.name, // Rime同步
  buttons.toolbarRimeDeployButton.name, // Rime部署
  buttons.toolbarRimeInputSchemaButton.name, // Rime方案管理
  buttons.toolbarRimeQuickButton.name, // 快符
  buttons.toolbarRimeSwitcherButton.name, // RimeSwitcher
  buttons.toolbarSkinPreference.name, // 皮肤微调
  buttons.toolbarKeyboardDefinition.name, // 键盘按键定义
  buttons.toolbarSelectAllTextButton.name, // 全选文本
  buttons.toolbarCopyTextButton.name, // 复制文本
  buttons.toolbarCutTextButton.name, // 剪切文本
  buttons.toolbarPasteTextButton.name, // 粘贴文本
  buttons.toolbarUndoButton.name, // 撤销
  buttons.toolbarRedoButton.name, // 重做
  buttons.toolbarMoveCursorLeftButton.name, // 光标左移
  buttons.toolbarMoveCursorRightButton.name, // 光标右移
];

local needSlideToolbar(slideButtons, slideButtonsMaxCount) =
  std.length(slideButtons) > slideButtonsMaxCount;

local toolbarKeyboardLayout(slideButtons, slideButtonsMaxCount) = [
  {
    HStack: {
      subviews: [
        { Cell: keyboardParams.toolbarButton.toolbarMenuButton.name, },
      ] + (
        if needSlideToolbar(slideButtons, slideButtonsMaxCount) then
          [{ Cell: basicStyle.toolbarSlideButtonsName, }]
        else
          [{ Cell: '' } for i in std.range(1, slideButtonsMaxCount - std.length(slideButtons))] +
          [{ Cell: button.name, } for button in slideButtons]
      ) + [
        { Cell: keyboardParams.toolbarButton.toolbarDismissButton.name, },
      ],
    },
  },
];


local newSlideAreaButtons(slideButtons, slideButtonsMaxCount, isDark, keyboardName) =
  if needSlideToolbar(slideButtons, slideButtonsMaxCount) then
    basicStyle.newToolbarSlideButtons(slideButtons, slideButtonsMaxCount, isDark)
  else
    std.foldl(
      function(acc, button) acc +
        basicStyle.newToolbarButton(
          button.name,
          isDark,
          std.mergePatch(button.params, std.get(button.params, 'On'+utils.capitalize(keyboardName), default={}))
        ),
      slideButtons,
      {}
    );

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

local newToolbar(isDark=false, isPortrait=false, keyboardName, params={}) =
  local slideButtons =
  [
    local btn = keyboardParams.toolbarButton[toolbarButtonNames[buttonCode - 1]];
    std.mergePatch(btn, { params: std.get(btn.params, 'On'+utils.capitalize(keyboardName), {})})
    for buttonCode in settings.toolbarSlideButtons
  ];
  local slideButtonsMaxCount =
    if isPortrait then settings.toolbarSlideButtonsMaxCount.portrait else settings.toolbarSlideButtonsMaxCount.landscape;
  {
    toolbarHeight: keyboardParams.toolbar.height,
    toolbarStyle: {
             insets: keyboardParams.toolbar.insets,
           }
           + utils.newBackgroundStyle(style=toolbarBackgroundStyleName),
    toolbarLayout: toolbarKeyboardLayout(slideButtons, slideButtonsMaxCount),
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
        name: '简繁',
        action: { sendKeys: 'Control+Shift+dollar' },
      },
    ],
  }
  + newButtons(isDark)
  + newSlideAreaButtons(slideButtons, slideButtonsMaxCount, isDark, keyboardName)
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
