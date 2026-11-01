-- Thin bridge to VS Code / Cursor when running under the vscode-neovim
-- extension. Outside VS Code the `vscode` module does not exist, so `api` is nil
-- and every helper here is a no-op; keymap specs that use these helpers are
-- gated on `env.is_vscode` anyway.
local env = require("config.env")

local api = env.is_vscode and require("vscode") or nil

local M = {}

-- Fire a VS Code command asynchronously.
function M.run(name, args)
  if not api then
    return
  end
  local opts = {}
  if args ~= nil then
    opts.args = args
  end
  api.action(name, opts)
end

-- Fire a VS Code command and wait for it to finish (use when a later command
-- depends on the first one's effect, e.g. creating a terminal then typing in it).
function M.run_sync(name, args)
  if not api then
    return
  end
  local opts = {}
  if args ~= nil then
    opts.args = args
  end
  return api.call(name, opts)
end

-- Run a JS snippet in the VS Code extension host and return its result. The
-- snippet sees a `vscode` global and may use `await`.
function M.eval_sync(code, timeout)
  if not api then
    return nil
  end
  return api.eval(code, {}, timeout or 3000)
end

-- Facts about the active file that QuickRun needs, gathered through VS Code's
-- filesystem API so they are correct for local *and* Remote-SSH workspaces
-- (nvim only sees remote files as `vscode-remote://...` buffer names, and its
-- own fs calls would look at the local disk).
--   rel            path relative to the workspace folder (terminal cwd)
--   quickrun       contents of <workspace>/.quickrun, or nil
--   python_project true if uv.lock / pyproject.toml / .python-version exist
local ACTIVE_FILE_INFO_JS = [[
const ed = vscode.window.activeTextEditor;
if (!ed) { return null; }
const uri = ed.document.uri;
const wf = vscode.workspace.getWorkspaceFolder(uri);
if (!wf) { return { rel: null }; }
const at = (name) => vscode.Uri.joinPath(wf.uri, name);
const exists = async (name) => {
  try { await vscode.workspace.fs.stat(at(name)); return true; } catch (e) { return false; }
};
let quickrun = null;
try { quickrun = new TextDecoder().decode(await vscode.workspace.fs.readFile(at(".quickrun"))); } catch (e) {}
const python_project = (await exists("uv.lock")) || (await exists("pyproject.toml")) || (await exists(".python-version"));
return { rel: vscode.workspace.asRelativePath(uri, false), quickrun, python_project };
]]

function M.active_file_info()
  return M.eval_sync(ACTIVE_FILE_INFO_JS)
end

-- Return a closure suitable as a keymap rhs.
function M.action(name, args)
  return function()
    M.run(name, args)
  end
end

-- Like `action`, but args are computed at key-press time (e.g. word under cursor).
function M.action_with(name, make_args)
  return function()
    M.run(name, make_args())
  end
end

-- Open a fresh terminal in an editor split to the right (the VS Code analogue of
-- `:vsplit | terminal`) and type `command` into it. When `submit` is false the
-- command is left on the prompt so extra args can be typed before <Enter>.
function M.run_in_side_terminal(command, submit)
  M.run_sync("workbench.action.createTerminalEditorSide")
  local text = command
  if submit ~= false then
    text = text .. "\n"
  end
  M.run("workbench.action.terminal.sendSequence", { text = text })
end

return M
