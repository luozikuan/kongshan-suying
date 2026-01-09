local iPhoneNumeric = import 'Components/iPhoneNumeric.libsonnet';
local iPhonePinyin = import 'Components/iPhonePinyin.libsonnet';
local iPadPinyin = import 'Components/iPadPinyin.libsonnet';
local iPadNumeric = import 'Components/iPadNumeric.libsonnet';
local floatingKeyboard = import 'Components/FloatingKeyboard.libsonnet';
local portraitT9Pinyin = import 'Components/PortraitT9Pinyin.libsonnet';

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

local FloatingKeyboardPortraitName(name) = name + 'Portrait';
local lightFloatingKeyboardPortraitContent = floatingKeyboard.new(isDark=false, isPortrait=true);
local darkFloatingKeyboardPortraitContent = floatingKeyboard.new(isDark=true, isPortrait=true);

local FloatingKeyboardLandscapeName(name) = name + 'Landscape';
local lightFloatingKeyboardLandscapeContent = floatingKeyboard.new(isDark=false, isPortrait=false);
local darkFloatingKeyboardLandscapeContent = floatingKeyboard.new(isDark=true, isPortrait=false);

local portraitT9PinyinFileName = 'portraitT9Pinyin';
local lightPortraitT9PinyinFileContent = portraitT9Pinyin.new(isDark=false, isPortrait=true);
local darkPortraitT9PinyinFileContent = portraitT9Pinyin.new(isDark=true, isPortrait=true);


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
  t9Pinyin: {
    iPhone: {
      portrait: portraitT9PinyinFileName,
      landscape: portraitT9PinyinFileName,
    },
  },
} + {
  // 浮动键盘面板
  [name]:
    local portraitName = FloatingKeyboardPortraitName(name);
    local landscapeName = FloatingKeyboardLandscapeName(name);
    {
      iPhone: {
        portrait: portraitName,
        landscape: landscapeName,
      },
      iPad: {
        portrait: portraitName,
        landscape: landscapeName,
        floating: portraitName,
      },
    }
  for name in std.objectFields(lightFloatingKeyboardPortraitContent)
};

// std.toString 生成的内容紧凑，生成速度快，但不易阅读，适合发布时使用
// std.manifestYamlDoc 生成的内容格式化良好，易于阅读，但生成速度慢，也更占用内存，适合在电脑上调试时使用
// 如果想让 debug=true，需要在命令行中使用 --tla-code debug=true 参数传入
function(debug=false)
  local toString =
    if debug then
      function(x) std.manifestYamlDoc(x, indent_array_in_object=false, quote_keys=false)
    else
      function(x) std.toString(x);
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

  // t9 拼音
  ['light/' + portraitT9PinyinFileName + '.yaml']: toString(lightPortraitT9PinyinFileContent),
  ['dark/' + portraitT9PinyinFileName + '.yaml']: toString(darkPortraitT9PinyinFileContent),

  // 浮动键盘
  // ['light/' + panelPortraitName + '.yaml']: toString(lightPanelPortraitContent),
  // ['dark/' + panelPortraitName + '.yaml']: toString(darkPanelPortraitContent),
  // ['light/' + panelLandscapeName + '.yaml']: toString(lightPanelLandscapeContent),
  // ['dark/' + panelLandscapeName + '.yaml']: toString(darkPanelLandscapeContent),
}
+ {
  // 浮动键盘 light Portrait
  ['light/' + name + 'Portrait.yaml']: toString(lightFloatingKeyboardPortraitContent[name])
  for name in std.objectFields(lightFloatingKeyboardPortraitContent)
} + {
  // 浮动键盘 dark Portrait
  ['dark/' + name + 'Portrait.yaml']: toString(darkFloatingKeyboardPortraitContent[name])
  for name in std.objectFields(darkFloatingKeyboardPortraitContent)
} + {
  // 浮动键盘 light Landscape
  ['light/' + name + 'Landscape.yaml']: toString(lightFloatingKeyboardLandscapeContent[name])
  for name in std.objectFields(lightFloatingKeyboardLandscapeContent)
} + {
  // 浮动键盘 dark Landscape
  ['dark/' + name + 'Landscape.yaml']: toString(darkFloatingKeyboardLandscapeContent[name])
  for name in std.objectFields(darkFloatingKeyboardLandscapeContent)
}
