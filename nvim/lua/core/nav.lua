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

function M.switch_source_header()
  local current = vim.api.nvim_buf_get_name(0)
  if current == "" then
    return
  end

  local root = vim.fn.fnamemodify(current, ":r")
  local ext = vim.fn.fnamemodify(current, ":e")

  local candidates
  if ext == "cpp" or ext == "cc" then
    candidates = { root .. ".h", root .. ".hpp" }
  else
    candidates = { root .. ".cpp", root .. ".cc" }
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
