-- ����������û������
local dapui = require("dapui")

-- ����̨ ��35%
-- ��Ԫ�� ��30%

-- ���õ������û�����
dapui.setup({
  layouts = { -- ����
    {
      elements = {
        "console", -- ����̨
      },
      size = 0.3,
      position = "bottom",
    },
    {
      elements = { -- Ԫ��
        "watches", -- �۲�
        "scopes", -- ������
        "breakpoints", -- �ϵ�
      },
      size = 0.3,
      position = "right",
    },
  },
})
