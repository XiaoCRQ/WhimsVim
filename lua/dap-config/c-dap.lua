local dap = require("dap")
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    -- command = "/absolute/path/to/codelldb/extension/adapter/codelldb",
    -- vim.fn.stdpath("data") 为nvim-data路径
    command = vim.fn.stdpath("data") .. "\\mason\\packages\\codelldb\\extension\\adapter\\codelldb",
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

-- 配置 C++ 的调试
dap.configurations.cpp = {
  {
    name = "runfile",
    type = "codelldb",
    request = "launch",

    -- 获取可执行文件路径
    program = function()
      local output
      if file_output then
        output = "/output/"
      else
        output = "/"
      end
      -- 构建可执行文件的路径
      -- return vim.fn.expand("%:p:h") .. "/output/" .. vim.fn.fnamemodify(vim.fn.expand("%:p"), ":t")
      return vim.fn.expand("%:p:h") .. output .. vim.fn.fnamemodify(vim.fn.expand("%:p"), ":t:r")
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,

    -- 设置调试参数
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- 将 C、Chead、Rust 的调试配置设置为与 C++ 相同
dap.configurations.c = dap.configurations.cpp
dap.configurations.h = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
