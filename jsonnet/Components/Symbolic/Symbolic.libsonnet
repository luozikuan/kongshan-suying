local settings = import '../../Settings.libsonnet';
local symbolicRow = import 'SymbolicRow.libsonnet';
local symbolicClassified = import 'SymbolicClassified.libsonnet';

{
  new(isDark, isPortrait):
	if settings.symbolicLayout == 'row' then
	  symbolicRow.new(isDark, isPortrait, symbolicRow.KeyboardType.Chinese)
    else if settings.symbolicLayout == 'classified' then
      symbolicClassified.new(isDark, isPortrait)
    else
	  assert false : 'wrong symbolic layout type, settings.symbolicLayout=' + settings.symbolicLayout;
	  {}
}
