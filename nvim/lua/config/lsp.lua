local M = {}

function M.setup()
  local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local servers = {
    pyright = {},
    ts_ls = {},
    clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
    },
    gopls = {},
  }

  local ok_mason, mason = pcall(require, "mason")
  local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not (ok_mason and ok_mlsp) then
    return
  end

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  local function setup_server_lspconfig(server_name)
    local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
    if not ok_lspconfig then
      vim.notify("nvim-lspconfig is unavailable", vim.log.levels.WARN)
      return
    end
    local server_opts = servers[server_name] or {}
    server_opts.capabilities = capabilities
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
    server_opts.capabilities = capabilities
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
