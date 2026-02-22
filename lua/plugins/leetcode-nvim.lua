local map = vim.keymap.set
local opt = { noremap = true, silent = true }

local leet_cmds = {
  lc = "",
  lg = "lang",
  ls = "submit",
  ln = "run",
  le = "exit",
  li = "info",
  lta = "tabs",
  ly = "yank",
  ld = "daily",
  lts = "list",
  lo = "open",
  lre = "reset",
  lrt = "restore",
  lkd = "cookie delete",
  lku = "cookie update",
  lkc = "cache",
}

for k, v in pairs(leet_cmds) do
  map("n", "<leader>" .. k, ":Leet " .. v .. "<CR>", opt)
end

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- telescope 所需
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    cn = {
      enabled = true,
    },
  },
}
