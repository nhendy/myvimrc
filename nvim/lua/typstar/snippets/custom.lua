-- Custom typstar autosnippets.
-- Loaded because "custom" is listed in typstar's `opts.snippets.modules`
-- (see lua/plugins/init.lua). typstar finds this file via `require("typstar.snippets.custom")`
-- because ~/.config/nvim/lua is on the runtimepath.
--
-- snip(trigger, expand, insert, condition[, priority[, options]])
--   trigger   : ECMA-regex trigger (e.g. "dint", or "([%w])jj" for a capture)
--   expand    : replacement in fmta() form; <> marks each placeholder
--   insert    : list of nodes filling the <> in order (i(1), i(2), ...; i(0) = final cursor)
--   condition : tp.in_math (inside $...$) or tp.in_markup (outside)
-- All snippets here auto-expand (no trigger key) in the right context.

local tp = require("typstar.autosnippets")
local snip = tp.snip
local math = tp.in_math
local markup = tp.in_markup
local ls = require("luasnip")
local i = ls.insert_node

return {
  -- math, with placeholders: "dint" -> integral_(a)^(b) <cursor>
  snip("dint", "integral_(<>)^(<>) <>", { i(1), i(2), i(0) }, math),

  -- math, no placeholder: "eqv" -> equiv (≡)
  snip("eqv", "equiv", {}, math),

  -- markup (outside math): "dfn" -> bold "Definition." label
  snip("dfn", "*Definition.* ", {}, markup),

  -- capture example: "<letter>vec" -> arrow over the letter, e.g. "avec" -> arrow(a)
  snip("([%a])vec", "arrow(<>)", { tp.cap(1) }, math),
}
