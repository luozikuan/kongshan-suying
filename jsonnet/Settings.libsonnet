#======================================
# 此文件用于微调皮肤设置。
# 可根据需要修改下方内容，调整皮肤的相关参数。
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#======================================
{
  # 是否使用类似 PC 键盘的布局
  # 即，ZXCVBNM 这一行向左移半个键位宽度
  # true 左移半格，false 不左移
  usePCLayout: true,


  # 输入时空格键上的内容，支持固定内容和变量
  # 变量可选如下：
  # $rimePreedit：Rime 预编辑文本
  # $rimeCandidate：Rime 首个候选字
  # $rimeCandidateComment: Rime 首个候选字的 comment 信息
  spaceButtonComposingText: '$rimeCandidate',


  # 是否在空格键上显示方案名称
  # true 显示方案名称，false 不显示
  spaceButtonShowSchema: true,


  # 方案名称在空格键上的位置，有的方案名称
  # 较长，需要调整 x 值以免超出按键
  spaceButtonSchemaNameCenter: {
    x: 0.2,
    y: 0.7
  },


  # 是否显示上下滑动提示
  # true 显示，false 不显示
  showSwipeUpText: true,
  showSwipeDownText: false,


  # toolbar 按钮最大数量（不包括菜单和收起按钮）
  toolbarButtonsMaxCount: {
    portrait: 5,   # 竖屏
    landscape: 8,  # 横屏
  },


  # toolbar 滑动按钮列表
  # 注意键盘上第一个永远是菜单按钮，
  # 最后一个永远是收起按钮，不可配置
  # 按钮代号列表，填入到后面的数组即可
  # 1-查看性能  2-RimeSwitcher  3-脚本
  # 4-常用语    5-剪贴板    6-元书检查更新
  # 7-声音和震动  8-元书文件管理器  9-皮肤
  # 10-WIFI传输  11-Rime部署  12-内嵌开关
  # 13-左手模式  14-右手模式  15-方案切换
  # 16-数字键盘  17-符号键盘  18-表情键盘
  # 19-Rime同步  20-皮肤微调  21-按键定义
  toolbarButtons: [ 17, 2, 3, 9, 5, 1, 11 ],


  # toolbar 按钮以图标显示
  # true 显示图标，false 显示文字
  toolbarPreferIcon: true,


  # 主题色
  # 0-无  1-红色  2-绿色  3-橙色  4-蓝色
  accentColor: 1,


  # 中文模式下，字母键是否大写显示
  # true 大写，false 小写
  uppercaseForChinese: true,


  # 分词键，用于输入方案中分词使用
  segmentAction:
    { character: '`'},
    # 'tab',
    # { character: "'"},


  # 逗号左侧的功能键
  showFunctionButton: false,
  functionButtonParams: {
    action: { shortcut: '#selectText' },
    systemImageName: 'selection.pin.in.out',

    whenKeyboardAction: [
      {
        notificationKeyboardAction: {
          shortcut: '#selectText'
        },
        action: { shortcut: '#cut' },
        systemImageName: 'scissors',
      },
    ],
  },


  # 数字键盘的符号是否经过 rime 处理
  # true 经过 rime 处理，false 直接输入符号
  numericSymbolsUseRime: false,

}
