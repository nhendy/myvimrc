local env = require("config.env")
local uv = vim.uv or vim.loop

if env.is_vscode then
  return
end

local lazy_commit = "306a05526ada86a7b30af95c5cc81ffba93fef97"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not uv.fs_stat(lazypath) then
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  local clone_result = vim.fn.system(clone_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to clone lazy.nvim: " .. clone_result, vim.log.levels.ERROR)
    return
  end

  local checkout_cmd = { "git", "-C", lazypath, "checkout", lazy_commit }
  local checkout_result = vim.fn.system(checkout_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to checkout pinned lazy.nvim commit: " .. checkout_result, vim.log.levels.ERROR)
    return
  end
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.notify("lazy.nvim could not be loaded", vim.log.levels.ERROR)
  return
end

lazy.setup(require("plugins"), {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  checker = { enabled = false },
  change_detection = { notify = false },
  pkg = {
    enabled = false,
  },
  install = { colorscheme = { "monokai" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
