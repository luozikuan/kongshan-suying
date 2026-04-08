local settings = import '../Settings.libsonnet';
local numeric9 = import 'Numeric9.libsonnet';
local numericRow = import 'NumericRow.libsonnet';
local numericHex = import 'NumericHex.libsonnet';

{
  new(isDark, isPortrait):
    if settings.numericLayout == 'row' then
      numericRow.new(isDark, isPortrait, numericRow.KeyboardType.Chinese)
    else if settings.numericLayout == 'hex' then
      numericHex.new(isDark, isPortrait)
    else
      numeric9.new(isDark, isPortrait)
}
