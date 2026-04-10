local M = {}

M.is_vscode = vim.g.vscode == 1 or vim.g.vscode == true
M.has_nvim_0101 = vim.fn.has("nvim-0.10.1") == 1

return M
