local M = {}

local function normalize_mode(mode)
  if type(mode) == "table" then
    return table.concat(mode, ",")
  end
  return tostring(mode)
end

local function rhs_label(spec)
  if spec.rhs_label then
    return spec.rhs_label
  end

  if type(spec.rhs) == "string" then
    return spec.rhs
  end

  return "<lua function>"
end

function M.export_to_file(path)
  local keymaps = require("config.keymaps").active_specs()
  local out = {}

  table.sort(keymaps, function(a, b)
    if (a.category or "") ~= (b.category or "") then
      return (a.category or "") < (b.category or "")
    end
    if normalize_mode(a.mode) ~= normalize_mode(b.mode) then
      return normalize_mode(a.mode) < normalize_mode(b.mode)
    end
    return a.lhs < b.lhs
  end)

  table.insert(out, "My Neovim Keymaps")
  table.insert(out, "Generated: " .. os.date("%Y-%m-%d %H:%M:%S"))
  table.insert(out, string.rep("=", 96))
  table.insert(out, string.format("%-14s %-8s %-24s %-22s %s", "Category", "Mode", "Key", "Action", "Description"))
  table.insert(out, string.rep("-", 96))

  for _, spec in ipairs(keymaps) do
    table.insert(out, string.format(
      "%-14s %-8s %-24s %-22s %s",
      spec.category or "misc",
      normalize_mode(spec.mode),
      spec.lhs,
      rhs_label(spec),
      spec.desc or ""
    ))
  end

  local dir = vim.fn.fnamemodify(path, ":h")
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile(out, path)
  return path
end

return M
