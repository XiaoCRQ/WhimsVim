local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>cda", ":FOJ <CR>", vim.tbl_extend("force", opts, { desc = "FOJ：开始刷题" }))
map("n", "<leader>cdq", ":FOJ stop<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：停止刷题" }))
map("n", "<leader>cdr", ":FOJ submit<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：提交" }))
map("n", "<leader>cdt", ":FOJ run<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：判题" }))
map("n", "<leader>cdu", ":FOJ show<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：UI开关" }))
map("n", "<leader>cds", ":FOJ solve<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：问题已解决" }))
map("n", "<leader>cdS", ":FOJ solve back<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：撤销解决问题" }))
map("n", "<leader>cde", ":FOJ edit<CR>", vim.tbl_extend("force", opts, { desc = "FOJ：编辑案例" }))

return {
  {
    "xiaocrq/faster-oj.nvim",
    -- dir = "~/Work/Program/Project/faster-oj.nvim",
    opts = {
      -- debug = true,
      -- obscure = false,
      warning_msg = true,
      work_dir = vim.fn.expand(CF_PATH),
      json_dir = vim.fn.expand(CF_PATH) .. "/.problem",
      solve_dir = vim.fn.expand(CF_PATH) .. "/.solve",
      template_dir = vim.fn.expand(CF_PATH) .. "/.template",
      template_default = vim.fn.expand(CF_PATH) .. "/.template/template.cpp",
      template_default_ext = ".cpp",
      code_obfuscator = {
        result = ".obfuscator/" .. "$(FNAME)",
        cmd = {
          exec = "obfuscator_cpp",
          args = {
            "$(FABSPATH)",
            ".obfuscator/" .. "$(FNAME)",
            "-h",
            vim.fn.expand(CF_PATH) .. "/.head",
          },
        },
      },
      compile_command = {
        c = {
          exec = "gcc",
          args = { "-O2", "-Wall", "$(FABSPATH)", "-o", vim.fn.expand(CF_PATH) .. "/.output" .. "/$(FNOEXT)" },
        },
        cpp = {
          exec = "g++",
          args = { "-O2", "-Wall", "$(FABSPATH)", "-o", vim.fn.expand(CF_PATH) .. "/.output" .. "/$(FNOEXT)" },
        },
      },
      run_command = {
        c = { exec = vim.fn.expand(CF_PATH) .. "/.output" .. "/$(FNOEXT)" },
        cpp = { exec = vim.fn.expand(CF_PATH) .. "/.output" .. "/$(FNOEXT)" },
      },
    },
  },
}
