local env = require("config.env")
local uv = vim.uv or vim.loop

local M = {}

M.config_file_name = ".quickrun"
M.last_command = nil

M.default_commands = {
  c = function(file, args)
    local out = vim.fn.fnamemodify(file, ":r") .. ".out"
    return string.format("g++ -g %s -o %s && %s %s", vim.fn.shellescape(file), vim.fn.shellescape(out), vim.fn.shellescape(out), args or "")
  end,
  cpp = function(file, args)
    local out = vim.fn.fnamemodify(file, ":r") .. ".out"
    return string.format("g++ -g %s -o %s && %s %s", vim.fn.shellescape(file), vim.fn.shellescape(out), vim.fn.shellescape(out), args or "")
  end,
  go = function(file, args)
    return string.format("go run %s %s", vim.fn.shellescape(file), args or "")
  end,
  py = function(file, args)
    local module = M.path_to_python_module(file)
    local cmd_prefix = M.python_prefix(file)
    return string.format("%s %s %s", cmd_prefix, module, args or "")
  end,
  mojo = function(file, args)
    return string.format("mojo %s %s", vim.fn.shellescape(file), args or "")
  end,
  sh = function(file, args)
    return string.format("bash %s %s", vim.fn.shellescape(file), args or "")
  end,
  rs = function(file, args)
    local out = vim.fn.fnamemodify(file, ":r") .. ".rust_bin"
    return string.format("rustc %s -o %s && %s %s", vim.fn.shellescape(file), vim.fn.shellescape(out), vim.fn.shellescape(out), args or "")
  end,
}

local function trim(s)
  return (s or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function shell_single_quote(text)
  return "'" .. tostring(text):gsub("'", [['"'"']]) .. "'"
end

function M.find_project_root(file)
  local markers = { "uv.lock", "pyproject.toml", ".python-version", ".git" }
  local dir = vim.fn.fnamemodify(file, ":p:h")

  while dir and dir ~= "/" and dir ~= "." do
    for _, marker in ipairs(markers) do
      local candidate = dir .. "/" .. marker
      if file_exists(candidate) then
        return dir
      end
    end

    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return vim.fn.getcwd()
end

function M.python_prefix(file)
  local root = M.find_project_root(file)
  local has_uv_lock = file_exists(root .. "/uv.lock")
  local has_python_version = file_exists(root .. "/.python-version")
  local has_pyproject = file_exists(root .. "/pyproject.toml")

  if (has_uv_lock or has_python_version or has_pyproject) and vim.fn.executable("uv") == 1 then
    return "uv run python -m"
  end

  return "python3 -m"
end

function M.path_to_python_module(file)
  local root = M.find_project_root(file)
  local rel = vim.fn.fnamemodify(file, ":.")

  if root and root ~= "" then
    local prefix = root .. "/"
    if file:sub(1, #prefix) == prefix then
      rel = file:sub(#prefix + 1)
    end
  end

  rel = rel:gsub("\\", "/")
  rel = rel:gsub("%.py$", "")
  rel = rel:gsub("/", ".")
  rel = rel:gsub("^%.*", "")

  if rel == "" then
    rel = vim.fn.fnamemodify(file, ":t:r")
  end

  return rel
end

function M.find_config_command()
  local path = vim.fn.getcwd() .. "/" .. M.config_file_name
  if not file_exists(path) then
    return nil
  end

  local lines = vim.fn.readfile(path)
  return trim(table.concat(lines, " "))
end

function M.build_default_command(opts)
  opts = opts or {}
  local file = opts.file or vim.api.nvim_buf_get_name(0)
  local args = trim(opts.args or "")
  local ext = opts.filetype or vim.fn.fnamemodify(file, ":e")

  if ext == "python" then
    ext = "py"
  end

  local builder = M.default_commands[ext]
  if not builder then
    return nil, string.format("No QuickRun command configured for file type '%s'", ext)
  end

  return builder(file, args)
end

function M.run_in_vsplit_terminal(command)
  M.last_command = command
  local wrapped = string.format(
    "printf 'QuickRun command: %%s\\n\\n' %s; %s",
    shell_single_quote(command),
    command
  )

  vim.cmd("vsplit")
  vim.cmd("enew")
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.fn.termopen(wrapped)
  vim.cmd("startinsert")
end

function M.show_last_command()
  if not M.last_command then
    vim.notify("No QuickRun command has been run yet", vim.log.levels.INFO)
    return
  end
  vim.notify("Last QuickRun command: " .. M.last_command, vim.log.levels.INFO)
end

function M.run(opts)
  if env.is_vscode then
    vim.notify("QuickRun terminal split is disabled inside VSCode-Neovim", vim.log.levels.WARN)
    return
  end

  opts = opts or {}
  local command = M.find_config_command()

  if not command then
    local built, err = M.build_default_command(opts)
    if not built then
      vim.notify(err, vim.log.levels.ERROR)
      return
    end
    command = built
  elseif opts.args and trim(opts.args) ~= "" then
    command = command .. " " .. trim(opts.args)
  end

  M.run_in_vsplit_terminal(command)
end

return M
