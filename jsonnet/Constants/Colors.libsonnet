local settings = import '../Settings.libsonnet';

// 标签颜色常量定义
local labelColor = {
  primary: {
    light: '#000000',
    dark: '#FFFFFF',
  },
  secondary: {
    light: '#8a8a8a',
    dark: '#b6b7b9',
  },
  tertiary: {
    light: '#c4c4c4',
    dark: '#5d5d5d',
  },
  quaternary: {
    light: '#dcdcdc',
    dark: '#404040',
  },
};

// 分割线颜色
local separatorColor = {
  light: '#C6C6C8',
  dark: '#38383A',
};

// 键盘背景色 03 表示 0.01 的透明度
local keyboardBackgroundColor = {
  light: '#ffffff03',
  dark: '#00000003',
};

// 标准按键背景色（如字母按键、空格键等）
local standardButtonBackgroundColor = {
  light: '#FFFFFF',
  dark: '#D1D1D165',
};

// 标准按键按下时的背景色
local standardButtonHighlightedBackgroundColor = {
  light: '#E6E6E6',
  dark: '#D1D1D624',
};

// 标准按键前景色（如字母按键、空格键等），用于按键的字体，图片等
local standardButtonForegroundColor = labelColor.primary;

local standardButtonHighlightedForegroundColor = standardButtonForegroundColor;

// 标准按键备用色，用于显示上下划提示等
local alternativeForegroundColor = labelColor.secondary;
local alternativeHighlightedForegroundColor = alternativeForegroundColor;

// 标准按键阴影颜色
local standardButtonShadowColor = {
  light: '#898A8D',
  dark: '#000000',
};

// 系统按键（如回车、删除等）背景颜色
local systemButtonBackgroundColor = {
  light: '#E6E6E6',
  dark: '#D1D1D624',
};

local systemButtonHighlightedBackgroundColor = {
  light: '#FFFFFF',
  dark: '#D1D1D659',
};

// 系统按键（如回车、删除等）前景颜色
local systemButtonForegroundColor = labelColor.primary;

local systemButtonHighlightedForegroundColor = systemButtonForegroundColor;

// MARK: 一定要与 Settings.libsonnet 中的 accentColor 编号对应
local accentColors = [
  // 在这里检查一下对比度 https://webaim.org/resources/contrastchecker/
  // 确保前景色和背景色的对比度足够高（至少大于 3）以保证可读性
  { // red
    background: '#da4357',
    foreground: '#ffffff',
  },
  { // green
    background: '#50A545',
    foreground: '#ffffff',
  },
  { // orange
    background: '#E86E30',
    foreground: '#ffffff',
  },
  { // blue
    background: '#2e67f8',
    foreground: '#ffffff',
  },
];

local colorButtonBackgroundColor = if settings.accentColor == 0 then systemButtonBackgroundColor else
  local color = accentColors[settings.accentColor - 1].background;
  {
    light: color,
    dark: color,
  };
local colorButtonForegroundColor = if settings.accentColor == 0 then systemButtonForegroundColor else
  local color = accentColors[settings.accentColor - 1].foreground;
  {
    light: color,
    dark: color,
  };

local colorButtonHighlightedBackgroundColor = systemButtonHighlightedBackgroundColor;
local colorButtonHighlightedForegroundColor = labelColor.primary;

// 按键底部边缘颜色
local lowerEdgeOfButtonNormalColor = {
  light: '#898A8D',
  dark: '#1E1E1E',
};

// 按下状态下，按键底部边缘颜色
local lowerEdgeOfButtonHighlightColor = {
  light: '#898A8D',
  dark: '#1D1D1D',
};

// 标准按键 Hint 背景色(包含长按符号列表的背景色)
local standardCalloutBackgroundColor = {
  light: '#ffffff',
  dark: '#6B6B6B',
};

// 标准按键 Hint 前景色，用于按键的字体，图片等
local standardCalloutForegroundColor = standardButtonForegroundColor;

local standardCalloutHighlightedForegroundColor = {
  light: '#FFFFFF',
  dark: '#E6E6E6',
};

// 标准按键 Hint 选中背景色，如长按符号列表中选中的符号背景色
local standardCalloutSelectedBackgroundColor = colorButtonBackgroundColor;

// 标准按键 Hint 边框颜色
local standardCalloutBorderColor = {
  light: '#C6C6C8',
  dark: '#606060',
};

// 预编辑区文字颜色
local preeditForegroundColor = standardButtonForegroundColor;

// 工具栏按钮前景色
local toolbarButtonForegroundColor = standardButtonForegroundColor;

// 工具栏按钮高亮前景色
local toolbarButtonHighlightedForegroundColor = standardButtonForegroundColor;

// 候选字亮候选字背景颜色
local candidateHighlightColor = standardButtonBackgroundColor;
local candidateForegroundColor = standardButtonForegroundColor;

// 候选字分隔线颜色
local candidateSeparatorColor = separatorColor;


{
  labelColor: labelColor,
  separatorColor: separatorColor,
  keyboardBackgroundColor: keyboardBackgroundColor,
  standardButtonBackgroundColor: standardButtonBackgroundColor,
  standardButtonHighlightedBackgroundColor: standardButtonHighlightedBackgroundColor,
  standardButtonForegroundColor: standardButtonForegroundColor,
  standardButtonHighlightedForegroundColor: standardButtonHighlightedForegroundColor,
  alternativeForegroundColor: alternativeForegroundColor,
  alternativeHighlightedForegroundColor: alternativeHighlightedForegroundColor,
  standardButtonShadowColor: standardButtonShadowColor,
  systemButtonBackgroundColor: systemButtonBackgroundColor,
  systemButtonHighlightedBackgroundColor: systemButtonHighlightedBackgroundColor,
  systemButtonForegroundColor: systemButtonForegroundColor,
  systemButtonHighlightedForegroundColor: systemButtonHighlightedForegroundColor,
  colorButtonBackgroundColor: colorButtonBackgroundColor,
  colorButtonHighlightedBackgroundColor: colorButtonHighlightedBackgroundColor,
  colorButtonForegroundColor: colorButtonForegroundColor,
  colorButtonHighlightedForegroundColor: colorButtonHighlightedForegroundColor,
  lowerEdgeOfButtonNormalColor: lowerEdgeOfButtonNormalColor,
  lowerEdgeOfButtonHighlightColor: lowerEdgeOfButtonHighlightColor,
  standardCalloutBackgroundColor: standardCalloutBackgroundColor,
  standardCalloutForegroundColor: standardCalloutForegroundColor,
  standardCalloutHighlightedForegroundColor: standardCalloutHighlightedForegroundColor,
  standardCalloutSelectedBackgroundColor: standardCalloutSelectedBackgroundColor,
  standardCalloutBorderColor: standardCalloutBorderColor,
  preeditForegroundColor: preeditForegroundColor,
  toolbarButtonForegroundColor: toolbarButtonForegroundColor,
  toolbarButtonHighlightedForegroundColor: toolbarButtonHighlightedForegroundColor,
  candidateHighlightColor: candidateHighlightColor,
  candidateForegroundColor: candidateForegroundColor,
  candidateSeparatorColor: candidateSeparatorColor,
}
