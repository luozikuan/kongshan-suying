{
  // 是否使用类似 PC 键盘的布局（ZXCVBNM 这一行向左移半个键位宽度）
  // true 左移半格，false 不左移
  usePCLayout: true,

  // 输入时空格键上的内容，支持固定内容和变量，变量可选如下：
  // $rimeCandidateComment 显示第一个候选词的注释
  // $rimeCandidate 显示第一个候选词
  spaceButtonComposingText: '$rimeCandidate',

  // 是否在空格键上显示方案名称
  // true 显示方案名称，false 不显示
  spaceButtonShowSchema: true,

  // 方案名称在空格键上的位置，有的方案名称较长，
  // 需要调整 x 值以免超出按键
  spaceButtonSchemaNameCenter: { x: 0.2, y: 0.7 },

  // 是否显示上下滑动提示
  // true 显示，false 不显示
  showSwipeUpText: true,
  showSwipeDownText: false,

  // toolbar 按钮最大数量（不包括菜单和收起按钮）
  toolbarButtonsMaxCount: 5,

  // toolbar 滑动按钮列表
  // 注意键盘上第一个永远是菜单按钮，最后一个永远是收起按钮，不可配置
  // 按钮代号列表，填入到后面的数组即可
  // 1-查看性能  2-RimeSwitcher  3-脚本
  // 4-常用语    5-剪贴板    6-元书检查更新
  // 7-声音和震动  8-打开元书文件管理器  9-皮肤
  // 10-WIFI 文件传输  11-Rime部署  12-内嵌开关
  // 13-左手模式  14-右手模式  15-方案切换
  // 16-数字键盘  17-符号键盘  18-表情键盘
  toolbarButtons: [ 1, 2, 3, 4, 5, 14 ],

  // 主题色
  // 0-无  1-红色  2-绿色  3-橙色  4-蓝色
  accentColor: 2,

  // 是否显示气泡
  // true 显示，false 不显示
  needHint: false,
}
