local min_nvim = "0.9.0"
if vim.fn.has("nvim-0.9") == 0 then
  vim.api.nvim_echo({
    { "Neovim " .. min_nvim .. "+ is required for this config", "ErrorMsg" },
  }, true, {})
  return
end

vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.commands")
require("config.keymaps").setup()

pcall(vim.cmd.colorscheme, "monokai")
