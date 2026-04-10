local quickrun = require("core.quickrun")
local keymap_export = require("core.keymap_export")
local nav = require("core.nav")

vim.api.nvim_create_user_command("QuickRun", function()
  quickrun.run({})
end, { desc = "Run current buffer in a vertical terminal split" })

vim.api.nvim_create_user_command("QuickRunWithArgs", function(opts)
  quickrun.run({ args = opts.args })
end, {
  nargs = "*",
  desc = "Run current buffer with extra arguments in a vertical terminal split",
})

vim.api.nvim_create_user_command("QuickRunWithType", function(opts)
  local parts = vim.split(opts.args, "%s+", { trimempty = true })
  if #parts == 0 then
    vim.notify("Usage: QuickRunWithType <filetype> [args]", vim.log.levels.ERROR)
    return
  end

  local filetype = table.remove(parts, 1)
  local args = table.concat(parts, " ")
  quickrun.run({ filetype = filetype, args = args })
end, {
  nargs = "+",
  complete = function()
    local out = {}
    for ft, _ in pairs(quickrun.default_commands) do
      table.insert(out, ft)
    end
    table.sort(out)
    return out
  end,
  desc = "Run current buffer using a specific quickrun filetype command",
})

vim.api.nvim_create_user_command("QuickRunLast", function()
  quickrun.show_last_command()
end, {
  desc = "Show the last QuickRun shell command",
})

-- Backward-compatible Vimscript function entrypoints:
-- :call QuickRun()
-- :call QuickRunWithArgs("...")
vim.cmd([[
if !exists('*QuickRun')
  function! QuickRun(...) abort
    if a:0 > 0
      call luaeval("require('core.quickrun').run({ args = _A })", a:1)
    else
      call luaeval("require('core.quickrun').run({})")
    endif
  endfunction
endif

if !exists('*QuickRunWithArgs')
  function! QuickRunWithArgs(args1) abort
    call luaeval("require('core.quickrun').run({ args = _A })", a:args1)
  endfunction
endif
]])

vim.api.nvim_create_user_command("KeymapsExport", function()
  local path = vim.fn.stdpath("config") .. "/docs/keymaps.txt"
  local out = keymap_export.export_to_file(path)
  vim.notify("Keymaps exported to " .. out, vim.log.levels.INFO)
end, { desc = "Export keymaps with explanations to docs/keymaps.txt" })

vim.api.nvim_create_user_command("SwitchSourceHeader", function()
  nav.switch_source_header()
end, { desc = "Switch between source and header file" })

vim.api.nvim_create_user_command("GoToBuild", function()
  nav.goto_build_file()
end, { desc = "Open nearest BUILD file" })

vim.api.nvim_create_user_command("GoToProtoDef", function()
  nav.goto_proto_def()
end, { desc = "Open .proto file from *.pb.h include under cursor" })
