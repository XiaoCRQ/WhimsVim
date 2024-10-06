-- ����������û������
local dapui = require("dapui")

-- ���Ĭ��

-- ���õ������û�����
dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
        "stacks",
        "breakpoints",
        "watches",
      },
      size = 0.2, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    {
      elements = {
        "console",
      },
      size = 0.2,
      position = "right",
    },
  },
})
