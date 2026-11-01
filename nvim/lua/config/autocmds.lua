local env = require("config.env")
local uv = vim.uv or vim.loop

local template_group = vim.api.nvim_create_augroup("TemplateFiles", { clear = true })
local terminal_group = vim.api.nvim_create_augroup("TerminalBehavior", { clear = true })
local filetype_group = vim.api.nvim_create_augroup("CustomFiletypeSettings", { clear = true })
local whitespace_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

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

-- Bazel files aren't in Neovim's default ftdetect. Registering them as `bzl`
-- makes both the starlark treesitter parser and the starpls LSP attach.
vim.filetype.add({
  extension = { bzl = "bzl", bazel = "bzl" },
  filename = {
    BUILD = "bzl",
    ["BUILD.bazel"] = "bzl",
    WORKSPACE = "bzl",
    ["WORKSPACE.bazel"] = "bzl",
    ["MODULE.bazel"] = "bzl",
  },
})

-- nvim-treesitter's main branch ships no FileType autocmd, so installing a
-- parser does nothing on its own -- highlighting only starts when something
-- calls vim.treesitter.start(). This does it for every buffer whose language
-- actually has a parser installed, and leaves regex syntax in place otherwise.
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang and pcall(vim.treesitter.start, ev.buf, lang) then
      pcall(function()
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "typst",
  callback = function()
    vim.opt_local.updatetime = 100 -- snappier preview/diagnostic refresh
    -- auto-close $ for inline math (auto-pairs doesn't pair $ by default)
    if vim.fn.exists("*AutoPairsDefine") == 1 then
      vim.b.AutoPairs = vim.fn.AutoPairsDefine({ ["$"] = "$" })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = filetype_group,
  pattern = "*.typ",
  callback = function()
    pcall(vim.lsp.buf.format, { async = false }) -- tinymist (typstyle) formats before write
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

-- codefmt picks the first *installed* python formatter in its registration
-- order (autopep8, isort, black, ruff, yapf), so :FormatCode silently changes
-- behaviour the day another one lands on $PATH. Pin it: ruff is the only one
-- that gives a hanging indent (first arg on its own line) out of the box --
-- yapf's pep8 style aligns under the open paren instead.
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "python",
  callback = function()
    vim.b.codefmt_formatter = "ruff"
    -- Override the global <leader>c (:FormatCode) for python only: codefmt runs
    -- `ruff format`, which never touches imports. core.pyfmt runs the linter's
    -- import fixes first, then formats. Bound as bare <leader>c, not a
    -- <leader>c* prefix, so it adds no timeoutlen delay (see config/lsp.lua).
    vim.keymap.set("n", "<leader>c", function()
      require("core.pyfmt").format()
    end, { buffer = true, silent = true, desc = "Sort imports + format (ruff)" })
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

vim.api.nvim_create_autocmd("BufNewFile", {
  group = template_group,
  pattern = "*.typ",
  callback = function()
    maybe_insert_template("skeleton.typ")
  end,
})
