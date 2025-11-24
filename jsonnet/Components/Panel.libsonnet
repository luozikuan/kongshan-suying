local params = import '../Constants/Keyboard.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';


local keyboard = {

  // 浮动键盘里的按键
  hamster3Button: {
    name: 'hamster3Button',
    params: {
      action: 'settings',
      systemImageName: 'keyboard',
      text: '元书',
    },
  },

  switcherButton: {
    name: 'switcherButton',
    params: {
      action: { shortcut: '#方案切换' },
      systemImageName: 'switch.2',
      text: '方案切换'
    },
  },

  feedbackButton: {
    name: 'feedbackButton',
    params: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/feedback' },
      systemImageName: 'iphone.radiowaves.left.and.right',
      text: '按键震动',
    },
  },

  finderButton: {
    name: 'finderButton',
    params: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
      systemImageName: 'folder',
      text: '文件管理',
    },
  },

  skinButton: {
    name: 'skinButton',
    params: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
      systemImageName: 'tshirt',
      text: '键盘皮肤',
    },
  },

  uploadButton: {
    name: 'uploadButton',
    params: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/wifi' },
      systemImageName: 'wifi',
      text: '无线传输',
    },
  },

  deployButton: {
    name: 'deployButton',
    params: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
      systemImageName: 'slider.horizontal.2.arrow.trianglehead.counterclockwise',
      text: 'Rime部署',
    },
  },

  toggleEmbeddedButton: {
    name: 'toggleEmbeddedButton',
    params: {
      action: { shortcut: '#toggleEmbeddedInputMode' },
      systemImageName: 'square.and.pencil',
      text: '内嵌开关',
    },
  },
};

local panelKeyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          {
            Cell: keyboard.hamster3Button.name,
          },
          {
            Cell: keyboard.switcherButton.name,
          },
          {
            Cell: keyboard.feedbackButton.name,
          },
          {
            Cell: keyboard.finderButton.name,
          },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          {
            Cell: keyboard.skinButton.name,
          },
          {
            Cell: keyboard.uploadButton.name,
          },
          {
            Cell: keyboard.deployButton.name,
          },
          {
            Cell: keyboard.toggleEmbeddedButton.name,
          }
        ],
      },
    }
  ]
};

local newKeyLayout(isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then params.floatingKeyboard.floatTargetScale.portrait else params.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: params.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName)
  }
  + panelKeyboardLayout
  + basicStyle.newFloatingKeyboardButton(
    keyboard.hamster3Button.name,
    isDark,
    keyboard.hamster3Button.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.switcherButton.name,
    isDark,
    keyboard.switcherButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.feedbackButton.name,
    isDark,
    keyboard.feedbackButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.finderButton.name,
    isDark,
    keyboard.finderButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.skinButton.name,
    isDark,
    keyboard.skinButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.uploadButton.name,
    isDark,
    keyboard.uploadButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.deployButton.name,
    isDark,
    keyboard.deployButton.params
  )
  + basicStyle.newFloatingKeyboardButton(
    keyboard.toggleEmbeddedButton.name,
    isDark,
    keyboard.toggleEmbeddedButton.params
  );

{
  new(isDark=false, isPortrait=false):
    basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
    + newKeyLayout(isDark, isPortrait)
}
