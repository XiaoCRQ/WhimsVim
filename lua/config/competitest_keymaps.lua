local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 打开 / 显示 UI（显示 testcases 界面）
map(
  "n",
  "<leader>cdo",
  ":CompetiTest show_ui<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：显示测试用例 UI" })
)

-- 新增 / 编辑 / 删除 测试用例
map(
  "n",
  "<leader>cdn",
  ":CompetiTest add_testcase<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：添加新测试用例" })
)
map(
  "n",
  "<leader>cde",
  ":CompetiTest edit_testcase<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：编辑测试用例（交互）" })
)
-- 直接编辑指定编号的测试用例（可在命令行里替换数字）
-- 使用示例：:CompetiTest edit_testcase 2
map(
  "n",
  "<leader>cdi",
  ":CompetiTest edit_testcase ",
  vim.tbl_extend(
    "force",
    opts,
    { desc = "CompetiTest：编辑指定编号的测试用例（命令行补数字）", noremap = false }
  )
)

map(
  "n",
  "<leader>cdd",
  ":CompetiTest delete_testcase<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：删除测试用例（交互或使用编号）" })
)
-- 也可用：:CompetiTest delete_testcase 1

-- 转换存储格式（singlefile <-> files）
-- 常用场景： convert singlefile_to_files | files_to_singlefile | auto
map(
  "n",
  "<leader>cdv",
  ":CompetiTest convert auto<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：自动转换 testcases 存储格式（single <-> files）" })
)
map(
  "n",
  "<leader>cdV",
  ":CompetiTest convert files_to_singlefile<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：把多个文件合并为单个 testcases 文件" })
)

-- 运行 / 测试
map(
  "n",
  "<leader>cdt",
  ":CompetiTest run<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：运行（必要时会编译）" })
)
map(
  "n",
  "<leader>cdr",
  ":CompetiTest run_no_compile<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：运行（不重新编译，适用于已编译二进制）" })
)
-- 重新显示上次 UI（不重新执行）
map(
  "n",
  "<leader>cds",
  ":CompetiTest show_ui<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：重新打开 UI（仅显示已有结果/界面）" })
)

-- 进程控制（若需要手动停止）
map(
  "n",
  "<leader>cdk",
  ":CompetiTest stop<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：停止正在运行的进程" })
)

-- Receive（与 Competitive Companion 集成）
-- 单次接收 testcases / problem / contest
map(
  "n",
  "<leader>cdg",
  ":CompetiTest receive testcases<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：接收 testcases（一次性）" })
)
map(
  "n",
  "<leader>cdp",
  ":CompetiTest receive problem<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：接收单个 problem（创建模板文件和 testcases）" })
)
map(
  "n",
  "<leader>cdC",
  ":CompetiTest receive contest<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：接收整场 contest（一次性）" })
)

-- 持续接收 / 查看接收状态 / 停止接收
map(
  "n",
  "<leader>cdP",
  ":CompetiTest receive persistently<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：持续接收（开启监听）" })
)
map(
  "n",
  "<leader>cdS",
  ":CompetiTest receive status<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：查看接收状态" })
)
map(
  "n",
  "<leader>cdT",
  ":CompetiTest receive stop<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：停止接收" })
)

-- 接收后快速打开/定位（打开接收后的文件/目录）
map(
  "n",
  "<leader>cdO",
  ":CompetiTest open_received<CR>",
  vim.tbl_extend(
    "force",
    opts,
    { desc = "CompetiTest：打开接收到的文件/contest（若插件提供该命令）" }
  )
)

-- 注：上述 open_received 命令在不同版本/配置下名字可能略有差异，
-- 如果你收到 “未知命令”，可以使用 README 推荐的接收相关选项并用文件管理器打开目录：
--   received_problems_path, received_contests_directory 等

-- 帮助 / 文档
map(
  "n",
  "<leader>cdh",
  ":h competitest.nvim<CR>",
  vim.tbl_extend("force", opts, { desc = "打开 CompetiTest 帮助文档" })
)

-- 清理编译产物（若插件实现清理命令）
map(
  "n",
  "<leader>cdx",
  ":CompetiTest clean<CR>",
  vim.tbl_extend("force", opts, { desc = "CompetiTest：清理临时/编译产物（若支持）" })
)

-- 简洁速查表（可选，按需注释）：
-- <leader>cdo : 显示 UI
-- <leader>cdn : 新增测试用例
-- <leader>cde : 编辑测试用例
-- <leader>cdd : 删除测试用例
-- <leader>cdv : 转换 testcases 存储格式（auto）
-- <leader>cdt : 运行（可能触发编译）
-- <leader>cdr : 运行（不编译）
-- <leader>cdk : 停止运行
-- <leader>cdg : 接收 testcases（一次）
-- <leader>cdp : 接收 problem（一次）
-- <leader>cdC : 接收 contest（一次）
-- <leader>cdP : 持续接收
-- <leader>cdS : 接收状态
-- <leader>cdT : 停止接收
-- <leader>cdh : 帮助文档
-- <leader>cdx : 清理产物（若支持）
