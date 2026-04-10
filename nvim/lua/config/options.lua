local env = require("config.env")

-- Must be set before plugin scripts load.
vim.g.AutoPairsMapCR = 0

vim.opt.clipboard = "unnamed"
vim.opt.cmdheight = 2
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shortmess:append("c")
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.splitbelow = true
vim.opt.updatetime = 300
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.history = 500
vim.opt.autoread = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.foldcolumn = "1"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.laststatus = 2
vim.opt.swapfile = false
vim.opt.encoding = "utf-8"
vim.opt.fileformats = { "unix", "dos", "mac" }

if vim.fn.executable("zsh") == 1 then
  vim.opt.shell = "zsh"
end

if vim.fn.executable("gcc") == 1 then
  local include_dirs = vim.fn.systemlist('gcc -Wp,-v -x c++ - -fsyntax-only 2>&1 | grep "^ " | sed "s/^ //"')
  for _, line in ipairs(include_dirs) do
    if line ~= "" then
      vim.opt.path:append(vim.fn.fnameescape(line))
    end
  end
end

if not env.is_vscode then
  vim.opt.background = "dark"
  vim.opt.termguicolors = true
end

vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

if not env.is_vscode then
  local fd_bin = nil
  if vim.fn.executable("fd") == 1 then
    fd_bin = "fd"
  elseif vim.fn.executable("fdfind") == 1 then
    fd_bin = "fdfind"
  end

  if fd_bin then
    local files_cmd = string.format("%s --type f --type l --hidden --exclude .git .", fd_bin)
    local dirs_cmd = string.format("%s --type d --hidden --exclude .git .", fd_bin)
    -- Force file pickers to stay rooted at the current working directory.
    vim.env.FZF_DEFAULT_COMMAND = files_cmd
    vim.env.FZF_CTRL_T_COMMAND = files_cmd
    vim.env.FZF_ALT_C_COMMAND = dirs_cmd
  end
end
