-- ����������û������
local dapui = require("dapui")

-- ����̨ ��30%
-- ��Ԫ�� ��30%

-- ���õ������û�����
dapui.setup({
  layouts = { -- ����
    {
      elements = {
        "console", -- ����̨
      },
      size = 0.3,
      position = "right", -- λ�ã��Ҳ�
    },
    {
      elements = { -- Ԫ��
        "watches", -- �۲�
        "scopes", -- ������
        "breakpoints", -- �ϵ�
      },
      size = 0.3,
      position = "bottom", -- λ�ã��ײ�
    },
  },
})
