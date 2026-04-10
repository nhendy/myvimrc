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

function M.run()
  local env = require("config.env")

  assertf(vim.fn.exists(":QuickRun") == 2, "Missing :QuickRun command")
  assertf(vim.fn.exists(":KeymapsExport") == 2, "Missing :KeymapsExport command")

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

  print("selftest ok")
end

return M
