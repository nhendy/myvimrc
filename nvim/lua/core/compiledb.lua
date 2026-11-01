-- compile_commands.json generation.
--
-- This file is the whole reason clangd navigation works: without a compilation
-- database clangd guesses flags, and every non-trivial #include fails to resolve.
-- CMake emits the database natively; Bazel cannot, because clangd has no way to
-- read the Bazel action graph -- hence Hedron's extractor.
local M = {}
local uv = vim.uv or vim.loop

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return uv.cwd()
  end
  return vim.fn.fnamemodify(name, ":p:h")
end

-- Walk up from `start` until one of `markers` exists. Returns the directory.
function M.find_root(start, markers)
  local dir = start or buffer_dir()
  while dir and dir ~= "/" and dir ~= "." do
    for _, marker in ipairs(markers) do
      if file_exists(dir .. "/" .. marker) then
        return dir
      end
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end
  return nil
end

-- Bounce the clangd client so it reads the database that was just written.
-- vim.lsp.enable(name, false) stops every client for that config; re-enabling
-- re-attaches to the buffers that still match.
function M.restart_clangd()
  local ok = pcall(function()
    vim.lsp.enable("clangd", false)
    vim.schedule(function()
      vim.lsp.enable("clangd")
    end)
  end)
  if not ok then
    for _, client in ipairs(vim.lsp.get_clients({ name = "clangd" })) do
      client:stop()
    end
  end
  vim.notify("clangd restarted against the new compile_commands.json", vim.log.levels.INFO)
end

-- termopen() is deprecated on 0.11+; jobstart({term = true}) replaces it.
local function open_terminal(command, cwd, on_exit)
  vim.cmd("vsplit")
  vim.cmd("enew")
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  local opts = { cwd = cwd, on_exit = on_exit }
  if vim.fn.has("nvim-0.11") == 1 then
    opts.term = true
    return vim.fn.jobstart(command, opts)
  end
  return vim.fn.termopen(command, opts)
end

local function run(command, cwd, on_success)
  vim.notify(command, vim.log.levels.INFO)
  open_terminal(command, cwd, function(_, code)
    if code == 0 then
      if on_success then
        vim.schedule(on_success)
      end
    else
      vim.schedule(function()
        vim.notify(string.format("Failed (exit %d): %s", code, command), vim.log.levels.ERROR)
      end)
    end
  end)
end

-- CMake: configure with the export flag on, then link the database to the repo
-- root, which is where clangd's root_markers look for it.
function M.cmake()
  local root = M.find_root(buffer_dir(), { "CMakeLists.txt" })
  if not root then
    vim.notify("No CMakeLists.txt found above the current file", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("cmake") ~= 1 then
    vim.notify("cmake not found (brew install cmake ninja)", vim.log.levels.ERROR)
    return
  end

  local generator = vim.fn.executable("ninja") == 1 and "Ninja" or "Unix Makefiles"
  local cmd = string.format(
    "cmake -S %s -B %s -G %s -DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
    vim.fn.shellescape(root),
    vim.fn.shellescape(root .. "/build"),
    vim.fn.shellescape(generator)
  )

  run(cmd, root, function()
    local db = root .. "/build/compile_commands.json"
    if not file_exists(db) then
      vim.notify("cmake finished but " .. db .. " was not written", vim.log.levels.WARN)
      return
    end
    -- Relative target: the link resolves from the root dir it lives in.
    vim.fn.system({ "ln", "-sfn", "build/compile_commands.json", root .. "/compile_commands.json" })
    M.restart_clangd()
  end)
end

-- Bazel: requires hedron_compile_commands to be declared in the repo first.
--   MODULE.bazel:  bazel_dep(name = "hedron_compile_commands", version = "...")
--   WORKSPACE:     http_archive(...) + hedron_compile_commands_setup()
-- See docs/cpp-navigation.md.
function M.bazel()
  local root = M.find_root(buffer_dir(), { "MODULE.bazel", "WORKSPACE", "WORKSPACE.bazel" })
  if not root then
    vim.notify("No MODULE.bazel/WORKSPACE found above the current file", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("bazel") ~= 1 then
    vim.notify("bazel not found (brew install bazelisk)", vim.log.levels.ERROR)
    return
  end

  run("bazel run @hedron_compile_commands//:refresh_all", root, function()
    if not file_exists(root .. "/compile_commands.json") then
      vim.notify(
        "refresh_all finished but no compile_commands.json at "
          .. root
          .. " -- is hedron_compile_commands declared? See docs/cpp-navigation.md",
        vim.log.levels.WARN
      )
      return
    end
    M.restart_clangd()
  end)
end

return M
