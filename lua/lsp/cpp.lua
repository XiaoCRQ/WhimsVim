local map = vim.api.nvim_set_keymap -- ��������ӳ��ĺ���
local opt = { -- ѡ�������ָ������ӳ��Ĳ���
  noremap = true, -- ��ֹ����ӳ��ĵݹ�
  silent = true, -- ִ�м���ӳ��ʱ����ʾ�����е���Ϣ
}

function Complete_semicolon() -- ��ȫ�ֺ�
  -- ��ȡ��ǰ�ļ�������
  local filetype = vim.bo.filetype
  -- ����ļ������Ƿ�ΪC��C++
  if filetype == "c" or filetype == "cpp" then
    -- ��ȡ��ǰ��������е�����
    local current_line = vim.fn.getline(".")
    -- ����ĩ��ӷֺ�
    local modified_line = current_line .. ";"
    -- �滻ԭʼ��
    vim.fn.setline(".", modified_line)
  end
end

map("n", ";", ":lua Complete_semicolon()<CR>", opt)
