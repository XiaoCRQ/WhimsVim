-- 快捷切换编码
function encod(pattern)
  if pattern == "u" then
    vim.cmd("e ++enc=utf-8")
    vim.cmd("set fileencoding=utf-8")
    print("当前编码")
    print(" UTF-8")
  elseif pattern == "g" then
    vim.cmd("e ++enc=gbk")
    vim.cmd("set fileencoding=gbk")
    print("当前编码")
    print("  GBK")
  elseif pattern == "gb" then
    vim.cmd("e ++enc=gb2312")
    vim.cmd("set fileencoding=gb2312")
    print("当前编码")
    print("  GB2312")
  elseif pattern == "bg" then
    vim.cmd("e ++enc=big5")
    vim.cmd("set fileencoding=big5")
    print("当前编码")
    print("  Big25[港澳台]")
  elseif pattern == "i" then
    vim.cmd("e ++enc=latin1")
    vim.cmd("set fileencoding=latin1")
    print("当前编码")
    print("  ISO-8859-1")
  elseif pattern == "help" or pattern == "h" then
    print("支持编码如下")
    print(" -u  UTF-8")
    print(" -i  ISO-8859-1")
    print(" -g  GBK")
    print(" -gb GB2312")
    print(" -bg Big25[港澳台]")
    print(" -...")
    print("[config.function 自定义]")
  else
    print("error")
  end
end

-- 切换显示字体大小
local font_size_temp = is_windows and 22 or 14

function fontsize(font_size)
  if font_size >= 1 and font_size <= 50 then
    local str = "当前字体大小: " .. font_size .. " px"
    -- vim.o.guifont = "CaskaydiaCove Nerd Font:h" .. font_size .. ":b"
    vim.o.guifont = "CaskaydiaCove Nerd Font:h" .. font_size
    print(str)
  elseif font_size < 1 then
    font_size_temp = 1
    print("字体过小")
  elseif font_size > 20 then
    font_size_temp = 50
    print("字体过大")
  end
end

function font(str)
  if str == "-" then
    font_size_temp = font_size_temp - 1
    fontsize(font_size_temp)
  elseif str == "+" then
    font_size_temp = font_size_temp + 1
    fontsize(font_size_temp)
  else
    print("error")
  end
end

-- 加载配置文件
function load_config(cmd)
  if cmd == "help" then
    print("输入格式:文件夹.文件")
    print("    例如:config.lazy")
    print("    例如:dap-config.init")
  else
    require(cmd)
    print(cmd .. "已加载")
  end
end

-- 切换配色主题
-- function colorscheme_config() end

-- //———————————— 调试函数 ————————————//
local isMarkdownPreviewActive = false -- 判断markdown是否打开

function file_output_switch()
  if file_output == false then
    print("-已开启output输出-")
    file_output = true
  elseif file_output == true then
    print("-已关闭output输出-")
    file_output = false
  else
    print("-参数错误-")
  end
end

function c_debug(filetype)
  print("开始调试")
  vim.cmd("w!") -- 保存当前文件

  local sep = is_windows and "\\" or "/"
  local exe_ext = is_windows and ".exe" or ""

  local cmd = ""
  local output_dir
  local output_path
  local base_path = vim.fn.expand("%:p:h")
  local filename_noext = vim.fn.expand("%:t:r")
  local source_path = vim.fn.expand("%:p")

  if file_output then
    output_dir = base_path .. sep .. "output"
    -- 检查并创建 output 文件夹
    if vim.fn.isdirectory(output_dir) == 0 then
      vim.fn.mkdir(output_dir, "p")
      print("已创建输出文件夹")
    end
  else
    output_dir = base_path
  end

  output_path = output_dir .. sep .. filename_noext .. exe_ext

  if filetype == "c" then
    cmd = "gcc"
  elseif filetype == "cpp" then
    cmd = "g++"
  else
    print("错误: 不支持的文件类型!")
    return
  end

  -- 最终构建命令
  cmd = cmd .. ' "' .. source_path .. '" -o "' .. output_path .. '"'

  -- 异步启动编译任务
  local job_id = vim.fn.jobstart(cmd, {
    on_exit = function(_, return_val, _)
      if return_val == 0 then
        print("编译完成")
        require("dap").continue()
      else
        print("编译失败，错误码: " .. return_val)
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

function html_debug(filetype)
  -- 保存当前打开的文档
  vim.cmd("w!")
  -- 获取当前文件的完整路径
  local current_file = vim.fn.expand("%:p")
  -- 获取当前文件所在的目录
  local current_dir = vim.fn.expand("%:p:h")
  -- 切换工作目录到当前文件所在目录
  vim.fn.chdir(current_dir)
  vim.cmd("ToggleTerm")
  print("live-server or server 开启服务器")
  print("server file - 指定文件打开")
end

function python_debug(filetype)
  print("未配置")
end

function markdown_debug(filetype)
  if isMarkdownPreviewActive then
    vim.cmd("MarkdownPreviewStop")
    isMarkdownPreviewActive = false
    print("已关闭MarkdownPreview")
  else
    vim.cmd("MarkdownPreview")
    isMarkdownPreviewActive = true
    print("已开启MarkdownPreview")
  end
end

function debug_by_filetype()
  local filetype = vim.bo.filetype
  if filetype == "c" or filetype == "cpp" then
    c_debug(filetype)
  elseif filetype == "html" then
    html_debug(filetype)
  elseif filetype == "python" then
    python_debug(filetype)
  elseif filetype == "markdown" then
    markdown_debug(filetype)
  else
    vim.cmd("ToggleTerm")
  end
end

local conti_dap = 1
local dapui = require("dapui")

function dap_default()
  dapui.close("console") -- 控制台
  dapui.close("watches")
  dapui.close("stacks")
  dapui.close("scopes")
  dapui.close("breakpoints")
  dapui.close("repl")
end

function window_dap()
  conti_dap = conti_dap + 1
  if conti_dap == 1 then
    require("windows.no1")
    print("已设置dap布局")
    print("no.1 控制台 右50%")
  elseif conti_dap == 2 then
    require("windows.no2")
    print("已设置dap布局")
    print("no.2 控制台 右30%")
    print("     三元素 下30%")
  elseif conti_dap == 3 then
    require("windows.no3")
    print("已设置dap布局")
    print("no.3 控制台 下30%")
    print("     三元素 右30%")
  elseif conti_dap == 4 then
    require("windows.no4")
    print("已设置dap布局")
    print("no.4 插件默认")
    conti_dap = 0
  else
    print("error")
    conti_dap = 0
  end
end

function window_conti(conti)
  conti_dap = conti - 1
  window_dap()
end

function window_dap_help()
  print("<F3> 更改dap调试窗口")
  print("     1-4 窗口布局")
  print("     0 默认布局")
  print("               ")
  print("ALT + [- or +] 控制台大小")
end

local window_size = 0.6

function windowsize()
  dapui.setup({
    layouts = { -- 布局
      {
        elements = {
          "console", -- 控制台
        },
        size = window_size,
        position = "right", -- 位置：右侧
      },
    },
  })
end

function window_dap_add(cmd)
  if cmd == "-" then
    window_size = window_size - 0.02
  elseif cmd == "+" then
    window_size = window_size + 0.02
  else
    print("error")
    return 0
  end
  if window_size < 0.2 then
    print("MIN !")
    window_size = 0.2
  elseif window_size > 0.98 then
    print("MAX !")
    window_size = 0.98
  end
  print("当前调试窗口占比 " .. window_size * 100 .. "%")
  windowsize()
end

-- //———————————— 调试函数 ————————————//

function test_user() end
