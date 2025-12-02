// 提取对象中指定的属性
local extractProperty(obj, key) =
  if std.objectHas(obj, key) then
    { [key]: obj[key] }
  else
    {};

// 提取对象中多个指定的属性
local extractProperties(obj, keys) =
  { [key]: obj[key] for key in keys if std.objectHas(obj, key) };


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

{
  extractProperty: extractProperty,
  extractProperties: extractProperties,
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
}
