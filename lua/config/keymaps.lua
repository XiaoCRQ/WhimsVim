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
