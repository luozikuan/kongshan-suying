local settings = import '../Settings.libsonnet';
local numericRow = import 'NumericRow.libsonnet';

{
  new(isDark, isPortrait):
    numericRow.new(isDark, isPortrait, numericRow.KeyboardType.English)
}
