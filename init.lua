is_windows = vim.loop.os_uname().sysname == "Windows_NT"
CF_PATH = "~/Work/Program/CodeForces"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.competitest_keymaps")
require("config.neovide")
require("config.function")
require("lsp.init")
require("dap-config.init")

-- vim.opt.shell = "powershell.exe"
-- vim.opt.shellcmdflag = "-NoProfile"
vim.o.swapfile = false -- 关闭 打开文件询问

vim.o.fileencodings = "ucs-bom,utf-8,gbk,default,latin1"
vim.o.fileencoding = is_windows and "gbk" or "utf-8"

vim.cmd([[
  highlight StatusColumnLineNumber guibg=#1e1e2e
  highlight StatusColumnSign       guibg=#1e1e2e
  highlight StatusColumnSeparator  guibg=#1e1e2e
]])
