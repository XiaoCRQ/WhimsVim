-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

map("i", "jj", "<Esc>", opt)
map("n", "<C-->", ":lua font('-')<CR>", opt)
map("v", "<C-->", ":lua font('-')<CR>", opt)
map("n", "<C-=>", ":lua font('+')<CR>", opt)
map("v", "<C-=>", ":lua font('+')<CR>", opt)
map("n", "<leader>rn", ":IncRename ", opt)
map("n", ";", ":lua Complete_semicolon()<CR>", opt)

for _, mode in ipairs({ "n", "v" }) do
  map(mode, "N", "5j", opt)
  map(mode, "M", "5k", opt)
end

local normal_symbols = {
  [";;"] = ":",
  ["U"] = "<C-r>",
  ["11"] = "!",
  ["22"] = "@",
  ["33"] = "#",
  ["44"] = "$",
  ["55"] = "%",
  ["66"] = "^",
  ["77"] = "&",
  ["88"] = "*",
  ["99"] = "()<left>",
  ["00"] = ")",
}

for k, v in pairs(normal_symbols) do
  map("n", k, v, opt)
end

local shift_symbols = {
  ["11"] = "!",
  ["22"] = "@",
  ["33"] = "#",
  ["44"] = "$",
  ["55"] = "%",
  ["66"] = "^",
  ["77"] = "&",
  ["88"] = "*",
  ["99"] = "()<left>",
  ["00"] = ")",
}

for k, v in pairs(shift_symbols) do
  map("i", k, v, opt)
end

local pairs_map = {
  ["["] = "[]<left>",
  ["[["] = "{}<left>",
  [",,"] = "<",
  [",,,"] = "<><left>",
  [".."] = ">",
  ["///"] = "?",
  ["\\\\"] = "|",
}

for k, v in pairs(pairs_map) do
  map("i", k, v, opt)
end

local win_map = {
  ["<m-h>"] = "<C-w>h",
  ["<m-l>"] = "<C-w>l",
  ["<m-j>"] = "<C-w>j",
  ["<m-k>"] = "<C-w>k",
  ["<S-W>"] = ":vsp<CR>",
  ["<S-S>"] = ":sp<CR>",
}

for k, v in pairs(win_map) do
  map("n", k, v, opt)
end

local cmd_map = {
  q = ":bd<CR>",
  qq = ":q!<CR>",
  qa = ":qa!<CR>",
  qw = ":wq!<CR>",
  qwa = ":w!<CR>:qa<CR>",
  w = ":w!<CR>",
  wq = ":wq!<CR>",
  wqa = ":w!<CR>:qa<CR>",
}

for k, v in pairs(cmd_map) do
  map("n", k, v, opt)
end

function _G.set_terminal_keymaps()
  local opt = { buffer = 0 }

  map("t", "<esc>", [[<C-\><C-n>]], opt)
  map("t", "jj", [[<C-\><C-n>]], opt)

  for _, key in ipairs({ "h", "j", "k", "l" }) do
    map("t", "<C-" .. key .. ">", "<Cmd>wincmd " .. key .. "<CR>", opt)
  end

  map("t", "qq", [[<C-\><C-n><C-w>]], opt)
end

map( -- 关闭调试
  "n", -- 在普通模式下执行
  "<F4>", -- 触发的键盘快捷键
  ":lua require'dap'.close()<CR>" -- 关闭调试会话
    .. ":lua require'dap'.terminate()<CR>" -- 终止调试会话
    .. ":lua require'dap.repl'.close()<CR>" -- 关闭调试会话的 REPL
    .. ":lua require'dapui'.close()<CR>" -- 关闭调试界面
    .. ":lua require('dap').clear_breakpoints()<CR>" -- 清除断点
    .. "<C-w>o<CR>", -- 切换到其他窗口
  opt -- 使用上面定义的选项表
)
map( -- 关闭调试
  "n", -- 在普通模式下执行
  "<leader>4", -- 触发的键盘快捷键
  ":lua require'dap'.close()<CR>" -- 关闭调试会话
    .. ":lua require'dap'.terminate()<CR>" -- 终止调试会话
    .. ":lua require'dap.repl'.close()<CR>" -- 关闭调试会话的 REPL
    .. ":lua require'dapui'.close()<CR>" -- 关闭调试界面
    .. ":lua require('dap').clear_breakpoints()<CR>" -- 清除断点
    .. "<C-w>o<CR>", -- 切换到其他窗口
  opt -- 使用上面定义的选项表
)
-- 开始/继续
-- map("n", "<F5>", ":lua require'dap'.continue()<CR>", opt) -- 开始或继续调试
-- map("n", "<F5>", ":lua execute_with_cd('powershell cexe')<CR>:lua require'dap'.continue()<CR>", opt) -- 开始或继续调试[编译并调试]

-- 根据文件类型执行相应的调试功能
-- 打开调试窗口
map("n", "<F5>", ":lua debug_by_filetype()<CR>", opt)
map("n", "<leader>5", ":lua debug_by_filetype()<CR>", opt)
map("n", "<m-F5>", ":lua debug_by_filetype()<CR>", opt)

-- 设置断.点
map("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", opt) -- 切换断点状态
map("n", "<S-F6>", ":lua require'dap'.clear_breakpoints()<CR>", opt) -- 清除所有断点
--  stepOver, stepOut, stepInto
map("n", "<F8>", ":lua require'dap'.step_over()<CR>", opt) -- 单步执行
map("n", "<S-F7>", ":lua require'dap'.step_out()<CR>", opt) -- 退出当前函数
map("n", "<F7>", ":lua require'dap'.step_into()<CR>", opt) -- 进入当前函数
-- 弹窗
map("n", "<S-F8>", ":lua require'dapui'.eval()<CR>", opt) -- 在当前光标位置显示变量的值
