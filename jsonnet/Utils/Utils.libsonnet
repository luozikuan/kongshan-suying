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

local isPrintableAsciiChar(c) =
  assert std.type(c) == 'string' && std.length(c) == 1 : 'isPrintableAsciiChar requires a single character string, input is ' + c;
  local cp = std.codepoint(c);
  cp >= 32 && cp <= 126;


local isPrintableAsciiString(s) =
  assert std.type(s) == 'string' : 'isPrintableAsciiString requires a string, input is ' + s;
  std.all(std.map(isPrintableAsciiChar, std.stringChars(s)));


local calcDiffFontSizeForNonAsciiText(text, fontSize) =
  assert std.type(text) == 'string' : 'text parameter must be a string, input is ' + std.toString(text);
  if isPrintableAsciiString(text) && !std.startsWith(text, '$') then // 以 $ 开头的字符串通常是变量，极可能有中文，要调整大小
    fontSize
  else
    std.round(fontSize * 0.9);  // 非 ASCII 字符缩小显示


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
    'normalBorderColor',
    'highlightBorderColor',
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


local newFileImageStyle(params={}) =

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
  ) + (
    if std.objectHas(params, 'text') && std.objectHas(params, 'fontSize') then
    {
      fontSize: calcDiffFontSizeForNonAsciiText(params.text, params.fontSize),
    }
    else {}
  );

local newBackgroundStyle(styleName='backgroundStyle', style) = { [styleName]: style };
local newForegroundStyle(styleName='foregroundStyle', style) = { [styleName]: style };

local newAnimation(animation) = { animation: animation };

// 递归地将所有键名 character 替换为 symbol
local replaceCharacterToSymbolRecursive(params) =
  if std.isObject(params) then
    std.foldl(
      function(acc, key)
        acc + (
            if key == 'character' then
              { symbol: params[key] }
            else
              { [key]: replaceCharacterToSymbolRecursive(params[key]), }
       ),
      std.objectFields(params),
      {},
    )
  else if std.isArray(params) then
    std.map(replaceCharacterToSymbolRecursive, params)
  else
    params;

// 根据上滑和下滑提示文字位置计算按钮上文字的位置
local centerDelta(center) =
  local newCenter = if center == null then {} else center;
  {
    x: std.get(newCenter, 'x', 0.5) - 0.5,
    y: std.get(newCenter, 'y', 0.5) - 0.5,
  };

local addTwoPoint(a, b) = {
  x: a.x + b.x,
  y: a.y + b.y,
};

local sign(x) =
  if x > 0 then 1
  else if x < 0 then -1
  else 0;

local calcMainTextCenter(swipeUpTextCenter, swipeDownTextCenter) =
  local swipeUpCenterDelta = centerDelta(swipeUpTextCenter);
  local swipeDownCenterDelta = centerDelta(swipeDownTextCenter);
  {
    local delta = addTwoPoint(swipeUpCenterDelta, swipeDownCenterDelta),
    center: {
      x: 0.5 -0.05 * sign(delta.x),
      y: 0.5 -0.05 * sign(delta.y),
    }
  };

// 某些布局的数字键被用于打字，所以数字需要用 action.symbol 的方式直接上屏
local numericActionNeedSymbol(layout) =
  std.member(['9', 'bopomofo'],layout);

local normalizeCenter(center) = {
  x: std.get(center, 'x', 0.5),
  y: std.get(center, 'y', 0.5),
};

// 英文键盘下，对按键的 params 进行处理
// 1. 将 character 替换为 symbol
//    处理方式为 params = replaceCharacterToSymbolRecursive(params)
// 2. 将 params 中的 OnAlphabetic 合并到 params
//    处理方式为 params = std.objectRemoveKey(params + std.get(params, 'OnAlphabetic', default={}), 'OnAlphabetic') 的内容
local processButtonParams(isAlphabetic, params) =
  if isAlphabetic then
    local paramsWithSymbol = replaceCharacterToSymbolRecursive(params);
    std.mergePatch(paramsWithSymbol, std.get(paramsWithSymbol, 'OnAlphabetic', default={}))
  else
    params;

local capitalize(s) =
  if std.length(s) == 0 then s
  else std.asciiUpper(s[0:1]) + s[1:];

{
  extractProperty: extractProperty,
  extractProperties: extractProperties,
  excludeProperties: excludeProperties,
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
  replaceCharacterToSymbolRecursive: replaceCharacterToSymbolRecursive,
  calcMainTextCenter: calcMainTextCenter,
  numericActionNeedSymbol: numericActionNeedSymbol,
  normalizeCenter: normalizeCenter,
  processButtonParams: processButtonParams,
  capitalize: capitalize,
}
