#======================================
# 此文件用于微调皮肤设置。
# 可根据需要修改下方内容，调整皮肤的相关参数。
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#======================================
{
  # 主键盘布局选择，可选值如下：
  # 26 : 常规26键布局
  # 26b: 左移26键布局(zxcvbnm行左移半格)
  # 9  : 拼音9键布局
  # 14 : 14键布局（双键布局）
  # 17 : 17键布局
  # 18 : 18键布局
  # bopomofo : 注音佈局
  # sigma : 西戈拼音布局
  keyboardLayout: '26',


  # 数字键盘布局选择，可选值如下：
  # 9 : 九宫格布局
  # row : 数字显示在一行
  # hex : 十六进制布局
  numericLayout: '9',


  # 符号键盘布局选择，可选值如下：
  # default : 元书自带的符号键盘
  # row : 行式符号布局
  # classified : 分类符号布局
  symbolicLayout: 'default',


  # 输入时空格键上的内容，支持固定内容和变量
  # 注意：bopomofo 佈局下此項不生效，因為空格鍵打字中用於選聲調（一聲）
  # 变量可选如下：
  # $rimePreedit：Rime 预编辑文本
  # $rimeCandidate：Rime 首个候选字
  # $rimeCandidateComment: Rime 首个候选字的 comment 信息
  spaceButtonComposingText: '选定',


  # 是否为 iPad 设备，目前仅用于调整高度
  # true 是 iPad，false 是 iPhone
  iPad: false,


  # 空格键方案名称显示位置
  # x, y 取值范围为 [0, 1]
  # x 值越小越靠左，y 值越小越靠上
  # 特殊值 null 表示不显示方案名称
  spaceButtonSchemaNameCenter:
    { x: 0.2, y: 0.7 }, # 左下角
    # { x: 0.5, y: 0.5 }, # 中间
    # null,               # 不显示


  # 上下滑动提示文字显示位置
  # hide      🙈不显示
  # topLeft   ↖️左上角
  # top       ⬆️正上方
  # topRight  ↗️右上角
  # bottomLeft   ↙️左下角
  # bottom       ⬇️正下方
  # bottomRight  ↘️右下角
  swipeUpTextCenter: 'top',
  swipeDownTextCenter: 'hide',


  # toolbar 按钮配置
  # 注意第一个和最后一个按键是固定的，不可配置
  # 按钮代号列表如下：
  # 【元书相关】
  # 1-脚本  2-常用语  3-剪贴板
  # 4-皮肤  5-文件管理器  6-方案切换
  # 7-数字键盘  8-符号键盘  9-表情键盘
  # 10-查看性能  11-左手模式  12-右手模式
  # 【Rime 相关】
  # 13-Rime同步  14-Rime部署  15-方案管理
  # 16-快符  17-RimeSwitcher
  # 【皮肤相关】
  # 18-皮肤微调  19-按键功能定义
  # 【文本编辑相关】
  # 20-全选  21-复制  22-剪切
  # 23-粘贴  24-撤销  25-重做
  # 26-左移  27-右移
  #
  # 将上述代号填入下面的数组即可
  toolbarSlideButtons: [ 8, 17, 1, 2, 3, 10, 12 ],

  # 滑动按钮区域占几个按键宽度
  toolbarSlideButtonsMaxCount: {
    portrait: 5,   # 竖屏
    landscape: 8,  # 横屏
  },


  # 同时配了图标和文字的，优先显示图标还是文字
  # true 显示图标，false 显示文字
  preferIcon: true,


  # 主题色
  # 0-无  1-红色  2-绿色  3-橙色  4-蓝色  5-紫色
  accentColor: 4,


  # 中文模式下，字母键是否大写显示
  # 注意：17键布局、注音佈局、西戈码布局下此设置无效
  # true 大写，false 小写
  uppercaseForChinese: true,


  # shiftButton 的功能定义
  shiftButtonParams: {
    systemImageName: 'shift',
    action: 'shift',

    uppercased: { systemImageName: 'shift.fill', },
    capsLocked: { systemImageName: 'capslock.fill', },

    whenPreeditChanged: {
      action: { character: "'" },
      systemImageName: 'square.and.line.vertical.and.square',
      text: '分词',

      # action: 'tab',
      # systemImageName: 'arrow.right.to.line',
      # text: 'Tab',
    },
  },


  # Rime 方案中的快符
  quickAction:
    { character: ';' },
    # { character: '/' },

}
