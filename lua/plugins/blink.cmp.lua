return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "Kaiser-Yang/blink-cmp-dictionary",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  opts = {
    keymap = {
      ["<C-y>"] = { "select_and_accept" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      -- ["<CR>"] = false, -- 关闭Enter补全
    },
    sources = {
      default = { "dictionary", "lsp", "path", "buffer" },
      providers = {
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 3,
          opts = {
            dictionary_files = { vim.fn.expand(vim.fn.stdpath("config") .. "/lua/resource/words_alpha.txt") },
          },
          score_offset = 40, -- 设置 dictionary 的优先级
        },
        lsp = {
          score_offset = 100, -- 设置 LSP 的优先级
        },
        path = {
          score_offset = 80, -- 设置 path 的优先级
        },
        buffer = {
          score_offset = 60, -- 设置 buffer 的优先级
        },
      },
    },
    snippets = {
      preset = "luasnip", -- 使用新的预设配置
    },
  },
}
