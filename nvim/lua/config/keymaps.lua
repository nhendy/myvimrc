local env = require("config.env")
local nav = require("core.nav")
local quickrun = require("core.quickrun")

local M = {}

M.specs = {
  { mode = "n", lhs = "<leader>w", rhs = "<cmd>w!<CR>", desc = "Save file", category = "editing" },

  { mode = "i", lhs = "jk", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "JK", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "jK", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "Jk", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "kj", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "KJ", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "Kj", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },
  { mode = "i", lhs = "kJ", rhs = "<Esc>", desc = "Exit insert mode", category = "editing" },

  { mode = "n", lhs = "<Up>", rhs = "<Nop>", desc = "Disable up arrow", category = "editing" },
  { mode = "n", lhs = "<Down>", rhs = "<Nop>", desc = "Disable down arrow", category = "editing" },
  { mode = "n", lhs = "<Left>", rhs = "<Nop>", desc = "Disable left arrow", category = "editing" },
  { mode = "n", lhs = "<Right>", rhs = "<Nop>", desc = "Disable right arrow", category = "editing" },

  { mode = "i", lhs = "<C-e>", rhs = "<C-o>$", desc = "End of line in insert mode", category = "editing" },
  { mode = "i", lhs = "<C-a>", rhs = "<C-o>0", desc = "Start of line in insert mode", category = "editing" },

  { mode = "n", lhs = "vv", rhs = "<cmd>vsplit<CR>", desc = "Vertical split", category = "windows" },
  { mode = "n", lhs = "vs", rhs = "<cmd>split<CR>", desc = "Horizontal split", category = "windows" },
  { mode = "n", lhs = "<C-h>", rhs = "<C-w>h", desc = "Move to left window", category = "windows" },
  { mode = "n", lhs = "<C-j>", rhs = "<C-w>j", desc = "Move to lower window", category = "windows" },
  { mode = "n", lhs = "<C-k>", rhs = "<C-w>k", desc = "Move to upper window", category = "windows" },
  { mode = "n", lhs = "<C-l>", rhs = "<C-w>l", desc = "Move to right window", category = "windows" },

  { mode = "n", lhs = "<leader><CR>", rhs = "<cmd>nohlsearch<CR>", desc = "Clear search highlight", category = "search" },

  { mode = "n", lhs = "<leader>1", rhs = "1gt", desc = "Go to tab 1", category = "tabs" },
  { mode = "n", lhs = "<leader>2", rhs = "2gt", desc = "Go to tab 2", category = "tabs" },
  { mode = "n", lhs = "<leader>3", rhs = "3gt", desc = "Go to tab 3", category = "tabs" },
  { mode = "n", lhs = "<leader>4", rhs = "4gt", desc = "Go to tab 4", category = "tabs" },
  { mode = "n", lhs = "<leader>5", rhs = "5gt", desc = "Go to tab 5", category = "tabs" },
  { mode = "n", lhs = "<leader>6", rhs = "6gt", desc = "Go to tab 6", category = "tabs" },
  { mode = "n", lhs = "<leader>7", rhs = "7gt", desc = "Go to tab 7", category = "tabs" },
  { mode = "n", lhs = "<leader>8", rhs = "8gt", desc = "Go to tab 8", category = "tabs" },
  { mode = "n", lhs = "<leader>9", rhs = "9gt", desc = "Go to tab 9", category = "tabs" },
  { mode = "n", lhs = "<leader>tn", rhs = "<cmd>tabnew<CR>", desc = "Open new tab", category = "tabs" },
  { mode = "n", lhs = "<leader>tc", rhs = "<cmd>tabclose<CR>", desc = "Close tab", category = "tabs" },
  { mode = "n", lhs = "<leader>to", rhs = "<cmd>tabonly<CR>", desc = "Keep only current tab", category = "tabs" },

  { mode = "n", lhs = "<leader>nn", rhs = "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>nf", rhs = "<cmd>NERDTreeFind<CR>", desc = "Reveal current file in NERDTree", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>nb", rhs = "<cmd>NERDTreeFromBookmark<Space>", desc = "Open NERDTree bookmark", category = "files", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>t", rhs = "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>z", rhs = "<cmd>Goyo<CR>", desc = "Toggle focus mode", category = "files", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>f", rhs = "<cmd>FZFMru<CR>", desc = "Open recent files", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<C-f>", rhs = "<cmd>Files .<CR>", desc = "FZF file search in cwd", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>a", rhs = "<cmd>Rg <C-R><C-W><CR>", desc = "Search word with ripgrep", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>s", rhs = "<cmd>Tags <C-R><C-W><CR>", desc = "Search tags for current word", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>ss", rhs = "<cmd>tselect <C-R><C-W><CR>", desc = "Tag select current word", category = "search", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>c", rhs = "<cmd>FormatCode<CR>", desc = "Format current file", category = "editing", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>gb", rhs = "<cmd>call gitblame#echo()<CR>", desc = "Show git blame for current line", category = "git", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>d", rhs = "<cmd>GitGutterToggle<CR>", desc = "Toggle git gutter", category = "git", condition = not env.is_vscode },

  { mode = "n", lhs = "tp", rhs = "<cmd>GoToProtoDef<CR>", desc = "Open matching .proto file", category = "navigation" },
  { mode = "n", lhs = "<leader>gh", rhs = nav.switch_source_header, rhs_label = "switch_source_header()", desc = "Switch source/header file", category = "navigation" },
  { mode = "n", lhs = "<leader>gB", rhs = nav.goto_build_file, rhs_label = "goto_build_file()", desc = "Open nearest BUILD file", category = "navigation" },

  { mode = "n", lhs = "<leader>r", rhs = function() quickrun.run({}) end, rhs_label = "QuickRun", desc = "Quick run current buffer", category = "run" },
  { mode = "n", lhs = "<leader>rl", rhs = quickrun.show_last_command, rhs_label = "QuickRunLast", desc = "Show last QuickRun command", category = "run" },
  {
    mode = "n",
    lhs = "<leader>R",
    rhs = function()
      vim.ui.input({ prompt = "QuickRun args: " }, function(input)
        if input then
          quickrun.run({ args = input })
        end
      end)
    end,
    rhs_label = "QuickRunWithArgs",
    desc = "Quick run current buffer with args",
    category = "run",
  },
  { mode = "n", lhs = "<leader>T", rhs = "<cmd>vsplit | terminal pytest<CR>", desc = "Run pytest in vertical terminal", category = "run", condition = not env.is_vscode },

  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, rhs_label = "lsp.definition()", desc = "Go to definition", category = "lsp" },
  { mode = "n", lhs = "yg", rhs = vim.lsp.buf.definition, rhs_label = "lsp.definition()", desc = "Go to definition (legacy alias)", category = "lsp" },
  { mode = "n", lhs = "gr", rhs = vim.lsp.buf.references, rhs_label = "lsp.references()", desc = "Go to references", category = "lsp" },
  { mode = "n", lhs = "gi", rhs = vim.lsp.buf.implementation, rhs_label = "lsp.implementation()", desc = "Go to implementation", category = "lsp" },
  { mode = "n", lhs = "K", rhs = vim.lsp.buf.hover, rhs_label = "lsp.hover()", desc = "Hover documentation", category = "lsp" },
  { mode = "n", lhs = "qf", rhs = vim.lsp.buf.code_action, rhs_label = "lsp.code_action()", desc = "Code action", category = "lsp" },
  { mode = "n", lhs = "[g", rhs = vim.diagnostic.goto_prev, rhs_label = "diagnostic.prev()", desc = "Previous diagnostic", category = "lsp" },
  { mode = "n", lhs = "]g", rhs = vim.diagnostic.goto_next, rhs_label = "diagnostic.next()", desc = "Next diagnostic", category = "lsp" },

  { mode = "n", lhs = "<space>v", rhs = "<plug>(vimtex-view)", rhs_label = "<plug>(vimtex-view)", desc = "View compiled PDF", category = "latex", remap = true, condition = not env.is_vscode },
  { mode = "n", lhs = "<C-_>", rhs = "<Plug>(pydocstring)", rhs_label = "<Plug>(pydocstring)", desc = "Generate Python docstring", category = "python", remap = true, condition = not env.is_vscode },

  { mode = "n", lhs = "<leader><Tab>", rhs = "<Plug>(fzf-maps-n)", rhs_label = "<Plug>(fzf-maps-n)", desc = "Search normal-mode mappings", category = "search", remap = true, condition = not env.is_vscode },
  { mode = "x", lhs = "<leader><Tab>", rhs = "<Plug>(fzf-maps-x)", rhs_label = "<Plug>(fzf-maps-x)", desc = "Search visual-mode mappings", category = "search", remap = true, condition = not env.is_vscode },
  { mode = "o", lhs = "<leader><Tab>", rhs = "<Plug>(fzf-maps-o)", rhs_label = "<Plug>(fzf-maps-o)", desc = "Search operator-pending mappings", category = "search", remap = true, condition = not env.is_vscode },

  { mode = "i", lhs = "<C-x><C-k>", rhs = "<Plug>(fzf-complete-word)", rhs_label = "<Plug>(fzf-complete-word)", desc = "FZF complete words", category = "search", remap = true, condition = not env.is_vscode },
  { mode = "i", lhs = "<C-x><C-p>", rhs = "<Plug>(fzf-complete-path)", rhs_label = "<Plug>(fzf-complete-path)", desc = "FZF complete path", category = "search", remap = true, condition = not env.is_vscode },
  { mode = "i", lhs = "<C-x><C-l>", rhs = "<Plug>(fzf-complete-line)", rhs_label = "<Plug>(fzf-complete-line)", desc = "FZF complete line", category = "search", remap = true, condition = not env.is_vscode },

  { mode = { "n", "x" }, lhs = "<M-j>", rhs = ":m .+1<CR>==", desc = "Move line down", category = "editing" },
  { mode = { "n", "x" }, lhs = "<M-k>", rhs = ":m .-2<CR>==", desc = "Move line up", category = "editing" },

  { mode = "n", lhs = "/", rhs = "<Plug>(easymotion-sn)", rhs_label = "<Plug>(easymotion-sn)", desc = "EasyMotion search", category = "navigation", remap = true, condition = not env.is_vscode },
  { mode = "o", lhs = "/", rhs = "<Plug>(easymotion-tn)", rhs_label = "<Plug>(easymotion-tn)", desc = "EasyMotion operator search", category = "navigation", remap = true, condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>ae", rhs = "<cmd>AvanteToggle<CR>", desc = "Toggle Avante", category = "ai", condition = not env.is_vscode and env.has_nvim_0101 },
}

local function should_apply(spec)
  if spec.condition == nil then
    return true
  end
  if type(spec.condition) == "function" then
    return spec.condition()
  end
  return spec.condition
end

function M.active_specs()
  local active = {}
  for _, spec in ipairs(M.specs) do
    if should_apply(spec) then
      table.insert(active, spec)
    end
  end
  return active
end

function M.setup()
  for _, spec in ipairs(M.active_specs()) do
    local opts = {
      desc = spec.desc,
      silent = spec.silent ~= false,
    }

    if spec.remap then
      opts.remap = true
    else
      opts.noremap = spec.noremap ~= false
    end

    vim.keymap.set(spec.mode, spec.lhs, spec.rhs, opts)
  end
end

return M
