按键修改说明
----------------

本文件是对键盘按键功能进行自定义修改的说明。

键盘按键功能设置位于 `jsonnet/Buttons/` 文件夹下。
各文件及包含的按键对应如下：
- README.md：本说明文件。
- Common：一些通用按键功能，例如shift, space, enter 等。
- Layout9: 九宫格键盘。
- Layout14: 14键布局。
- Layout17：17键布局。
- Layout18：18键布局。
- Layout26：26 键中文和英文键盘。
- LayoutNumeric：数字键盘。
- LayoutBopomofo：注音键盘。
- Toolbar：工具栏和浮动面板中的按键。

按键的具体配置语法可以参考后面的「按键语法说明」部分。

修改步骤：
1. 关闭本 README.md 文件。
2. 打开同一文件夹下需要修改的按键文件，例如 `Layout26.libsonnet`。
3. 根据需要修改对应按键的功能配置，修改完后保存文件。
4. 回到元书皮肤界面，长按皮肤，选择「运行 main.jsonnet」生效。


-----------------
以下是按键语法说明


## 声明
「空山素影」皮肤并未直接使用元书官方提供的部分关键字，而是扩展了一套按键语法，以支持用更简单的方式来定义按键行为。

以下描述的扩展语法仅在「空山素影」皮肤中有效，其他皮肤可能无法使用此语法。

## 按键语法说明
一个常规的按键定义如下：

```jsonnet
aButton: {
  name: 'aButton',
  params: {
    action: { character: 'a' },

    uppercased: {
      action: { character: 'A' }
    },

    swipeUp: {
      action: { character: '!' }
    },

    swipeDown: {
      action: { shortcut: '#selectText' },
      text: '全'
    },

    longPress: [
      {
        action: { shortcut: '#左手模式' },
        systemImageName: 'keyboard.onehanded.left'
      },
    ],
  },
},
```


### uppercased 大写配置、swipeUp，swipeDown 上下划动配置

其中 `uppercased`, `swipeUp` 和 `swipeDown` 中可以配置新的 action，在指定情况下覆盖默认的按键行为，例如`swipeUp: { action: { character: '!' } },` 会将上划动作设置为`!`，并且将上划字符显示在合适的位置。

前景显示会通过 action 自动推导，对于无法推导的情况，可以手动添加 `text` 或 `systemImageName` 来指定显示内容，例如下划的 `#selectText` 无法推导，就指定了 `text: '全'`。


### longPress 长按列表
`longPress` 是按键长按菜单的配置，它是一个列表，可以添加多个菜单项。如果需要指定初始选中项，可以在希望的菜单项中添加 `selected: true`，如果没有指定 `selected: true`，则默认选择中间（奇数）或中间靠右（偶数）的菜单项。例如:
```jsonnet
pButton: {
  name: 'pButton',
  params: {
    action: { character: 'p' },

    longPress: [
      {
        action: { character: 'p' },
      },
      {
        action: { character: '0' },
      },
      {
        action: { character: 'P' },
        selected: true,  # 初始选中项
      },
    ],
  },
},
```

### capsLocked 大写锁定状态配置
还可以对 `capsLocked` 状态进行单独配置，其中可以指定 action、text 或 systemImageName 覆盖默认状态的值，以 shiftButton 为例：

```jsonnet
shiftButton: {
  name: 'shiftButton',
  params: {
    systemImageName: 'shift',
    action: 'shift',

    uppercased: { systemImageName: 'shift.fill', },

    # 大写锁定状态下显示的图标
    capsLocked: { systemImageName: 'capslock.fill', },
  },
},
```

### whenAlphabetic 当切换到英文键盘时的配置
注意此选项只能在两个场景使用：
1. 26 键布局的按键中使用，这些按键大部分位于 `jsonnet/Buttons/Layout26.libsonnet` 文件中，少部分位于 `jsonnet/Buttons/Common.libsonnet` 文件中。
2. 英文键盘切到行式数字键盘(row)时使用，这些按键位于 `jsonnet/Buttons/LayoutNumeric.libsonnet` 文件中。

`whenAlphabetic` 可以用来配置按键在切换到英文键盘（或英文行式数字键盘）时的显示和行为，例如逗号键，在中文键盘下显示中文逗号，在英文键盘下显示英文逗号，写法如下：

```jsonnet
commaButton: {
  name: 'commaButton',
  params: {
    action: { character: ',', },
    text: '，',
    center: { y: 0.52 },

    swipeUp: {
      action: { character: '.' },
      text: '。',
      center: { y: 0.3 }
    },

    whenAlphabetic: {
      text: ',', center: { y: 0.48 },
      swipeUp: { text: '.', center: { y: 0.28 } },
    }
  },
},
```

货币符号，在行式数字键盘下显示为￥，在英文键盘下显示为$，配置如下：

```jsonnet
// 货币符号
moneyButton: {
  name: 'moneyButton',
  params: {
    action: { character: '$' },
    text: '¥',

    whenAlphabetic: {
      text: '$',
    },
  },
},
```

### whenPreeditChanged 当预编辑文本变化时的配置
`whenPreeditChanged` 可以用来配置按键在有预编辑文本时的显示和行为，例如左下角的 123 按键，没打字时功能为切换数字键盘，有预编辑文本时功能为分词键，写法如下：

```jsonnet
numericButton: {
  name: 'numericButton',
  params: {
    action: { keyboardType: 'numeric' },
    text: '123',

    whenPreeditChanged: {
      action: { character: "'" },  # 假设分词键是单引号
      text: '分词',
    },
  },
},
```
因为不想使用推导出的 `'` 作为按键显示，所以手动指定了 `text` 为“分词”。

### whenKeyboardAction 当监听到某个键盘动作时的配置
`whenKeyboardAction` 可以用来配置按键在监听到某个键盘动作时，当前按键应该变成什么样子。举例来说，如果空格左边放一个功能键，功能为“全选”，当执行“全选”后，想让该按键变成“剪切”，这样就可以双击此按钮来实现“全选”加“剪切”，配置可以这样写：

```jsonnet
functionButton: {
  name: 'functionButton',
  params: {
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
},
```
上面的配置表示，当监听到“全选”动作时，按键变成“剪切”功能，并且图标变成剪刀图标。当“剪切”动作执行后，按键会自动恢复回“全选”功能。

如果想让按键在监听到某个动作后变成另一个动作，并且锁定这个新动作，可以添加 `lockedNotificationMatchState: true` 属性，例如：

```jsonnet
functionButton: {
  name: 'functionButton',
  params: {
    action: { shortcut: '#selectText' },
    systemImageName: 'selection.pin.in.out',

    whenKeyboardAction: [
      {
        notificationKeyboardAction: {
          shortcut: '#selectText'
        },
        action: { shortcut: '#cut' },
        systemImageName: 'scissors',

        # 变成剪切后就一直是剪切，不会自动恢复回全选
        lockedNotificationMatchState: true,
      },
    ],
  },
},
```

### whenRimeOptionChanged 当 Rime 选项打开或关闭时的配置

注意：应该将 rime option 的默认值相关的配置放在 params 中，将 option 变化后的相关配置放在 params.whenRimeOptionChanged 中。

以字母键 b 为例，如果我们想让它在中文模式下显示为大写，英文模式下显示为小写，则可以写出如下配置：

```jsonnet
bButton: {
  name: 'bButton',
  params: {
    action: { character: 'b' },
    text: 'B',

    whenRimeOptionChanged: {
      optionName: 'ascii_mode',
      optionValue: true,
      text: 'b',
    },
  },
},
```
ascii_mode 默认是关闭(false)，手动切换后变为 true。上面的 params 配置表示，当 ascii_mode 关闭时（即中文模式），显示为大写 B；whenRimeOptionChanged 中的配置表示，当 ascii_mode 打开时（即英文模式），将 text 设置为小写 b。

whenRimeOptionChanged 还可以对 swipeUp / swipeDown 等进行重新配置，例如逗号键，在中文模式和英文模式下，显示有差异，如做如下配置：

```jsonnet
commaButton: {
  name: 'commaButton',
  params: {
    action: { character: ',', },
    text: '，',
    center: { y: 0.52 },

    swipeUp: {
      action: { character: '.' },
      text: '。',
      center: { y: 0.3 }
    },

    whenRimeOptionChanged: {
      optionName: 'ascii_mode',
      optionValue: true,
      text: ',', center: { y: 0.48 },
      swipeUp: { text: '.', center: { y: 0.28 } },
    }
  },
},
```
解释：whenRimeOptionChanged 中的配置会覆盖默认的 action 和 swipeUp 配置，从而在中文模式下显示中文逗号和句号，而在 rime option ascii_mode 变为 true 时（英文模式下）会由 whenRimeOptionChanged 中指定的内容更改为显示英文逗号和句号。

如果有需要，也可以在 whenRimeOptionChanged 中对 action / swipeUp.action / swipeDown.action 进行重新配置。比如，如果想让逗号键在中文模式上划输入句号，但在英文模式下直接输入句号，上划输入逗号，则可以这样写：

```jsonnet
commaButton: {
  name: 'commaButton',
  params: {
    # 中文模式输入为逗号
    action: { character: ',', },
    text: '，',
    center: { y: 0.52 },

    # 中文模式上划输入句号
    swipeUp: {
      action: { character: '.' },
      text: '。',
      center: { y: 0.3 }
    },

    whenRimeOptionChanged: {
      # 英文模式下
      optionName: 'ascii_mode',
      optionValue: true,

      # 英文模式输入为句号
      action: { character: '.', },
      text: '.', center: { y: 0.48 },

      # 英文模式上划输入逗号
      swipeUp: {
        action: { character: ',', },
        text: ',',
        center: { y: 0.28 }
      },
    }
  },
},
```
