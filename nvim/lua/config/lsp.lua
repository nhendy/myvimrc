local M = {}

-- Buffer-local LSP keymaps, registered from LspAttach so they only exist where a
-- server is actually running and so per-server overrides can layer on top. The
-- global gd/gr/gi/K/qf maps live in config/keymaps.lua and stay as they are.
--
-- Note: keymaps.lua binds `gr` as a complete action, which shadows Neovim
-- 0.11+'s built-in grn/gra/grr/gri LSP defaults -- they can never fire. That is
-- why rename gets an explicit binding here.
local function on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
  map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
  map("n", "<leader>o", vim.lsp.buf.document_symbol, "Document symbols")
  map("n", "<leader>O", vim.lsp.buf.workspace_symbol, "Workspace symbols")
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, "LSP format buffer")

  -- Inlay hints on by default for the compiled languages where they carry the
  -- most information (inferred types, parameter names).
  if vim.lsp.inlay_hint and client:supports_method("textDocument/inlayHint") then
    local ft = vim.bo[bufnr].filetype
    if ft == "rust" or ft == "c" or ft == "cpp" then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
    map("n", "<leader>ih", function()
      local on = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not on, { bufnr = bufnr })
    end, "Toggle inlay hints")
  end

  -- rustaceanvim extras. `qf` and `K` are upgraded in place rather than bound
  -- under <leader>c*, which would put a 1s timeoutlen delay on <leader>c
  -- (:FormatCode). <leader>r* already waits because of <leader>rl (QuickRunLast).
  if client.name == "rust-analyzer" then
    map("n", "qf", function()
      vim.cmd.RustLsp("codeAction")
    end, "Rust code action")
    map("n", "K", function()
      vim.cmd.RustLsp({ "hover", "actions" })
    end, "Rust hover actions")
    map("n", "<leader>rr", function()
      vim.cmd.RustLsp("runnables")
    end, "Rust runnables")
    map("n", "<leader>rd", function()
      vim.cmd.RustLsp("debuggables")
    end, "Rust debuggables")
    map("n", "<leader>rm", function()
      vim.cmd.RustLsp("expandMacro")
    end, "Rust expand macro")
    map("n", "<leader>rc", function()
      vim.cmd.RustLsp("openCargo")
    end, "Open Cargo.toml")
  end
end

function M.setup()
  local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  vim.diagnostic.config({
    virtual_text = { spacing = 2, source = "if_many" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        on_attach(client, ev.buf)
      end
    end,
  })

  -- Resolve which Python interpreter pyright analyzes against, so that
  -- "go to definition" jumps into the libraries installed in the project's
  -- uv environment. Without this, pyright falls back to system Python and
  -- cannot resolve third-party packages. Order: active VIRTUAL_ENV, then
  -- a uv/standard <root>/.venv. Returns nil when neither exists.
  local function detect_python_path(root)
    local uv = vim.uv or vim.loop
    local venv = vim.env.VIRTUAL_ENV
    if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
      return venv .. "/bin/python"
    end
    root = root or uv.cwd()
    if root and vim.fn.executable(root .. "/.venv/bin/python") == 1 then
      return root .. "/.venv/bin/python"
    end
    return nil
  end

  local servers = {
    pyright = {
      before_init = function(_, config)
        local py = detect_python_path(config.root_dir)
        if py then
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}
          config.settings.python.pythonPath = py
        end
      end,
    },
    ts_ls = {},
    clangd = {
      -- Mason prepends its bin dir to PATH, so this resolves to Mason's clangd.
      -- --query-driver is what lets clangd interrogate the real compiler for its
      -- system include paths; without it Bazel/cross toolchains report bogus
      -- "file not found" on standard headers.
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--all-scopes-completion",
        "--pch-storage=memory",
        "--offset-encoding=utf-16",
        "--query-driver=/usr/bin/clang++,/usr/bin/g++,/opt/homebrew/bin/*",
        "-j=8",
      },
      root_markers = {
        "compile_commands.json",
        ".clangd",
        "compile_flags.txt",
        "CMakeLists.txt",
        "MODULE.bazel",
        "WORKSPACE",
        ".git",
      },
      capabilities = { offsetEncoding = { "utf-16" } },
    },
    gopls = {},
    -- Starlark LSP: hover/goto-def inside BUILD, BUILD.bazel and *.bzl files.
    starpls = {},
    -- CMakeLists.txt completion/goto. Mason package name is neocmakelsp.
    neocmake = {},
    tinymist = {
      settings = {
        exportPdf = "onSave", -- write <file>.pdf next to <file>.typ on every save
        formatterMode = "typstyle", -- enable tinymist's formatter (used by format-on-save)
      },
    },
  }

  local ok_mason, mason = pcall(require, "mason")
  local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not (ok_mason and ok_mlsp) then
    return
  end

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    -- rustaceanvim owns the rust-analyzer client (it calls vim.lsp.start itself).
    -- Letting mason-lspconfig also enable rust_analyzer attaches a second client
    -- to every Rust buffer and duplicates every diagnostic.
    automatic_enable = { exclude = { "rust_analyzer" } },
  })

  -- Per-server `capabilities` (e.g. clangd's offsetEncoding) must be merged into
  -- the shared cmp capabilities, not overwrite them.
  local function merged_capabilities(server_opts)
    return vim.tbl_deep_extend("force", vim.deepcopy(capabilities), server_opts.capabilities or {})
  end

  local function setup_server_lspconfig(server_name)
    local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
    if not ok_lspconfig then
      vim.notify("nvim-lspconfig is unavailable", vim.log.levels.WARN)
      return
    end
    local server_opts = vim.deepcopy(servers[server_name] or {})
    server_opts.capabilities = merged_capabilities(server_opts)
    local server = lspconfig[server_name]
    if not server then
      vim.notify(string.format("LSP server '%s' not found in lspconfig", server_name), vim.log.levels.WARN)
      return
    end
    server.setup(server_opts)
  end

  local has_native_lsp = vim.fn.has("nvim-0.11") == 1
    and vim.lsp
    and vim.lsp.config ~= nil
    and type(vim.lsp.enable) == "function"
  local function setup_server_native(server_name)
    local server_opts = vim.deepcopy(servers[server_name] or {})
    server_opts.capabilities = merged_capabilities(server_opts)
    vim.lsp.config(server_name, server_opts)
    vim.lsp.enable(server_name)
  end

  if has_native_lsp then
    for server_name, _ in pairs(servers) do
      setup_server_native(server_name)
    end
  elseif type(mason_lspconfig.setup_handlers) == "function" then
    mason_lspconfig.setup_handlers({
      function(server_name)
        setup_server_lspconfig(server_name)
      end,
    })
  else
    for server_name, _ in pairs(servers) do
      setup_server_lspconfig(server_name)
    end
  end

  local ok_cmp_engine, cmp = pcall(require, "cmp")
  if ok_cmp_engine then
    local ok_luasnip, luasnip = pcall(require, "luasnip")
    cmp.setup({
      snippet = {
        expand = function(args)
          if ok_luasnip then
            luasnip.lsp_expand(args.body)
          end
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end
end

return M
