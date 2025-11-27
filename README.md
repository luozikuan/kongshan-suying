# 「空山素影」

皮肤文件通过 `Jsonnet` 语法编写，PC 端编译时需要安装 `jsonnet` 等命令行工具。主要与“空山五笔”方案配合使用。

## 使用说明

本皮肤不包含「英文键盘」，中英切换键使用 RIME 的 `ascii_mode` 切换。

上下划动功能说明如下：
```
1234567890 上划功能
qwertyuiop 按键

!^/;(-#{" 上划功能
asdfghjkl 按键
 @\:)_+}' 下划功能，a全选

`*%=[&? 上划功能
zxcvbnm 按键
    ]~$ 下划功能，z撤销、x剪切、c复制、v粘贴
```

## 自定义皮肤调整说明

- `jsonnet/Constants/Settings.libsonnet`: 定义了皮肤的基本设置

  + `usePCLayout`: 是否使用 PC 布局，启用后 zxcv 行按键左移半格。
  + `spaceButtonShowSchema`: 空格键上是否显示当前输入方案名称。
  + `spaceButtonSchemaNameCenter`: 方案名称在空格键上的位置，有的方案名称较长，需要调整 x 值以免超出按键。
  + `showSwipeUpText`: 是否显示按键的上划文字显示。
  + `showSwipeDownText`: 是否显示按键的下划文字显示。

- `jsonnet/Constants/Keyboard.libsonnet`: 定义了键盘按键，各区域高度等常量。

  + 如想对按键上下划动进行调整，可在此文件中添加或修改对应按键的 `swipeUp` 或 `swipeDown` 属性。

## 手机端编译

长按皮肤，选择「运行 main.jsonnet」

## PC 端编译

```shell
jsonnet -S -m . --tla-code debug=true .\jsonnet\main.jsonnet
```
