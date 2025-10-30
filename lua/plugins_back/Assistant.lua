return {
  "A7lavinraj/assistant.nvim",
  lazy = false,
  keys = {
    -- { "<leader>a", "<cmd>Assistant<cr>", desc = "Assistant.nvim" },
  },
  opts = {
    commands = {
      cpp = {
        extension = "cpp",
        template = Cf_path .. "/template/template.cpp",
        compile = {
          main = "g++",
          args = {
            "$FILENAME_WITH_EXTENSION", -- 当前 cpp 文件
            "-o",
            "$DIR/output/$FILENAME_BASE.out", -- 输出到当前文件夹下 output 文件夹
            "-std=c++17",
            "-O2",
            "-Wall",
            "-Wextra",
          },
          pre_hook = function(filename)
            local dir = vim.fn.expand("%:p:h") .. "/output"
            vim.fn.mkdir(dir, "p")
          end,
        },
        execute = {
          main = "$DIR/output/$FILENAME_BASE.out",
          args = nil,
        },
      },
    },
  },
}
