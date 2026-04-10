local env = require("config.env")

local plugins = {
  {
    "nvim-lua/plenary.nvim",
    commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
  },
  {
    "nvim-tree/nvim-web-devicons",
    commit = "737cf6c657898d0c697311d79d361288a1343d50",
  },
  {
    "junegunn/fzf",
    commit = "f3ca0b136540c2e042462b31ed91e2f89b906658",
    build = "./install --bin",
    cond = not env.is_vscode,
  },
  {
    "junegunn/fzf.vim",
    commit = "34a564c81f36047f50e593c1656f4580ff75ccca",
    cond = not env.is_vscode,
  },
  {
    "pbogut/fzf-mru.vim",
    commit = "5b47c29e66d0546000b2988c4c9dca53f3134f35",
    cond = not env.is_vscode,
  },
  {
    "preservim/nerdtree",
    commit = "690d061b591525890f1471c6675bcb5bdc8cdff9",
    cond = not env.is_vscode,
    init = function()
      vim.g.NERDTreeWinPos = "left"
      vim.g.NERDTreeWinSize = 35
      vim.g.NERDTreeShowHidden = 0
      vim.g.NERDTreeIgnore = { "\\.pyc$", "__pycache__" }
    end,
  },
  {
    "majutsushi/tagbar",
    commit = "7bfffca1f121afb7a9e38747500bf5270e006bb1",
    cond = not env.is_vscode,
  },
  {
    "hushicai/tagbar-javascript.vim",
    commit = "c388b4eb98cf1d732a1345df4b872a65f0609caa",
    cond = not env.is_vscode,
  },
  {
    "tpope/vim-fugitive",
    commit = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0",
  },
  {
    "zivyangll/git-blame.vim",
    commit = "9d144b7bed5d8f1c9259551768b7f3b3d1294917",
    cond = not env.is_vscode,
  },
  {
    "airblade/vim-gitgutter",
    commit = "0acb772e76064cc406664ab595b58b3fac76488a",
    init = function()
      vim.g.gitgutter_enabled = 0
    end,
    cond = not env.is_vscode,
  },
  {
    "easymotion/vim-easymotion",
    commit = "b3cfab2a6302b3b39f53d9fd2cd997e1127d7878",
    cond = not env.is_vscode,
  },
  {
    "junegunn/goyo.vim",
    commit = "9c72fdf2d202914318581f9f0dd09fd102f8504d",
    init = function()
      vim.g.goyo_width = 100
      vim.g.goyo_margin_top = 2
      vim.g.goyo_margin_bottom = 2
    end,
    cond = not env.is_vscode,
  },
  {
    "tpope/vim-surround",
    commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
  },
  {
    "tpope/vim-commentary",
    commit = "64a654ef4a20db1727938338310209b6a63f60c9",
  },
  {
    "tpope/vim-repeat",
    commit = "65846025c15494983dafe5e3b46c8f88ab2e9635",
  },
  {
    "matze/vim-move",
    commit = "267fd1cff61fc643dfb5f9b188c434906f5214aa",
    init = function()
      vim.g.move_map_keys = 1
      vim.g.move_auto_indent = 1
      vim.g.move_key_modifier = "S"
    end,
  },
  {
    "farmergreg/vim-lastplace",
    commit = "e58cb0df716d3c88605ae49db5c4741db8b48aa9",
  },
  {
    "jiangmiao/auto-pairs",
    commit = "39f06b873a8449af8ff6a3eee716d3da14d63a76",
    init = function()
      -- Avoid maparg(<CR>) dict shape mismatch with callback mappings (e.g. Avante input).
      vim.g.AutoPairsMapCR = 0
    end,
  },
  {
    "terryma/vim-multiple-cursors",
    commit = "6456718e1d30b42c04b920c5413ca44f68f08759",
    init = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_word_key = "<C-a>"
      vim.g.multi_cursor_select_all_word_key = "<A-s>"
      vim.g.multi_cursor_start_key = "g<C-a>"
      vim.g.multi_cursor_select_all_key = "g<A-s>"
      vim.g.multi_cursor_next_key = "<C-a>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
    cond = not env.is_vscode,
  },
  {
    "lervag/vimtex",
    commit = "82d2305ff71dfb3bd91602534cc9bb9a195bcb38",
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_method = "skim"
    end,
    cond = not env.is_vscode,
  },
  {
    "heavenshell/vim-pydocstring",
    commit = "9da38e1bb70f5fc9f35ba5abf8ddada81fe2717a",
    init = function()
      vim.g.pydocstring_formatter = "google"
    end,
  },
  {
    "bazelbuild/vim-bazel",
    commit = "31b0d5e4f51da1aeb56d65bf505a744e6de405de",
    dependencies = { "google/vim-maktaba" },
  },
  {
    "google/vim-maktaba",
    commit = "fe95bb10f6bb250943a44632107f6a3d76ce5f28",
    lazy = false,
  },
  {
    "google/vim-glaive",
    commit = "3c5db8d279f86355914200119e8727a085863fcd",
    dependencies = { "google/vim-maktaba" },
    lazy = false,
  },
  {
    "google/vim-codefmt",
    commit = "ff464a478202df40ae484e6e94a1d56587fcc69e",
    dependencies = { "google/vim-maktaba", "google/vim-glaive" },
    lazy = false,
  },
  {
    "mechatroner/rainbow_csv",
    commit = "3dbbfd7d17536aebfb80f571255548495574c32b",
  },
  {
    "rust-lang/rust.vim",
    commit = "889b9a7515db477f4cb6808bef1769e53493c578",
  },
  {
    "czheo/mojo.vim",
    commit = "c5898c2e1137cd420524859f209b6831841397e4",
  },
  {
    "neovim/nvim-lspconfig",
    commit = "2163c54bb6cfec53e3e555665ada945b8c8331b9",
    dependencies = {
      { "williamboman/mason.nvim", commit = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65" },
      { "williamboman/mason-lspconfig.nvim", commit = "a324581a3c83fdacdb9804b79de1cbe00ce18550" },
      { "hrsh7th/nvim-cmp", commit = "da88697d7f45d16852c6b2769dc52387d1ddc45f" },
      { "L3MON4D3/LuaSnip", commit = "dae4f5aaa3574bd0c2b9dd20fb9542a02c10471c" },
      { "hrsh7th/cmp-nvim-lsp", commit = "cbc7b02bb99fae35cb42f514762b89b5126651ef" },
      { "hrsh7th/cmp-buffer", commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657" },
      { "hrsh7th/cmp-path", commit = "c642487086dbd9a93160e1679a1327be111cbc25" },
      { "saadparwaiz1/cmp_luasnip", commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
    },
    config = function()
      require("config.lsp").setup()
    end,
    cond = not env.is_vscode,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "5cb05e1b0fa3c469958a2b26f36b3fe930af221c",
    build = ":TSUpdate",
    cond = not env.is_vscode,
  },
  {
    "zbirenbaum/copilot.lua",
    commit = "575646d22e4a80758935e92f7be7e210c1ceb5bc",
    cond = not env.is_vscode,
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    commit = "2d7c2db2507fa3c4956142ee607431ddb2828639",
    cond = not env.is_vscode,
    opts = {
      input = {
        get_config = function(opts)
          if opts and opts.prompt and opts.prompt:match("^QuickRun args") then
            return {
              relative = "editor",
              border = "rounded",
              title_pos = "center",
              prefer_width = 50,
            }
          end
        end,
      },
    },
  },
  {
    "yetone/avante.nvim",
    commit = "98b7fc255aa28a352f97dd4c0c0ab2a13b0b0657",
    enabled = function()
      return not env.is_vscode and env.has_nvim_0101
    end,
    init = function()
      local uv = vim.uv or vim.loop
      local sysname = uv.os_uname().sysname
      local ext = sysname == "Darwin" and "dylib" or (sysname == "Linux" and "so" or "dll")
      local build_path = vim.fn.stdpath("data") .. "/lazy/avante.nvim/build/?." .. ext
      if not string.find(package.cpath, build_path, 1, true) then
        package.cpath = package.cpath .. ";" .. build_path
      end
    end,
    config = function(_, opts)
      local function ensure_templates_loaded()
        if package.loaded["avante_templates"] ~= nil then
          return true
        end

        local ok = pcall(require, "avante_templates")
        if ok then
          return true
        end

        local uv = vim.uv or vim.loop
        local sysname = uv.os_uname().sysname
        local ext = sysname == "Darwin" and "dylib" or (sysname == "Linux" and "so" or "dll")
        local lib_path = vim.fn.stdpath("data") .. "/lazy/avante.nvim/build/avante_templates." .. ext

        local loader = package.loadlib(lib_path, "luaopen_avante_templates")
        if type(loader) == "function" then
          local loaded, mod = pcall(loader)
          if loaded then
            package.loaded["avante_templates"] = mod
            return true
          end
        end

        return false
      end

      require("avante_lib").load()
      if not ensure_templates_loaded() then
        if vim.g.avante_auto_build_attempted ~= true then
          vim.g.avante_auto_build_attempted = true
          local ok = pcall(function()
            require("avante.api").build({ source = false })
          end)
          if ok then
            vim.notify("Avante templates missing. Started build; restart Neovim after it finishes.", vim.log.levels.WARN)
          else
            vim.notify(
              "Avante templates missing and auto-build failed. Run :AvanteBuild and restart.",
              vim.log.levels.ERROR
            )
          end
        end
        return
      end

      require("avante").setup(opts)
    end,
    dependencies = {
      { "MunifTanjim/nui.nvim", commit = "de740991c12411b663994b2860f1a4fd0937c130" },
      { "stevearc/dressing.nvim", commit = "2d7c2db2507fa3c4956142ee607431ddb2828639" },
      { "zbirenbaum/copilot.lua", commit = "575646d22e4a80758935e92f7be7e210c1ceb5bc" },
      { "HakonHarnes/img-clip.nvim", commit = "b6ddfb97b5600d99afe3452d707444afda658aca" },
      { "MeanderingProgrammer/render-markdown.nvim", commit = "fcea0776a3019f49360b7aaec3318630633c522d" },
    },
    opts = {
      provider = "openai",
      auto_suggestions_provider = "copilot",
      providers = {
        openai = {
          -- Pull key from macOS Keychain at runtime instead of storing in files.
          api_key_name = "cmd:security find-generic-password -a $USER -s AVANTE_OPENAI_API_KEY -w 2>/dev/null",
        },
      },
      mappings = {
        submit = {
          normal = "<CR>",
          insert = "<M-s>",
        },
      },
      behavior = {
        auto_set_keymaps = false,
      },
    },
  },
}

return plugins
