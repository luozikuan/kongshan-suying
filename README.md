## 「空山素影」皮肤特点
- 支持多种键盘布局，包括 26 键、9键、14键、17键、18键、注音键盘、[西戈拼音](https://www.bilibili.com/video/BV1aipxzPEj5/?t=705.3)等布局。
- 数字键盘布局包括九宫格、全键盘、16进制等布局。
- 不包含图片资源，风格接近原生键盘。
- 工具栏滑动按钮自定义，方便快速对工具栏进行个性化设置，且可以设置为纯文本工具栏。
- 空格键显示当前输入方案名称，方便查看当前输入方案。
- 中文模式下字母键大写显示，英文模式下字母键小写显示，是中文还是英文一目了然。
- shift 键在打字过程中充当“分词”功能（分词功能为输入单引号，可以在“微调”中调整为其它符号）。
- 支持按键上下划动功能，26键盘布局可以输入 PC 键盘上的所有符号，可快速设置是否显示划动提示文字。
- a,z,x,c,v 五个按键下划对应全选、撤销、剪切、复制、粘贴，与 PC 键盘习惯一致。
- 按键支持特定的自定义语法，可以非常简单地实现各种按键功能。
- 主题色可选，满足不同用户的审美需求。
- 可以使用浮动面板中的“微调”功能对皮肤进行快速调整。

## 上下划动功能说明
```
1234567890 上划功能
qwertyuiop 按键
       |<> 下划功能，q下划输入Tab

!^/;(-#{" 上划功能
asdfghjkl 按键
 `\:)_+}' 下划功能，a全选

@*%=[&? 上划功能
zxcvbnm 按键
    ]~$ 下划功能，z撤销、x剪切、c复制、v粘贴

backspace 上划清空文本，下划撤销
123 上划切换符号键盘，下划切换 emoji 键盘
逗号 上划输入句号
中/En 上划切换方案
enter 上划行首，下划行尾，长按换行
```

## 自定义皮肤调整说明

- 皮肤的基本设置`jsonnet/Settings.libsonnet`
  + 浮动键盘中的“微调”可以直接打开该文件进行编辑。
  + 修改后保存，重新编译皮肤即可生效。

- 键盘按键功能设置`jsonnet/Buttons/`
  + 浮动键盘中的“按键”会打开`jsonnet/Buttons/`文件夹下的 README.md，方便查看各按键在哪个文件
  + 退出 README.md 后再打开同目录下的具体按键文件进行编辑。
  + 修改后保存，重新编译皮肤即可生效。

## 手机端编译

长按皮肤，选择「运行 main.jsonnet」

## PC 端编译

PC 端编译时需要安装 `jsonnet` 等命令行工具。

```shell
# windows
jsonnet -S -m . --tla-code debug=true .\jsonnet\main.jsonnet

# linux/macOS
jsonnet -S -m . --tla-code debug=true ./jsonnet/main.jsonnet
```

## github 仓库地址
- [空山素影](https://github.com/luozikuan/kongshan-suying)
- [最新版本发布地址](https://github.com/luozikuan/kongshan-suying/releases/latest)
- [配套测试方案](https://github.com/luozikuan/rime-tailor)
