local settings = import 'Settings.libsonnet';

// 颜色对比度计算函数
local removeAlpha(hex) =
  if std.length(hex) == 9 then
    '#' + std.substr(hex, 1, 6)
  else
    hex;

// 将十六进制颜色转换为 RGB 值
local hexToRgb(hex) =
  local cleanHex = if std.startsWith(hex, '#') then std.substr(hex, 1, std.length(hex) - 1) else hex;
  local r = std.parseHex(std.substr(cleanHex, 0, 2));
  local g = std.parseHex(std.substr(cleanHex, 2, 2));
  local b = std.parseHex(std.substr(cleanHex, 4, 2));
  { r: r, g: g, b: b };

// 计算相对亮度（Relative Luminance）
local getRelativeLuminance(rgb) =
  local normalize(channel) =
    local c = channel / 255.0;
    if c <= 0.03928 then
      c / 12.92
    else
      std.pow((c + 0.055) / 1.055, 2.4);

  local rLin = normalize(rgb.r);
  local gLin = normalize(rgb.g);
  local bLin = normalize(rgb.b);

  0.2126 * rLin + 0.7152 * gLin + 0.0722 * bLin;

// 计算两个颜色的对比度
local getContrastRatio(lum1, lum2) =
  local lighter = if lum1 > lum2 then lum1 else lum2;
  local darker = if lum1 > lum2 then lum2 else lum1;
  (lighter + 0.05) / (darker + 0.05);

// 选择对比度更高的前景色
// bgColor: 背景颜色（十六进制字符串）
// fgColor1, fgColor2: 两个候选前景色（十六进制字符串）
// 若浅色易辨认，则返回浅色，否则返回对比度更高的那个颜色
local selectBetterForeground(bgColor, fgColor1, fgColor2) =
  local lumbg = getRelativeLuminance(hexToRgb(bgColor));
  local lum1 = getRelativeLuminance(hexToRgb(fgColor1));
  local lum2 = getRelativeLuminance(hexToRgb(fgColor2));
  local color1 = { lum: lum1, color: fgColor1 };
  local color2 = { lum: lum2, color: fgColor2 };
  local lighter = if lum1 > lum2 then color1 else color2;
  local darker = if lum1 > lum2 then color2 else color1;
  local contrast1 = getContrastRatio(lumbg, lighter.lum);
  local easyToReadContrast = 4.5;
  if contrast1 > easyToReadContrast then
    lighter.color
  else
    local contrast2 = getContrastRatio(lumbg, darker.lum);
    if contrast1 > contrast2 then lighter.color else darker.color;


// 标签颜色常量定义
local labelColor = {
  primary: {
    light: '#000000',
    dark: '#FFFFFF',
  },
  secondary: {
    light: '#3c3c4399',
    dark: '#b6b7b9',
  },
  tertiary: {
    light: '#3c3c434d',
    dark: '#ebebf54d',
  },
  quaternary: {
    light: '#3c3c432e',
    dark: '#ebebf529',
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
  { // red
    light: '#da4357',
    dark: '#d74255',
  },
  { // green
    light: '#86c77a',
    dark: '#86c77a',
  },
  { // orange
    light: '#ea7c43',
    dark: '#ea7c43',
  },
  { // blue
    light: '#2e67f8',
    dark: '#2e67f8',
  },
];

local colorButtonBackgroundColor = if settings.accentColor == 0 then systemButtonBackgroundColor else
  accentColors[settings.accentColor - 1];
local colorButtonForegroundColor = if settings.accentColor == 0 then systemButtonForegroundColor else
  {
    light: selectBetterForeground(colorButtonBackgroundColor.light, labelColor.primary.light, labelColor.primary.dark),
    dark: selectBetterForeground(colorButtonBackgroundColor.dark, labelColor.primary.light, labelColor.primary.dark),
  };

local colorButtonHighlightedBackgroundColor = systemButtonHighlightedBackgroundColor;
local colorButtonHighlightedForegroundColor = {
  light: labelColor.primary.light,
  dark: labelColor.primary.dark,
};

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
  removeAlpha: removeAlpha,
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
