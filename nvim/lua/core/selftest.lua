local M = {}

local function assertf(condition, message)
  if not condition then
    error(message)
  end
end

local function has_map(mode, lhs)
  local result = vim.fn.maparg(lhs, mode, false, true)
  return type(result) == "table" and next(result) ~= nil
end

local function keymap_spec(lhs)
  for _, spec in ipairs(require("config.keymaps").specs) do
    if spec.lhs == lhs then
      return spec
    end
  end
  return nil
end

function M.run()
  local env = require("config.env")

  assertf(vim.fn.exists(":QuickRun") == 2, "Missing :QuickRun command")
  assertf(vim.fn.exists(":KeymapsExport") == 2, "Missing :KeymapsExport command")
  assertf(vim.fn.exists(":CompileCommands") == 2, "Missing :CompileCommands command")
  assertf(vim.fn.exists(":BazelCompileCommands") == 2, "Missing :BazelCompileCommands command")

  local must_have = {
    { mode = "n", lhs = "gd" },
    { mode = "n", lhs = "<leader>r" },
    { mode = "n", lhs = "<leader>gB" },
  }

  if not env.is_vscode then
    table.insert(must_have, { mode = "n", lhs = "<leader>nn" })
  end

  for _, entry in ipairs(must_have) do
    assertf(has_map(entry.mode, entry.lhs), string.format("Missing keymap: %s %s", entry.mode, entry.lhs))
  end

  local quickrun = require("core.quickrun")
  local py_cmd = quickrun.build_default_command({ file = "/tmp/example.py", filetype = "py", args = "--help" })
  assertf(py_cmd ~= nil and py_cmd ~= "", "Failed building python quickrun command")

  local cpp_cmd = quickrun.build_default_command({ file = "/tmp/example.cpp", filetype = "cpp", args = "" })
  assertf(cpp_cmd ~= nil and cpp_cmd:find("g%+%+"), "Failed building cpp quickrun command")

  -- Diagnostics must use vim.diagnostic.jump; goto_prev/goto_next are deprecated
  -- and scheduled for removal.
  assertf(type(vim.diagnostic.jump) == "function", "vim.diagnostic.jump is unavailable")
  for _, lhs in ipairs({ "[g", "]g" }) do
    local spec = keymap_spec(lhs)
    assertf(spec ~= nil, "Missing diagnostic keymap spec: " .. lhs)
    assertf(
      (spec.rhs_label or ""):find("jump", 1, true) ~= nil,
      string.format("Diagnostic keymap %s still uses the deprecated goto_* API", lhs)
    )
  end

  -- Native code navigation: the parsers and the compile_commands helpers that
  -- clangd and rust-analyzer depend on.
  local ok_ts, ts = pcall(require, "nvim-treesitter")
  if ok_ts then
    local installed = ts.get_installed()
    for _, lang in ipairs({ "c", "cpp", "rust" }) do
      assertf(vim.tbl_contains(installed, lang), "Missing treesitter parser: " .. lang)
    end
  end

  local compiledb = require("core.compiledb")
  assertf(type(compiledb.cmake) == "function", "core.compiledb.cmake is missing")
  assertf(type(compiledb.bazel) == "function", "core.compiledb.bazel is missing")
  assertf(
    compiledb.find_root("/nonexistent/path/for/selftest", { "CMakeLists.txt" }) == nil,
    "compiledb.find_root should return nil when no marker is found"
  )

  local nav = require("core.nav")
  assertf(type(nav.switch_source_header) == "function", "core.nav.switch_source_header is missing")

  print("selftest ok")
end

return M
