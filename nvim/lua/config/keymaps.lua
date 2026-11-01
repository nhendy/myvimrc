local env = require("config.env")
local nav = require("core.nav")
local quickrun = require("core.quickrun")
local vscode = require("core.vscode")

-- Copy the current file's path, relative to cwd, to the clipboard. `%:.` yields
-- an absolute path when the file lies outside cwd, which is the useful answer
-- there rather than a pile of `../`.
local function copy_relative_path()
  local path = vim.fn.expand("%:.")
  if path == "" then
    vim.notify("Buffer has no file name", vim.log.levels.WARN)
    return
  end
  -- clipboard=unnamed routes yanks through `*`; set `+` and the unnamed
  -- register too so the path is available however it gets pasted.
  for _, reg in ipairs({ "*", "+", '"' }) do
    vim.fn.setreg(reg, path)
  end
  vim.notify(path)
end

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

  { mode = "n", lhs = "vv", rhs = "<cmd>vsplit<CR>", desc = "Vertical split", category = "windows", condition = not env.is_vscode },
  { mode = "n", lhs = "vs", rhs = "<cmd>split<CR>", desc = "Horizontal split", category = "windows", condition = not env.is_vscode },
  { mode = "n", lhs = "<C-h>", rhs = "<C-w>h", desc = "Move to left window", category = "windows" },
  { mode = "n", lhs = "<C-j>", rhs = "<C-w>j", desc = "Move to lower window", category = "windows" },
  { mode = "n", lhs = "<C-k>", rhs = "<C-w>k", desc = "Move to upper window", category = "windows" },
  { mode = "n", lhs = "<C-l>", rhs = "<C-w>l", desc = "Move to right window", category = "windows" },

  { mode = "n", lhs = "<leader><CR>", rhs = "<cmd>nohlsearch<CR>", desc = "Clear search highlight", category = "search" },

  { mode = "n", lhs = "<leader>1", rhs = "1gt", desc = "Go to tab 1", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>2", rhs = "2gt", desc = "Go to tab 2", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>3", rhs = "3gt", desc = "Go to tab 3", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>4", rhs = "4gt", desc = "Go to tab 4", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>5", rhs = "5gt", desc = "Go to tab 5", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>6", rhs = "6gt", desc = "Go to tab 6", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>7", rhs = "7gt", desc = "Go to tab 7", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>8", rhs = "8gt", desc = "Go to tab 8", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>9", rhs = "9gt", desc = "Go to tab 9", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>tn", rhs = "<cmd>tabnew<CR>", desc = "Open new tab", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>tc", rhs = "<cmd>tabclose<CR>", desc = "Close tab", category = "tabs", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>to", rhs = "<cmd>tabonly<CR>", desc = "Keep only current tab", category = "tabs", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>tp", rhs = "<cmd>TypstPreviewToggle<CR>", desc = "Toggle Typst browser preview", category = "typst", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>nn", rhs = "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>nf", rhs = "<cmd>NERDTreeFind<CR>", desc = "Reveal current file in NERDTree", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>nb", rhs = "<cmd>NERDTreeFromBookmark<Space>", desc = "Open NERDTree bookmark", category = "files", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>t", rhs = "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar", category = "files", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>z", rhs = "<cmd>Goyo<CR>", desc = "Toggle focus mode", category = "files", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>f", rhs = "<cmd>FZFMru<CR>", desc = "Open recent files", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<C-f>", rhs = "<cmd>Files .<CR>", desc = "FZF file search in cwd", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>a", rhs = ":Rg <C-R><C-W><CR>", desc = "Search word with ripgrep", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>s", rhs = ":Tags <C-R><C-W><CR>", desc = "Search tags for current word", category = "search", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>ss", rhs = ":tselect <C-R><C-W><CR>", desc = "Tag select current word", category = "search", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>c", rhs = "<cmd>FormatCode<CR>", desc = "Format current file", category = "editing", condition = not env.is_vscode },
  -- Shares the <leader>c prefix with the format map above, so ,c now fires only
  -- after timeoutlen (1000ms, the default -- nothing sets it). Same trade-off
  -- already accepted for the ,a prefix below.
  { mode = "n", lhs = "<leader>cr", rhs = copy_relative_path, rhs_label = "copy_relative_path()", desc = "Copy relative path of current file", category = "editing", condition = not env.is_vscode },

  { mode = "n", lhs = "<leader>gb", rhs = "<cmd>call gitblame#echo()<CR>", desc = "Show git blame for current line", category = "git", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>d", rhs = "<cmd>GitGutterToggle<CR>", desc = "Toggle git gutter", category = "git", condition = not env.is_vscode },

  { mode = "n", lhs = "tp", rhs = "<cmd>GoToProtoDef<CR>", desc = "Open matching .proto file", category = "navigation" },
  { mode = "n", lhs = "<leader>gh", rhs = nav.switch_source_header, rhs_label = "switch_source_header()", desc = "Switch source/header file", category = "navigation", condition = not env.is_vscode },
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

  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, rhs_label = "lsp.definition()", desc = "Go to definition", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "yg", rhs = vim.lsp.buf.definition, rhs_label = "lsp.definition()", desc = "Go to definition (legacy alias)", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "gr", rhs = vim.lsp.buf.references, rhs_label = "lsp.references()", desc = "Go to references", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "gi", rhs = vim.lsp.buf.implementation, rhs_label = "lsp.implementation()", desc = "Go to implementation", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "K", rhs = vim.lsp.buf.hover, rhs_label = "lsp.hover()", desc = "Hover documentation", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "qf", rhs = vim.lsp.buf.code_action, rhs_label = "lsp.code_action()", desc = "Code action", category = "lsp", condition = not env.is_vscode },
  -- vim.diagnostic.goto_prev/goto_next were deprecated in 0.11; jump() replaces both.
  { mode = "n", lhs = "[g", rhs = function() vim.diagnostic.jump({ count = -1, float = true }) end, rhs_label = "diagnostic.jump(-1)", desc = "Previous diagnostic", category = "lsp", condition = not env.is_vscode },
  { mode = "n", lhs = "]g", rhs = function() vim.diagnostic.jump({ count = 1, float = true }) end, rhs_label = "diagnostic.jump(+1)", desc = "Next diagnostic", category = "lsp", condition = not env.is_vscode },

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

  -- claudecode.nvim (loaded on demand via its cmd list). These share the <leader>a
  -- prefix with the Rg search (,a) and Avante (,ae); ,a still fires after timeoutlen.
  { mode = "n", lhs = "<leader>ac", rhs = "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>af", rhs = "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>ar", rhs = "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude Code", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>aC", rhs = "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude Code", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>am", rhs = "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>ab", rhs = "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude", category = "ai", condition = not env.is_vscode },
  { mode = "v", lhs = "<leader>as", rhs = "<cmd>ClaudeCodeSend<cr>", desc = "Send selection to Claude", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>aa", rhs = "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff", category = "ai", condition = not env.is_vscode },
  { mode = "n", lhs = "<leader>ad", rhs = "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff", category = "ai", condition = not env.is_vscode },

  -- ── VS Code / Cursor (vscode-neovim) ─────────────────────────────────────
  -- Same keys as above, routed to VS Code commands. Keys nvim never sees
  -- (C-h/j/k/l, explorer/terminal/Quick Open keys, insert-mode jk) live in
  -- ~/dotfiles/vscode/keybindings.json and settings.json instead.
  { mode = "n", lhs = "vv", rhs = vscode.action("workbench.action.splitEditorRight"), rhs_label = "splitEditorRight", desc = "Vertical split", category = "windows", condition = env.is_vscode },
  { mode = "n", lhs = "vs", rhs = vscode.action("workbench.action.splitEditorDown"), rhs_label = "splitEditorDown", desc = "Horizontal split", category = "windows", condition = env.is_vscode },
  { mode = "n", lhs = "[b", rhs = vscode.action("workbench.action.previousEditor"), rhs_label = "previousEditor", desc = "Previous editor tab", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "]b", rhs = vscode.action("workbench.action.nextEditor"), rhs_label = "nextEditor", desc = "Next editor tab", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>1", rhs = vscode.action("workbench.action.openEditorAtIndex1"), rhs_label = "openEditorAtIndex1", desc = "Go to tab 1", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>2", rhs = vscode.action("workbench.action.openEditorAtIndex2"), rhs_label = "openEditorAtIndex2", desc = "Go to tab 2", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>3", rhs = vscode.action("workbench.action.openEditorAtIndex3"), rhs_label = "openEditorAtIndex3", desc = "Go to tab 3", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>4", rhs = vscode.action("workbench.action.openEditorAtIndex4"), rhs_label = "openEditorAtIndex4", desc = "Go to tab 4", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>5", rhs = vscode.action("workbench.action.openEditorAtIndex5"), rhs_label = "openEditorAtIndex5", desc = "Go to tab 5", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>6", rhs = vscode.action("workbench.action.openEditorAtIndex6"), rhs_label = "openEditorAtIndex6", desc = "Go to tab 6", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>7", rhs = vscode.action("workbench.action.openEditorAtIndex7"), rhs_label = "openEditorAtIndex7", desc = "Go to tab 7", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>8", rhs = vscode.action("workbench.action.openEditorAtIndex8"), rhs_label = "openEditorAtIndex8", desc = "Go to tab 8", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>9", rhs = vscode.action("workbench.action.openEditorAtIndex9"), rhs_label = "openEditorAtIndex9", desc = "Go to tab 9", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>tn", rhs = vscode.action("workbench.action.files.newUntitledFile"), rhs_label = "newUntitledFile", desc = "Open new tab", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>tc", rhs = vscode.action("workbench.action.closeActiveEditor"), rhs_label = "closeActiveEditor", desc = "Close tab", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>to", rhs = vscode.action("workbench.action.closeOtherEditors"), rhs_label = "closeOtherEditors", desc = "Keep only current tab", category = "tabs", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>tp", rhs = vscode.action("typst-preview.preview"), rhs_label = "typst-preview.preview", desc = "Toggle Typst preview", category = "typst", condition = env.is_vscode },

  { mode = "n", lhs = "<leader>nn", rhs = vscode.action("workbench.action.toggleSidebarVisibility"), rhs_label = "toggleSidebarVisibility", desc = "Toggle file explorer", category = "files", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>nf", rhs = vscode.action("workbench.files.action.showActiveFileInExplorer"), rhs_label = "showActiveFileInExplorer", desc = "Reveal current file in explorer", category = "files", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>t", rhs = vscode.action("workbench.action.gotoSymbol"), rhs_label = "gotoSymbol", desc = "Symbols in file (Tagbar)", category = "files", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>z", rhs = vscode.action("workbench.action.toggleZenMode"), rhs_label = "toggleZenMode", desc = "Toggle focus mode", category = "files", condition = env.is_vscode },

  { mode = "n", lhs = "<C-f>", rhs = vscode.action("workbench.action.quickOpen"), rhs_label = "quickOpen", desc = "Fuzzy file search", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>f", rhs = vscode.action("workbench.action.quickOpen"), rhs_label = "quickOpen", desc = "Recent files (MRU first)", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>a", rhs = vscode.action_with("workbench.action.findInFiles", function() return { query = vim.fn.expand("<cword>"), triggerSearch = true, isRegex = false } end), rhs_label = "findInFiles(<cword>)", desc = "Search word in project", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>/", rhs = vscode.action("workbench.action.quickTextSearch"), rhs_label = "quickTextSearch", desc = "Fuzzy grep picker", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>s", rhs = vscode.action_with("workbench.action.quickOpen", function() return { "#" .. vim.fn.expand("<cword>") } end), rhs_label = "quickOpen(#<cword>)", desc = "Workspace symbols for current word", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>ss", rhs = vscode.action("editor.action.peekDefinition"), rhs_label = "peekDefinition", desc = "Peek definition", category = "search", condition = env.is_vscode },
  { mode = "n", lhs = "<leader><Tab>", rhs = vscode.action("workbench.action.showCommands"), rhs_label = "showCommands", desc = "Command palette", category = "search", condition = env.is_vscode },

  { mode = "n", lhs = "<leader>c", rhs = vscode.action("editor.action.formatDocument"), rhs_label = "formatDocument", desc = "Format current file", category = "editing", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>cr", rhs = vscode.action("copyRelativeFilePath"), rhs_label = "copyRelativeFilePath", desc = "Copy relative path of current file", category = "editing", condition = env.is_vscode },
  { mode = "n", lhs = "<C-_>", rhs = vscode.action("autoDocstring.generateDocstring"), rhs_label = "autoDocstring", desc = "Generate Python docstring", category = "python", condition = env.is_vscode },

  { mode = "n", lhs = "<leader>gb", rhs = vscode.action("gitlens.toggleLineBlame"), rhs_label = "gitlens.toggleLineBlame", desc = "Toggle git blame for current line", category = "git", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>d", rhs = vscode.action("gitlens.toggleFileChanges"), rhs_label = "gitlens.toggleFileChanges", desc = "Toggle git changes gutter", category = "git", condition = env.is_vscode },
  { mode = "n", lhs = "[h", rhs = vscode.action("workbench.action.editor.previousChange"), rhs_label = "previousChange", desc = "Previous git hunk", category = "git", condition = env.is_vscode },
  { mode = "n", lhs = "]h", rhs = vscode.action("workbench.action.editor.nextChange"), rhs_label = "nextChange", desc = "Next git hunk", category = "git", condition = env.is_vscode },

  { mode = "n", lhs = "<leader>gh", rhs = vscode.action("clangd.switchheadersource"), rhs_label = "clangd.switchheadersource", desc = "Switch source/header file", category = "navigation", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>T", rhs = function() vscode.run_in_side_terminal("pytest") end, rhs_label = "side terminal: pytest", desc = "Run pytest in vertical terminal", category = "run", condition = env.is_vscode },

  { mode = "n", lhs = "gd", rhs = vscode.action("editor.action.revealDefinition"), rhs_label = "revealDefinition", desc = "Go to definition", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "yg", rhs = vscode.action("editor.action.revealDefinition"), rhs_label = "revealDefinition", desc = "Go to definition (legacy alias)", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "gr", rhs = vscode.action("editor.action.goToReferences"), rhs_label = "goToReferences", desc = "Go to references", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "gi", rhs = vscode.action("editor.action.goToImplementation"), rhs_label = "goToImplementation", desc = "Go to implementation", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "K", rhs = vscode.action("editor.action.showHover"), rhs_label = "showHover", desc = "Hover documentation", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "qf", rhs = vscode.action("editor.action.quickFix"), rhs_label = "quickFix", desc = "Code action", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "[g", rhs = vscode.action("editor.action.marker.prev"), rhs_label = "marker.prev", desc = "Previous diagnostic", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "]g", rhs = vscode.action("editor.action.marker.next"), rhs_label = "marker.next", desc = "Next diagnostic", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "[d", rhs = vscode.action("editor.action.marker.prevInFiles"), rhs_label = "marker.prevInFiles", desc = "Previous diagnostic (all files)", category = "lsp", condition = env.is_vscode },
  { mode = "n", lhs = "]d", rhs = vscode.action("editor.action.marker.nextInFiles"), rhs_label = "marker.nextInFiles", desc = "Next diagnostic (all files)", category = "lsp", condition = env.is_vscode },

  { mode = "n", lhs = "<leader>ac", rhs = vscode.action("claude-vscode.editor.openLast"), rhs_label = "claude-vscode.editor.openLast", desc = "Open Claude Code", category = "ai", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>af", rhs = vscode.action("claude-vscode.focus"), rhs_label = "claude-vscode.focus", desc = "Focus Claude Code", category = "ai", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>ab", rhs = vscode.action("claude-vscode.insertAtMention"), rhs_label = "claude-vscode.insertAtMention", desc = "Add current file to Claude", category = "ai", condition = env.is_vscode },
  { mode = "v", lhs = "<leader>as", rhs = vscode.action("claude-vscode.insertAtMention"), rhs_label = "claude-vscode.insertAtMention", desc = "Send selection to Claude", category = "ai", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>aa", rhs = vscode.action("claude-vscode.acceptProposedDiff"), rhs_label = "claude-vscode.acceptProposedDiff", desc = "Accept Claude diff", category = "ai", condition = env.is_vscode },
  { mode = "n", lhs = "<leader>ad", rhs = vscode.action("claude-vscode.rejectProposedDiff"), rhs_label = "claude-vscode.rejectProposedDiff", desc = "Deny Claude diff", category = "ai", condition = env.is_vscode },
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
