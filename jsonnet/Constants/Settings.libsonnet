{
  // 是否使用类似 PC 键盘的布局（ZXCVBNM 这一行向左移半个键位宽度）
  // true 左移半格，false 不左移
  usePCLayout: true,

  // 是否在空格键上显示方案名称
  // true 显示方案名称，false 不显示
  spaceButtonShowSchema: true,

  // 方案名称在空格键上的位置，有的方案名称较长，需要调整 x 值以免超出按键
  spaceButtonSchemaNameCenter: { x: 0.2, y: 0.2 },

  // 是否显示上下滑动提示
  // true 显示，false 不显示
  showSwipeUpText: true,
  showSwipeDownText: false,

  // toolbar 按钮列表，最多显示 5 个，其它滑动展示
  // 注意键盘上第一个永远是菜单按钮，最后一个永远是收起按钮，不可配置
  toolbarButtons: [
    'PerformanceButton', // 查看性能
    'RimeSwitcherButton', // 切换方案
    'ScriptButton', // 脚本
    'PhraseButton', // 常用语
    'ClipboardButton', // 剪贴板
    'CheckUpdateButton', // 应用商店中检查元书更新
    'FeedbackButton', // 声音和震动
    'FinderButton', // 打开元书文件管理器
    'SkinButton', // 皮肤
    'UploadButton', // WIFI 文件传输
    'DeployButton', // Rime部署
    'ToggleEmbeddedButton', // 内嵌开关
    'LeftHandButton', // 左手模式
    'RightHandButton', // 右手模式
  ],

}
