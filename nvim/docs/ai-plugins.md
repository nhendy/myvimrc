# AI plugins

This Neovim config runs a few AI tools with distinct, non-overlapping jobs. The
golden rule: **only one inline "ghost text" engine at a time** — two engines
drawing into the same virtual-text namespace flicker and cancel each other out.

| Plugin | Role | Inline ghost text? |
|--------|------|--------------------|
| **supermaven-nvim** | As-you-type inline completion | ✅ **the** ghost-text engine |
| **claudecode.nvim** | Bridge to the Claude Code CLI (diffs, send selection, add context) | — |
| **avante.nvim** | In-editor AI chat / agent | — |
| **copilot.lua** | Kept **only** as Avante's `auto_suggestions_provider` | ❌ disabled |

All specs live in [`lua/plugins/init.lua`](../lua/plugins/init.lua) (pinned to exact
commits, `cond = not env.is_vscode`). Keymaps live in
[`lua/config/keymaps.lua`](../lua/config/keymaps.lua) under `category = "ai"` and are
mirrored into [`keymaps.txt`](./keymaps.txt) via `:KeymapsExport`.

---

## Supermaven — inline completion

Fast AI autocomplete rendered as grayed-out "ghost text" you accept as you type
(replaces copilot.lua's inline suggestions). Its `sm-agent` binary is downloaded
automatically on first use into `~/.supermaven/`.

**Accept keys** (deliberately mirror the old copilot bindings — no muscle-memory change):

| Key | Action |
|-----|--------|
| `<M-l>` | Accept full suggestion |
| `<M-w>` | Accept one word |
| `<C-]>` | Dismiss / clear suggestion |

**Commands:** `:SupermavenStatus`, `:SupermavenToggle`, `:SupermavenStart`,
`:SupermavenStop`, `:SupermavenRestart`.

**Tier:** runs on the **free tier** by default — run `:SupermavenUseFree` if prompted,
or `:SupermavenUsePro` to sign in to Pro.

### Switching back to copilot inline suggestions

Only one engine at a time. To revert to copilot ghost text:

1. In `lua/plugins/init.lua`, set copilot's `suggestion.enabled = true`.
2. Remove (or disable via `cond = false`) the `supermaven-inc/supermaven-nvim` spec.

Copilot's own accept keys are already `<M-l>` / `<M-w>` / `<M-j>` (accept line), so
the switch is seamless.

---

## claudecode.nvim — Claude Code ↔ editor

Runs a WebSocket/MCP server inside Neovim (same protocol as the VS Code / JetBrains
extensions). It writes a lock file to `~/.claude/ide/[port].lock`; the `claude` CLI
auto-discovers it and connects, then drives MCP tools for selection context, adding
files, and applying diffs directly in the editor.

- **Requires:** the `claude` CLI on `PATH` (currently `~/.local/bin/claude`).
- **Terminal provider:** `snacks` (via the `folke/snacks.nvim` dependency), right
  split at 30% width. Snacks is set up bare (`opts = {}`) — no other snacks modules
  are enabled.
- **Loads lazily** on any `ClaudeCode*` command (see the `cmd` list in the spec).

**Keymaps** (leader is `,`, so `<leader>a…` = `,a…`):

| Key | Mode | Action |
|-----|------|--------|
| `,ac` | n | Toggle Claude Code |
| `,af` | n | Focus Claude Code |
| `,ar` | n | Resume (`--resume`) |
| `,aC` | n | Continue (`--continue`) |
| `,am` | n | Select model |
| `,ab` | n | Add current buffer to context |
| `,as` | **v** | Send visual selection to Claude |
| `,aa` | n | Accept proposed diff (or `:w`) |
| `,ad` | n | Deny proposed diff (or `:q`) |

> Note: `,a` is also the ripgrep-word search and `,ae` toggles Avante, so pressing
> `,a` alone waits `timeoutlen` before firing. That's expected — the `,a?` sequences
> just extend the existing prefix.

**Diff flow:** when Claude proposes an edit, a `(proposed)` diff buffer opens — accept
with `,aa`/`:w`, reject with `,ad`/`:q`. `:ClaudeCodeCloseAllDiffs` clears leftovers.
If you ever add an auto-save plugin, exclude buffers named `*(proposed)*` so it can't
auto-accept diffs.

**File-tree "add file":** the plugin's `:ClaudeCodeTreeAdd` only integrates with
nvim-tree/neo-tree/oil/mini.files/netrw — **not NERDTree** — so it's intentionally not
mapped here. Use `,ab` or `:ClaudeCodeAdd <path>` instead.

---

## Maintenance

- **Update** a plugin: bump its `commit` in `lua/plugins/init.lua` (or `:Lazy update`,
  then copy the resolved SHA back into the spec to keep the pin authoritative).
- **Regenerate** `docs/keymaps.txt` after changing any `M.specs` entry: `:KeymapsExport`.
- **Health check:** `:checkhealth claudecode` (verifies CLI, server, connection) and
  `:SupermavenStatus`.

## Pinned versions

| Plugin | Commit |
|--------|--------|
| coder/claudecode.nvim | `2390c6e45c4789072c293ac69de051d169668b29` |
| folke/snacks.nvim | `882c996cf28183f4d63640de0b4c02ec886d01f2` |
| supermaven-inc/supermaven-nvim | `07d20fce48a5629686aefb0a7cd4b25e33947d50` |

(Authoritative pins live in the specs + `lazy-lock.json`; this table is a snapshot.)
