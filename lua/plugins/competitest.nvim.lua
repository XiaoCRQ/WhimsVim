return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    -- ===============================
    -- 基础路径设置
    -- ===============================
    local base_dir = vim.fn.expand(CF_PATH) -- 刷题主目录
    local template_dir = base_dir .. "/Template" -- 模板文件目录
    local output_dir = base_dir .. "/Output" -- 编译输出目录

    require("competitest").setup({
      local_config_file_name = ".competitest.lua",

      -- ===============================
      -- 浮动窗口配置
      -- ===============================
      floating_border = "rounded", -- 浮动窗口边框样式
      floating_border_highlight = "FloatBorder", -- 边框高亮颜色
      picker_ui = {
        width = 0.2,
        height = 0.3,
        mappings = {
          -- ↓ 选择界面快捷键说明 ↓
          focus_next = { "j", "<down>", "<Tab>" }, -- 下一个选项
          focus_prev = { "k", "<up>", "<S-Tab>" }, -- 上一个选项
          close = { "<esc>", "<C-c>", "q", "Q" }, -- 关闭窗口
          submit = "<cr>", -- 确认选择
        },
      },

      -- ===============================
      -- 编辑窗口配置
      -- ===============================
      editor_ui = {
        popup_width = 0.4,
        popup_height = 0.6,
        show_nu = true, -- 显示行号
        show_rnu = false, -- 不显示相对行号
        normal_mode_mappings = {
          switch_window = { "<C-h>", "<C-l>", "<C-i>" }, -- 窗口切换
          save_and_close = "<C-s>", -- 保存并关闭
          cancel = { "q", "Q" }, -- 取消/关闭
        },
        insert_mode_mappings = {
          switch_window = { "<C-h>", "<C-l>", "<C-i>" }, -- 插入模式下窗口切换
          save_and_close = "<C-s>", -- 保存并关闭
          cancel = "<C-q>", -- 取消编辑
        },
      },

      -- ===============================
      -- 运行界面配置
      -- ===============================
      runner_ui = {
        interface = "popup",
        selector_show_nu = false,
        selector_show_rnu = false,
        show_nu = true,
        show_rnu = false,
        mappings = {
          -- ↓ 运行界面快捷键说明 ↓
          run_again = "R", -- 重新运行当前测试
          run_all_again = "<C-r>", -- 运行全部测试
          kill = "K", -- 杀死当前进程
          kill_all = "<C-k>", -- 杀死所有进程
          view_input = { "i", "I" }, -- 查看输入
          view_output = { "a", "A" }, -- 查看输出
          view_stdout = { "o", "O" }, -- 查看标准输出
          view_stderr = { "e", "E" }, -- 查看错误输出
          toggle_diff = { "d", "D" }, -- 切换差异视图
          close = { "q", "Q" }, -- 关闭运行界面
        },
        viewer = {
          width = 0.5,
          height = 0.5,
          show_nu = true,
          show_rnu = false,
          open_when_compilation_fails = true, -- 编译失败时自动打开查看器
        },
      },

      -- ===============================
      -- 弹窗布局（运行结果显示区）
      -- ===============================
      popup_ui = {
        total_width = 0.9,
        total_height = 0.9,
        -- layout = {
        layout = {
          { 4, "tc" },
          { 5, { { 1, "si" }, { 1, "so" } } },
          { 5, { { 1, "se" }, { 1, "eo" } } },
        },
      },

      -- ===============================
      -- 分屏布局配置
      -- ===============================
      split_ui = {
        position = "right",
        relative_to_editor = true,
        total_width = 0.3,
        vertical_layout = {
          { 1, "tc" },
          { 1, { { 1, "so" }, { 1, "eo" } } },
          { 1, { { 1, "si" }, { 1, "se" } } },
        },
        total_height = 0.4,
        horizontal_layout = {
          { 2, "tc" },
          { 3, { { 1, "so" }, { 1, "si" } } },
          { 3, { { 1, "eo" }, { 1, "se" } } },
        },
      },

      -- ===============================
      -- 文件保存与路径配置
      -- ===============================
      save_current_file = true, -- 保存当前文件
      save_all_files = false, -- 不保存全部文件

      compile_directory = base_dir, -- 编译时工作目录
      running_directory = output_dir, -- 运行时目录（执行Output下的程序）

      -- ===============================
      -- 编译命令设置（输出至 Output 文件夹）
      -- ===============================
      compile_command = {
        c = {
          exec = "gcc",
          -- 传入绝对路径的源文件，输出到 Output 目录（绝对路径）
          args = { "-O2", "-Wall", "$(FABSPATH)", "-o", output_dir .. "/$(FNOEXT)" },
        },
        cpp = {
          exec = "g++",
          args = { "-O2", "-Wall", "$(FABSPATH)", "-o", output_dir .. "/$(FNOEXT)" },
        },
        rust = {
          exec = "rustc",
          args = { "$(FABSPATH)", "-o", output_dir .. "/$(FNOEXT)" },
        },
        java = { exec = "javac", args = { "$(FABSPATH)" } },
      },

      -- ===============================
      -- 运行命令（从 Output 文件夹中运行）
      -- ===============================
      run_command = {
        c = { exec = output_dir .. "/$(FNOEXT)" },
        cpp = { exec = output_dir .. "/$(FNOEXT)" },
        rust = { exec = output_dir .. "/$(FNOEXT)" },
        python = { exec = "python", args = { "$(FNAME)" } },
        java = { exec = "java", args = { "$(FNOEXT)" } },
      },

      -- ===============================
      -- 测试与比较逻辑
      -- ===============================
      multiple_testing = -1, -- -1 表示不限制测试用例数量
      maximum_time = 5000, -- 单个测试最大运行时间(ms)
      output_compare_method = "squish", -- 比较方式（忽略空白差异）
      view_output_diff = false, -- 不自动显示 diff

      -- ===============================
      -- 测试用例命名规则
      -- ===============================
      testcases_directory = base_dir, -- 测试用例存放位置
      testcases_use_single_file = false, -- 每个输入输出分开文件
      testcases_auto_detect_storage = true,
      testcases_single_file_format = "$(FNOEXT).testcases",
      testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
      testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",

      -- ===============================
      -- Companion 服务配置
      -- ===============================
      companion_port = 27121, -- 通信端口
      receive_print_message = true, -- 输出接收消息
      start_receiving_persistently_on_setup = false, -- 是否在 setup 时启动监听

      -- ===============================
      -- 模板配置
      -- ===============================
      template_file = template_dir .. "/template.$(FEXT)",
      evaluate_template_modifiers = true, -- 不启用模板变量替换
      date_format = "%c", -- 日期格式

      -- ===============================
      -- 接收文件路径与打开方式
      -- ===============================
      received_files_extension = "cpp",
      received_problems_path = base_dir .. "/$(PROBLEM).$(FEXT)",
      received_contests_directory = base_dir,
      received_contests_problems_path = "$(PROBLEM).$(FEXT)",
      received_problems_prompt_path = false, -- 接收时是否询问路径（false：不询问）
      received_contests_prompt_directory = false,
      received_contests_prompt_extension = false,
      open_received_problems = true,
      open_received_contests = true,
      replace_received_testcases = false,
    })
  end,
}
