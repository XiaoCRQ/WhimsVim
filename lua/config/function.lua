function Complete_semicolon()
  local filetype = vim.bo.filetype
  if filetype == "c" or filetype == "cpp" then
    local current_line = vim.fn.getline(".")
    local modified_line = current_line .. ";"
    vim.fn.setline(".", modified_line)
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

-- //———————————— 调试函数 ————————————//
local isMarkdownPreviewActive = false -- 判断markdown是否打开

function c_compiler(filetype)
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

  output_dir = base_path .. sep .. "Output"

  if vim.fn.isdirectory(output_dir) == 0 then
    vim.fn.mkdir(output_dir, "p")
    print("已创建输出文件夹")
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
  cmd = cmd .. " -O2 -Wall " .. ' "' .. source_path .. '" -o "' .. output_path .. '"'
  return cmd
end

function c_debug(filetype)
  -- 异步启动编译任务
  local job_id = vim.fn.jobstart(c_compiler(filetype), {
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

function debug_by_filetype()
  local filetype = vim.bo.filetype
  if filetype == "c" or filetype == "cpp" then
    c_debug(filetype)
  end
end
