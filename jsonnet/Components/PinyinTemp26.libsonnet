local layout26 = import 'Pinyin26.libsonnet';

{
  new(isDark, isPortrait):
    layout26.new(isDark, isPortrait, layout26.KeyboardType.Temp26Key),
}
