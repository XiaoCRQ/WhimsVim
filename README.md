![image](https://raw.githubusercontent.com/xiaoCRQ/WhimsVim/main/img/dashboard.png)

✨ WhimsVim 是由 [💤 lazy.nvim](https://github.com/folke/lazy.nvim) 驱动并基于[💤 lazyvim](https://github.com/LazyVim/LazyVim)的一套个性化 Neovim 配置，可以轻松自定义和扩展您的配置。
不必在从头开始或使用预制发行版之间做选择

## 🌟 特性

- 🔥 将你的 Neovim 变成一个成熟的 IDE
- 💤 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 轻松自定义和扩展您的配置
- 📦 预配置了大量插件，随时可用
- 🧹 优秀的美化
- 🚀 快如闪电

## ⚡️ 要求

- Neovim >= **0.9.0** (需要用 **LuaJIT** 构建)
- Git >= **2.19.0** (用于部分克隆支持)
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体 **_(可选)_**
- 安装 [chafa](https://github.com/hpjansson/chafa) 终端播放器 **_(可选-用于仪表盘动画)_**
- 拥有 powershell 终端 **_(可选-用于仪表盘动画)_**
- [C/C++ 编译器](https://winlibs.com/) **(可选)**

## 🚀 入门

您可以在 [此处](https://github.com/XiaoCRQ/WhimsVim/tree/config#) 找到 **VhimsVim** 的入门模板,
操作详解的 [Wiki](https://github.com/xiaoCRQ/WhimsVim/wiki)

<details ><summary > Windows </summary>

- 克隆

  ```sh
  # cmd
  git clone --branch config --single-branch https://github.com/XiaoCRQ/WhimsVim.git %USERPROFILE%\AppData\Local\nvim

  # powershell
  git clone --branch config --single-branch https://github.com/XiaoCRQ/WhimsVim.git $env:LOCALAPPDATA\nvim
  ```

- 删除 `.git` 文件夹，以便稍后将其添加到您自己的存储库

  ```sh
  # cmd
  rmdir /s  %USERPROFILE%\AppData\Local\nvim\.git

  # powershell
  Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
  ```

- 启动 Neovim!

  ```sh
  nvim
  ```

</details>

<details><summary > Linux/MacOS  </summary>

- 克隆

  ```sh
  git clone --branch config --single-branch https://github.com/XiaoCRQ/WhimsVim.git ~/.config/nvim
  ```

- 删除 `.git` 文件夹，以便稍后将其添加到您自己的存储库

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- 启动 Neovim!

  ```sh
  nvim
  ```

</details>

---

## 🗑️ 卸载

<details ><summary > Windows </summary>

```sh
# cmd
rmdir /s  %USERPROFILE%\AppData\Local\nvim
rmdir /s  %USERPROFILE%\AppData\Local\nvim-data

# powershell
Remove-Item -Path "$env:LOCALAPPDATA\nvim" -Recurse -Force
Remove-Item -Path "$env:LOCALAPPDATA\nvim-data" -Recurse -Force
```

</details>

<details><summary > Linux/MacOS </summary>

```sh
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

</details>

---

## 📂 文件结构

config 下的文件会在适当的时候自动加载，所以你不需要手动引入这些文件。
**WhimsVim** 带有一组默认配置文件，这些文件将在您的配置**之前**加载。

您可以在 `lua/plugins/` 下添加自定义插件配置(specs)。
[lazy.nvim](https://github.com/folke/lazy.nvim) 会自动加载这些文件。

<pre>
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   │   └── **
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.lua
</pre>

## ⚙️ Configuration
