// 提取对象中指定的属性
local extractProperty(obj, key) =
  if std.objectHas(obj, key) then
    { [key]: obj[key] }
  else
    {};

// 提取对象中多个指定的属性
local extractProperties(obj, keys) =
  { [key]: obj[key] for key in keys if std.objectHas(obj, key) };

// 排除对象中指定的属性，返回剩余的属性
local excludeProperties(obj, keys) =
  { [k]: obj[k] for k in std.objectFields(obj) if !std.member(keys, k) };

// 深度合并两个对象，例如
// local obj1 = { swipeUp: { action: { character: '.' } } };
// local obj2 = { swipeUp: { text: '。' } };
// deepMerge(obj1, obj2) 结果为 { swipeUp: { action: { character: '.' }, text: '。' } }
local deepMerge(x, y) =
  if std.isObject(x) && std.isObject(y) then
    // 遍历两个对象的所有字段
    {
      [k]:
        if std.objectHas(x, k) && std.objectHas(y, k) then
          deepMerge(x[k], y[k])  // 如果两边都有该字段，递归合并
        else if std.objectHas(x, k) then
          x[k]  // 只在 x 中存在
        else
          y[k]  // 只在 y 中存在
      for k in std.setUnion(std.objectFields(x), std.objectFields(y))
    }
  else y;  // 如果不是对象，直接用 y 覆盖


local setColor(name='', color, isDark=false) =
  if std.type(color) == 'string' then
    { [name]: color }
  else if std.type(color) == 'object' && std.objectHas(color, 'light') && std.objectHas(color, 'dark') then
    if isDark then
      { [name]: color.dark }
    else
      { [name]: color.light }
  else
    {};

local setColors(colorMap, isDark=false) =
  local colorKeys = std.objectFields(colorMap);
  std.foldl(
    function(acc, key) acc + setColor(key, colorMap[key], isDark),
    colorKeys,
    {}
  );

// 从样式对象中提取并设置特定的颜色属性
local extractColors(styleObj, colorKeys, isDark=false) =
  local extractedColors = extractProperties(styleObj, colorKeys);
  setColors(extractedColors, isDark);


local newGeometryStyle(params={}, isDark=false) =
  local type = { buttonStyleType: 'geometry' };

  local colors = extractColors(params, [
    'normalColor',
    'highlightColor',
    'borderColor',
    'normalLowerEdgeColor',
    'highlightLowerEdgeColor',
    'normalShadowColor',
    'highlightShadowColor',
  ], isDark);

  type
  + colors
  + extractProperties(
    params,
    [
      'insets',
      'size',
      'colorLocation',
      'colorStartPoint',
      'colorEndPoint',
      'colorGradientType',
      'cornerRadius',
      'borderSize',
      'shadowRadius',
      'shadowOffset',
      'shadowOpacity',
    ]
  );

local newSystemImageStyle(params={}, isDark=false) =

  assert std.objectHas(params, 'systemImageName') : 'systemImage style requires systemImageName';

  local type = { buttonStyleType: 'systemImage' };

  local colors = extractColors(params, [
    'normalColor',
    'highlightColor',
  ], isDark);

  type
  + colors
  + extractProperties(
    params,
    [
      'insets',
      'center',
      'systemImageName',
      'highlightSystemImageName',
      'contentMode',
      'fontSize',
      'fontWeight',
    ]
  );

local newAssetImageStyle(params={}, isDark=false) =

  assert std.objectHas(params, 'assetImageName') : 'assetImage style requires assetImageName';

  local type = { buttonStyleType: 'assetImage' };

  local colors = extractColors(params, [
    'normalColor',
    'highlightColor',
  ], isDark);


  type
  + colors
  + extractProperties(
    params,
    [
      'insets',
      'assetImageName',
      'contentMode',
    ]
  );


local newFileImageStyle(params={}, isDark=false) =

  local type = { buttonStyleType: 'fileImage' };

  type
  + extractProperties(
    params,
    [
      'insets',
      'contentMode',
      'normalImage',
      'highlightImage',
    ]
  );

local newTextStyle(params={}, isDark=false) =

  local type = { buttonStyleType: 'text' };

  local colors = extractColors(params, [
    'normalColor',
    'highlightColor',
  ], isDark);

  type
  + colors
  + extractProperties(
    params,
    [
      'insets',
      'center',
      'text',
      'fontSize',
      'fontWeight',
    ]
  );

local newBackgroundStyle(styleName='backgroundStyle', style) = { [styleName]: style };
local newForegroundStyle(styleName='foregroundStyle', style) = { [styleName]: style };

local newAnimation(animation) = { animation: animation };

local newRowKeyboardLayout(rows) = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          {
            Cell: button.name,
          }
          for button in row
        ],
      },
    }
    for row in rows
  ],
};

// ascii mode 变化时生成 notification 及 foreground style
local asciiModeForegroundStyleName(name, value) =
  name + 'AsciiMode' + (if value then 'On' else 'Off') + 'ForegroundStyle';
local newAsciiModeForegroundStyle(name, foregroundOff, foregroundOn) = {
  [asciiModeForegroundStyleName(name, true)]: foregroundOn,
  [asciiModeForegroundStyleName(name, false)]: foregroundOff,
};

local asciiModeChangedNotificationName(name, value) =
  name + 'AsciiMode' + (if value then 'On' else 'Off') + 'Notification';

local newAsciiModeChangedNotification(name, value, params={}) = {  // value is true or false
  [asciiModeChangedNotificationName(name, value)]: {
    notificationType: 'rime',
    rimeNotificationType: 'optionChanged',
    rimeOptionName: 'ascii_mode',
    rimeOptionValue: value,
    backgroundStyle: params.backgroundStyleName,
    foregroundStyle: params.foregroundStyleName,
  } + extractProperties(
    params,
    [
      'action',
      'bounds',
      'hintStyle',
      'hintSymbolsStyle',
      'uppercasedStateForegroundStyle',
      'capsLockedStateForegroundStyle',
    ]
  ),
};

{
  extractProperty: extractProperty,
  extractProperties: extractProperties,
  excludeProperties: excludeProperties,
  deepMerge: deepMerge,
  setColor: setColor,
  extractColors: extractColors,
  newGeometryStyle: newGeometryStyle,
  newSystemImageStyle: newSystemImageStyle,
  newAssetImageStyle: newAssetImageStyle,
  newFileImageStyle: newFileImageStyle,
  newTextStyle: newTextStyle,
  newBackgroundStyle: newBackgroundStyle,
  newForegroundStyle: newForegroundStyle,
  newAnimation: newAnimation,
  newRowKeyboardLayout: newRowKeyboardLayout,
  asciiModeForegroundStyleName: asciiModeForegroundStyleName,
  newAsciiModeForegroundStyle: newAsciiModeForegroundStyle,
  asciiModeChangedNotificationName: asciiModeChangedNotificationName,
  newAsciiModeChangedNotification: newAsciiModeChangedNotification,
}
