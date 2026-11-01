local M = {}
local uv = vim.uv or vim.loop

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function dirname(path)
  return vim.fn.fnamemodify(path, ":h")
end

local function basename(path)
  return vim.fn.fnamemodify(path, ":t")
end

-- Ask clangd first: it knows the real pairing from the compilation database, so
-- it handles generated headers, .cxx/.hh/.inl, and headers that don't sit next
-- to their source. The extension guess below is the fallback for when clangd
-- isn't attached (no compile_commands.json yet) or doesn't know the file.
local function switch_via_clangd()
  local clients = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })
  if #clients == 0 then
    return false
  end

  local params = { uri = vim.uri_from_bufnr(0) }
  local ok, resp = pcall(function()
    return clients[1]:request_sync("textDocument/switchSourceHeader", params, 1000, 0)
  end)
  if not ok or not resp or resp.err then
    return false
  end

  local target = resp.result
  if type(target) ~= "string" or target == "" then
    return false
  end

  vim.cmd.edit(vim.fn.fnameescape(vim.uri_to_fname(target)))
  return true
end

function M.switch_source_header()
  local current = vim.api.nvim_buf_get_name(0)
  if current == "" then
    return
  end

  if switch_via_clangd() then
    return
  end

  local root = vim.fn.fnamemodify(current, ":r")
  local ext = vim.fn.fnamemodify(current, ":e")

  local candidates
  if ext == "cpp" or ext == "cc" or ext == "cxx" or ext == "c" then
    candidates = { root .. ".h", root .. ".hpp", root .. ".hh", root .. ".hxx" }
  else
    candidates = { root .. ".cpp", root .. ".cc", root .. ".cxx", root .. ".c" }
  end

  for _, candidate in ipairs(candidates) do
    if file_exists(candidate) then
      vim.cmd.edit(vim.fn.fnameescape(candidate))
      return
    end
  end

  vim.notify("No matching source/header file found", vim.log.levels.WARN)
end

function M.goto_proto_def()
  local word = vim.fn.expand("<cfile>")
  if word == "" then
    return
  end

  local target = word:gsub("%.pb%.h$", ".proto")
  vim.cmd.edit(vim.fn.fnameescape(target))
end

function M.goto_build_file()
  local current = vim.api.nvim_buf_get_name(0)
  if current == "" then
    return
  end

  local dir = dirname(current)
  local needle = basename(current)

  while dir and dir ~= "/" and dir ~= "." do
    local build = dir .. "/BUILD"
    if file_exists(build) then
      vim.cmd.edit(vim.fn.fnameescape(build))
      pcall(vim.fn.search, '"' .. needle .. '"')
      return
    end
    local parent = dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end

  vim.notify("No BUILD file found above current file", vim.log.levels.WARN)
end

return M
