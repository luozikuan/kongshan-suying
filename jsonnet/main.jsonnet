local iPhoneNumeric = import 'Components/iPhoneNumeric.libsonnet';
local iPhonePinyin = import 'Components/iPhonePinyin.libsonnet';
local iPhoneSymbolic = import 'Components/iPhoneSymbolic.libsonnet';
local iPadPinyin = import 'Components/iPadPinyin.libsonnet';
local iPadNumeric = import 'Components/iPadNumeric.libsonnet';
local panel = import 'Components/Panel.libsonnet';

local pinyinPortraitFileName = 'pinyinPortrait';
local lightPinyinPortraitFileContent = iPhonePinyin.new(isDark=false, isPortrait=true);
local darkPinyinPortraitFileContent = iPhonePinyin.new(isDark=true, isPortrait=true);

local pinyinLandscapeFileName = 'pinyinLandscape';
local lightPinyinLandscapeFileContent = iPhonePinyin.new(isDark=false, isPortrait=false);
local darkPinyinLandscapeFileContent = iPhonePinyin.new(isDark=true, isPortrait=false);

local numericPortraitFileName = 'numericPortrait';
local lightNumericPortraitFileContent = iPhoneNumeric.new(isDark=false, isPortrait=true);
local darkNumericPortraitFileContent = iPhoneNumeric.new(isDark=true, isPortrait=true);

local numericLandscapeName = 'numericLandscape';
local lightNumericLandscapeFileContent = iPhoneNumeric.new(isDark=false, isPortrait=false);
local darkNumericLandscapeFileContent = iPhoneNumeric.new(isDark=true, isPortrait=false);

local symbolicPortraitFileName = 'symbolicPortrait';
local lightSymbolicPortraitFileContent = iPhoneSymbolic.new(isDark=false, isPortrait=true);
local darkSymbolicPortraitFileContent = iPhoneSymbolic.new(isDark=true, isPortrait=true);

local symbolicLandscapeName = 'symbolicLandscape';
local lightSymbolicLandscapeFileContent = iPhoneSymbolic.new(isDark=false, isPortrait=false);
local darkSymbolicLandscapeFileContent = iPhoneSymbolic.new(isDark=true, isPortrait=false);

local iPadPinyinPortraitName = 'iPadPinyinPortrait';
local lightIpadPinyinPortraitContent = iPadPinyin.new(isDark=false, isPortrait=true);
local darkIpadPinyinPortraitContent = iPadPinyin.new(isDark=true, isPortrait=true);

local iPadPinyinLandscapeName = 'iPadPinyinLandscape';
local lightIpadPinyinLandscapeContent = iPadPinyin.new(isDark=false, isPortrait=false);
local darkIpadPinyinLandscapeContent = iPadPinyin.new(isDark=true, isPortrait=false);

local iPadNumericPortraitName = 'iPadNumericPortrait';
local lightIpadNumericPortraitContent = iPadNumeric.new(isDark=false, isPortrait=true);
local darkIpadNumericPortraitContent = iPadNumeric.new(isDark=true, isPortrait=true);

local iPadNumericLandscapeName = 'iPadNumericLandscape';
local lightIpadNumericLandscapeContent = iPadNumeric.new(isDark=false, isPortrait=false);
local darkIpadNumericLandscapeContent = iPadNumeric.new(isDark=true, isPortrait=false);

local panelPortraitName = 'panelPortrait';
local lightPanelPortraitContent = panel.new(isDark=false, isPortrait=true);
local darkPanelPortraitContent = panel.new(isDark=true, isPortrait=true);

local panelLandscapeName = 'panelLandscape';
local lightPanelLandscapeContent = panel.new(isDark=false, isPortrait=false);
local darkPanelLandscapeContent = panel.new(isDark=true, isPortrait=false);

local config = {
  pinyin: {
    iPhone: {
      portrait: pinyinPortraitFileName,
      landscape: pinyinLandscapeFileName,
    },
    iPad: {
      portrait: iPadPinyinPortraitName,
      landscape: iPadPinyinLandscapeName,
      floating: pinyinPortraitFileName,
    },
  },
  numeric: {
    iPhone: {
      portrait: numericPortraitFileName,
      landscape: numericLandscapeName,
    },
    iPad: {
      portrait: iPadNumericPortraitName,
      landscape: iPadNumericLandscapeName,
      floating: numericPortraitFileName,
    },
  },

  // 符号键盘
  symbolic: {
    iPhone: {
      portrait: symbolicPortraitFileName,
      landscape: symbolicLandscapeName,
    },
    iPad: {
      portrait: iPadPinyinPortraitName,
      landscape: iPadPinyinLandscapeName,
      floating: symbolicPortraitFileName,
    },
  },

  // 浮动键盘面板
  panel: {
    iPhone: {
      portrait: panelPortraitName,
      landscape: panelLandscapeName,
    },
    iPad: {
      portrait: panelPortraitName,
      landscape: panelLandscapeName,
      floating: panelPortraitName,
    },
  },
};

// std.toString 生成的内容紧凑，生成速度快，但不易阅读
// std.manifestYamlDoc 生成的内容格式化良好，易于阅读，但生成速度慢，也更占用内存
// 在 PC 上调试时可以设置 forDebug=true
local forDebug = true;
local toString(x) = if forDebug then std.manifestYamlDoc(x, indent_array_in_object=false, quote_keys=false) else std.toString(x);

{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),

  // 拼音键盘
  ['light/' + pinyinPortraitFileName + '.yaml']: toString(lightPinyinPortraitFileContent),
  ['dark/' + pinyinPortraitFileName + '.yaml']: toString(darkPinyinPortraitFileContent),
  ['light/' + pinyinLandscapeFileName + '.yaml']: toString(lightPinyinLandscapeFileContent),
  ['dark/' + pinyinLandscapeFileName + '.yaml']: toString(darkPinyinLandscapeFileContent),

  // 数字键盘
  // ['light/' + numericPortraitFileName + '.yaml']: std.manifestYamlDoc(lightNumericPortraitFileContent, indent_array_in_object=false, quote_keys=false),
  ['light/' + numericPortraitFileName + '.yaml']: toString(lightNumericPortraitFileContent),
  ['dark/' + numericPortraitFileName + '.yaml']: toString(darkNumericPortraitFileContent),
  ['light/' + numericLandscapeName + '.yaml']: toString(lightNumericLandscapeFileContent),
  ['dark/' + numericLandscapeName + '.yaml']: toString(darkNumericLandscapeFileContent),

  // 符号键盘
  ['light/' + symbolicPortraitFileName + '.yaml']: toString(lightSymbolicPortraitFileContent),
  ['dark/' + symbolicPortraitFileName + '.yaml']: toString(darkSymbolicPortraitFileContent),
  ['light/' + symbolicLandscapeName + '.yaml']: toString(lightSymbolicLandscapeFileContent),
  ['dark/' + symbolicLandscapeName + '.yaml']: toString(darkSymbolicLandscapeFileContent),

  // iPad 拼音键盘
  ['light/' + iPadPinyinPortraitName + '.yaml']: toString(lightIpadPinyinPortraitContent),
  ['dark/' + iPadPinyinPortraitName + '.yaml']: toString(darkIpadPinyinPortraitContent),
  ['light/' + iPadPinyinLandscapeName + '.yaml']: toString(lightIpadPinyinLandscapeContent),
  ['dark/' + iPadPinyinLandscapeName + '.yaml']: toString(darkIpadPinyinLandscapeContent),

  // iPad 数字键盘
  ['light/' + iPadNumericPortraitName + '.yaml']: toString(lightIpadNumericPortraitContent),
  ['dark/' + iPadNumericPortraitName + '.yaml']: toString(darkIpadNumericPortraitContent),
  ['light/' + iPadNumericLandscapeName + '.yaml']: toString(lightIpadNumericLandscapeContent),
  ['dark/' + iPadNumericLandscapeName + '.yaml']: toString(darkIpadNumericLandscapeContent),

  // 浮动键盘
  ['light/' + panelPortraitName + '.yaml']: toString(lightPanelPortraitContent),
  ['dark/' + panelPortraitName + '.yaml']: toString(darkPanelPortraitContent),
  ['light/' + panelLandscapeName + '.yaml']: toString(lightPanelLandscapeContent),
  ['dark/' + panelLandscapeName + '.yaml']: toString(darkPanelLandscapeContent),
}
