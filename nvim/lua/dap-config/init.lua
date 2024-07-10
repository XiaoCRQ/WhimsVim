require("dap-config.c-dap")
-- require("dap-config.html-server")

require("dap-config.keymaps")
-- �����������
local dap = require("dap")
-- ����������û������
local dapui = require("dapui")

-- ���������ı���ʾ��һЩѡ��
require("nvim-dap-virtual-text").setup({
  enabled = true, -- ���������ı���ʾ
  enable_commands = true, -- ���������ı�����
  highlight_changed_variables = true, -- �������ĵı���
  highlight_new_as_changed = false, -- ���±�����Ϊ����
  show_stop_reason = true, -- ��ʾֹͣԭ��
  commented = false, -- �Ƿ�Ϊ��ע�͵Ĵ���
  only_first_definition = true, -- ����ʾ��һ������
  all_references = false, -- ��ʾ��������
  filter_references_pattern = "<module", -- �������õ�ģʽ
  virt_text_pos = "eol", -- �����ı�λ�ã���β
  all_frames = false, -- ��ʾ����֡
  virt_lines = false, -- ������
  virt_text_win_col = nil, -- �����ı�������
})

-- ���õ������ϵ�ĸ���
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0 })

-- ���õ������û�����
dapui.setup({
  element_mappings = {
    scopes = { -- ������
      edit = "e", -- �༭
      repl = "r", -- REPL
    },
    watches = { -- �۲�
      edit = "e",
      repl = "r",
    },
    stacks = { -- ��ջ
      open = "g", -- ��
    },
    breakpoints = { -- �ϵ�
      open = "g",
      toggle = "b", -- �л�
    },
  },
  floating = { -- ��������
    max_height = nil, -- ���߶�
    max_width = nil, -- �����
    border = "rounded", -- �߿���ʽ��Բ��
    mappings = {
      close = { "q", "<Esc>" }, -- �رղ����Ŀ�ݼ�
    },
  },
})

-- �ڵ������¼���ʼ����򿪵������û�����
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- �ڵ������¼���ֹǰ�رյ������û�����
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

-- �ڵ������¼��˳�ǰ�رյ������û�����
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("windows.no1")
