local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

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
