local env = require("config.env")
local uv = vim.uv or vim.loop

local template_group = vim.api.nvim_create_augroup("TemplateFiles", { clear = true })
local terminal_group = vim.api.nvim_create_augroup("TerminalBehavior", { clear = true })
local filetype_group = vim.api.nvim_create_augroup("CustomFiletypeSettings", { clear = true })
local whitespace_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })

if not env.is_vscode then
  vim.api.nvim_create_autocmd("TermOpen", {
    group = terminal_group,
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd("stopinsert")
    end,
  })

  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal mode" })
end

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = { "c", "cpp", "cs", "java" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "hjson",
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "tex",
  callback = function()
    vim.opt_local.updatetime = 100
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_group,
  pattern = "*.jinja",
  callback = function()
    vim.bo.filetype = "htmljinja"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_group,
  pattern = "*.mako",
  callback = function()
    vim.bo.filetype = "mako"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "F", "<cmd>set foldmethod=indent<CR>", { buffer = true, silent = true, desc = "Python fold by indent" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "javascript",
  callback = function()
    vim.keymap.set("i", "<C-t>", "$log();<Esc>hi", { buffer = true, desc = "Insert log statement" })
    vim.keymap.set("i", "<C-a>", "alert();<Esc>hi", { buffer = true, desc = "Insert alert statement" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = { "Avante", "AvanteInput" },
  callback = function()
    vim.b.autopairs_enabled = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = whitespace_group,
  pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee" },
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

if not env.is_vscode then
  vim.api.nvim_create_autocmd("VimEnter", {
    group = filetype_group,
    once = true,
    callback = function()
      vim.g.AutoPairsMapCR = 0
      vim.cmd([[
        if exists('*AutoPairsTryInit')
          function! AutoPairsTryInit() abort
            if exists('b:autopairs_loaded')
              return
            endif
            call AutoPairsInit()
          endfunction
        endif
      ]])
    end,
  })
end

local config_dir = vim.fn.stdpath("config")
local templates_dir = config_dir .. "/templates"

local function maybe_insert_template(template)
  local path = templates_dir .. "/" .. template
  if uv.fs_stat(path) then
    vim.cmd("0read " .. vim.fn.fnameescape(path))
  end
end

vim.api.nvim_create_autocmd("BufNewFile", {
  group = template_group,
  pattern = "*.py",
  callback = function()
    maybe_insert_template("skeleton.py")
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group = template_group,
  pattern = "*.cpp",
  callback = function()
    maybe_insert_template("skeleton.cpp")
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group = template_group,
  pattern = "*.sh",
  callback = function()
    maybe_insert_template("skeleton.sh")
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group = template_group,
  pattern = "*_leetcode.cpp",
  callback = function()
    maybe_insert_template("skeleton_leetcode.cpp")
  end,
})
