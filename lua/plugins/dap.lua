local dap = require("dap")

local sep = is_windows and "\\" or "/"
local codelldb_path = vim.fn.stdpath("data")
  .. sep
  .. "mason"
  .. sep
  .. "packages"
  .. sep
  .. "codelldb"
  .. sep
  .. "extension"
  .. sep
  .. "adapter"
  .. sep
  .. "codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
    -- detached = not is_windows,  -- 可选，Linux 下保持 true
  },
}

-- 配置 C++ 的调试
dap.configurations.cpp = {
  {
    name = "runfile",
    type = "codelldb",
    request = "launch",

    program = function()
      return vim.fn.expand("%:p:h") .. "/Output/" .. vim.fn.fnamemodify(vim.fn.expand("%:p"), ":t:r")
    end,

    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.h = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      layouts = {
        {
          elements = {
            "console",
          },
          size = 0.5,
          position = "right",
        },
      },
    },
  },
}
