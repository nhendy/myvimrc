-- Python format action: ruff's *linter* (import sorting + unused-import
-- removal) followed by ruff's *formatter*.
--
-- Two commands are required because they are two different tools. `ruff
-- format` is the Black-equivalent formatter and by design never adds, removes
-- or reorders code -- it will not touch imports no matter how it is configured.
-- Sorting (rule I001) and unused-import removal (F401) are lint fixes, so they
-- come from `ruff check --fix`.
--
-- This bypasses :FormatCode for python rather than extending it: codefmt's ruff
-- formatter hardcodes its argv to `ruff format -`, so there is no hook for the
-- check pass and no way to pass --force-exclude (without which the vendored
-- jaxloop tree gets reformatted out of its Google style despite being excluded
-- in pyproject.toml).

local M = {}

-- F401 alone would leave imports unsorted; I alone would leave dead ones behind.
local FIX_RULES = "I,F401"

local function run(args, input)
  if vim.system then
    local res = vim.system(vim.list_extend({ "ruff" }, args), { stdin = input, text = true }):wait()
    return res.stdout or "", res.code
  end
  -- nvim 0.9 fallback: list-form systemlist skips the shell, stderr is not captured.
  local out = vim.fn.systemlist(vim.list_extend({ "ruff" }, args), vim.split(input, "\n"))
  return table.concat(out, "\n"), vim.v.shell_error
end

-- Runs one ruff subcommand over the buffer and writes the result back. Returns
-- false (leaving the buffer untouched) if ruff produced nothing, which is what
-- a crash or a missing binary looks like -- overwriting on that would silently
-- empty the file.
local function pipe_through(bufnr, args)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name ~= "" then
    table.insert(args, "--stdin-filename")
    table.insert(args, name)
  end
  table.insert(args, "-")

  local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n"
  -- Exit status is not a success signal here: `ruff check --fix` exits 1 when
  -- it fixed some findings but others remain unfixable, and still prints the
  -- fixed source. Non-empty stdout is the real signal. On a syntax error ruff
  -- echoes the input back unchanged, so that case is a no-op rather than a loss.
  local out = run(args, input)
  if out == "" then
    return false
  end

  local lines = vim.split(out:gsub("\n$", ""), "\n")
  if vim.deep_equal(lines, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) then
    return true -- already clean; don't dirty the buffer or add an undo entry
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  return true
end

-- Sort imports, drop unused ones, then format. --force-exclude is what makes
-- ruff honour pyproject.toml's exclude list for content fed over stdin; without
-- it, an explicitly-named file is always processed.
function M.format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if vim.fn.executable("ruff") == 0 then
    vim.notify("ruff not found on $PATH", vim.log.levels.WARN)
    return
  end

  local view = vim.fn.winsaveview()
  local ok = pipe_through(bufnr, { "check", "--fix", "--select", FIX_RULES, "--force-exclude" })
  if ok then
    pipe_through(bufnr, { "format", "--force-exclude" })
  else
    vim.notify("ruff check produced no output; buffer left unchanged", vim.log.levels.WARN)
  end
  vim.fn.winrestview(view)
end

return M
