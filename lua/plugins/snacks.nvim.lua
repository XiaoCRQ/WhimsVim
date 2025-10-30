return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    statuscolumn = {},
    terminal = {
      -- 窗口样式：float | split | bottom（默认 "bottom"）
      win = { style = "float" },

      -- 使用的 shell，支持字符串或字符串数组；默认为 vim.o.shell
      shell = vim.o.shell,
      -- shell = "/usr/bin/fish",

      -- 如果要用自定义终端（比如 termopen 以外），可以 override
      -- override = function(cmd, opts) end,

      -- 启动时即进入插入模式
      start_insert = true,
      -- 进入终端缓冲区后自动插入
      auto_insert = true,
      -- 退出后自动关闭
      auto_close = true,
      -- 交互快捷：等于同时开启上面三项
      interactive = true,

      -- 工作目录
      cwd = vim.fn.getcwd(),
      -- 环境变量
      env = { FOO = "bar" },

      -- 窗口大小：split/bottom 时表示高度，float 时表示百分比
      size = {
        -- bottom split 高度 15 行
        height = 15,
        -- float 宽高百分比
        width = 0.8,
        height = 0.8,
      },

      -- 浮动窗边框
      border = "rounded", -- single | double | rounded | solid | shadow

      -- 自定义 keymaps
      keys = {
        -- 双按 <Esc> 退出插入
        term_normal = {
          "<esc>",
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd("stopinsert")
            else
              self.esc_timer:start(200, 0, function() end)
              return "<esc>"
            end
          end,
          mode = "t",
          expr = true,
          desc = "Double esc to Normal",
        },
        -- q 隐藏终端
        q = "hide",
        -- gf 打开光标下文件
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
          if f == "" then
            Snacks.notify.warn("No file under cursor")
          else
            self:hide()
            vim.schedule(function()
              vim.cmd("e " .. f)
            end)
          end
        end,
      },

      -- buffer & window local 设置
      bo = { filetype = "snacks_terminal" },
      wo = {},
    },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "l", desc = "LeetCode", action = ":Leet" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
 ██╗  ██╗██╗ █████╗  ██████╗  ██████╗██████╗  ██████╗
 ╚██╗██╔╝██║██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔═══██╗
  ╚███╔╝ ██║███████║██║   ██║██║     ██████╔╝██║   ██║
  ██╔██╗ ██║██╔══██║██║   ██║██║     ██╔══██╗██║▄▄ ██║
 ██╔╝ ██╗██║██║  ██║╚██████╔╝╚██████╗██║  ██║╚██████╔╝
 ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝ ╚══██═╝]],
      },

      sections = {
        {
          section = "terminal",
          -- cmd = "chafa -c full --fg-only --symbols solid --align=mid "
          cmd = "chafa --format=symbols -c full --symbols solid --align=mid --clear --probe off " .. vim.fn.stdpath(
            "config"
          ) .. "/lua/logo/v-3.gif",
          -- cmd = "",
          height = 18,
          padding = 1,
        },
        {
          pane = 2,
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
