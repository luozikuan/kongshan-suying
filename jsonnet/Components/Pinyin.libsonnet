local settings = import '../Settings.libsonnet';
local layout9  = import 'Pinyin9.libsonnet';
local layout14 = import 'Pinyin14.libsonnet';
local layout17 = import 'Pinyin17.libsonnet';
local layout18 = import 'Pinyin18.libsonnet';
local layout26 = import 'Pinyin26.libsonnet';
local layoutBopomofo = import 'PinyinBopomofo.libsonnet';
local layoutSigma = import 'PinyinSigma.libsonnet';

{
  new(isDark, isPortrait):
    if settings.keyboardLayout == '9' then
      layout9.new(isDark, isPortrait)
    else if settings.keyboardLayout == '14' then
      layout14.new(isDark, isPortrait)
    else if settings.keyboardLayout == '17' then
      layout17.new(isDark, isPortrait)
    else if settings.keyboardLayout == '18' then
      layout18.new(isDark, isPortrait)
    else if settings.keyboardLayout == 'bopomofo' then
      layoutBopomofo.new(isDark, isPortrait)
    else if settings.keyboardLayout == 'sigma' then
      layoutSigma.new(isDark, isPortrait)
    else
      layout26.new(isDark, isPortrait),
}
