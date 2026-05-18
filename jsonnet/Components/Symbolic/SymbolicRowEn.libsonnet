local symbolicRow = import 'SymbolicRow.libsonnet';

{
  new(isDark, isPortrait):
    symbolicRow.new(isDark, isPortrait, symbolicRow.KeyboardType.English),
}
