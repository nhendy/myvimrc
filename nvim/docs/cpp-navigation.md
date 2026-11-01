# C/C++ and Rust code navigation

`gd`, `gr`, `K`, and rename are plain LSP. What makes them actually resolve is
having the right server running against the right project metadata.

## Rust

Nothing to do per project. `rustaceanvim` starts `rust-analyzer` on any Rust
buffer inside a Cargo workspace.

The binary comes from Homebrew's **keg-only** rustup, whose proxies live in
`/opt/homebrew/opt/rustup/bin` (added to `PATH` by `zsh/zshrc`, and again by
`lua/config/options.lua` so it works no matter how Neovim was launched). Each
proxy resolves the toolchain from the nearest `rust-toolchain.toml`, so a repo
pinned to 1.95 is analysed by 1.95's `rust-analyzer`.

Do **not** `brew install rust`. It puts its own `cargo`/`rustc` at
`/opt/homebrew/bin`, shadowing the proxies and breaking per-project pins.

Jumping into `std` requires the `rust-src` component on each toolchain:

```sh
rustup component add rust-src rust-analyzer --toolchain <toolchain>
```

Extras (buffer-local, Rust only): `qf` code action, `K` hover actions,
`,rr` runnables, `,rd` debuggables, `,rm` expand macro, `,rc` open Cargo.toml.
`,rd` additionally needs `nvim-dap` + the `codelldb` adapter, which are not
installed.

## C/C++

clangd needs a `compile_commands.json`. Without one it guesses flags and most
non-trivial includes fail to resolve.

### CMake

`:CompileCommands` configures into `build/` with
`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`, symlinks the database to the repo root,
and restarts clangd. `CMAKE_EXPORT_COMPILE_COMMANDS=1` is also exported from
`zsh/zshrc`, so ordinary `cmake` invocations emit it too.

### Bazel

clangd cannot read the Bazel action graph, so the database has to be extracted.
This is a **per-repo** change — add it to the repo first, once:

`MODULE.bazel` (bzlmod):

```starlark
bazel_dep(name = "hedron_compile_commands", version = "<version>")
```

`WORKSPACE` (legacy):

```starlark
http_archive(
    name = "hedron_compile_commands",
    url = "https://github.com/hedronvision/bazel-compile-commands-extractor/archive/<commit>.tar.gz",
    strip_prefix = "bazel-compile-commands-extractor-<commit>",
)
load("@hedron_compile_commands//:workspace_setup.bzl", "hedron_compile_commands_setup")
hedron_compile_commands_setup()
```

Then `:BazelCompileCommands` runs `bazel run
@hedron_compile_commands//:refresh_all` at the workspace root and restarts
clangd. Re-run it after build files change meaningfully.

If clangd still misses toolchain headers, add a repo-root `.clangd`:

```yaml
CompilationDatabase: .
```

`--query-driver` is already passed in `lua/config/lsp.lua`; it lets clangd
interrogate the real compiler for its system include paths, which is the usual
fix for "file not found" on standard headers in Bazel repos.

### No build system

`~/.config/clangd/config.yaml` (from `dotfiles/clangd/config.yaml`) supplies
fallback flags — C++20 and background indexing — so standalone files and
header-only projects still resolve. A project's `compile_commands.json` always
wins over it.

### Navigation notes

`,gh` (`:SwitchSourceHeader`) asks clangd via `textDocument/switchSourceHeader`
first, so it handles generated headers and headers that don't sit next to their
source; it falls back to an extension guess when clangd isn't attached.

## Build files

`starpls` attaches to `BUILD`, `BUILD.bazel`, `*.bzl`, `WORKSPACE` and
`MODULE.bazel` (registered as filetype `bzl` in `lua/config/autocmds.lua`).
`neocmake` attaches to `CMakeLists.txt`.

## Keymaps

Global (from `lua/config/keymaps.lua`, exported to `docs/keymaps.txt`):

| Key | Action |
| --- | --- |
| `gd` / `yg` | go to definition |
| `gr` | references |
| `gi` | implementation |
| `K` | hover |
| `qf` | code action |
| `[g` / `]g` | previous / next diagnostic |

Buffer-local, added on `LspAttach`, so they exist only where a server is
running. These are **not** in `docs/keymaps.txt`, which only exports the global
spec table:

| Key | Action |
| --- | --- |
| `,rn` | rename |
| `gy` | type definition |
| `gD` | declaration |
| `<C-s>` (insert) | signature help |
| `,o` / `,O` | document / workspace symbols |
| `,ih` | toggle inlay hints |
| `,lf` | LSP format (`,c` stays vim-codefmt) |

Note: `gr` is bound as a complete action, which shadows Neovim 0.11+'s built-in
`grn`/`gra`/`grr`/`gri` defaults -- they can never fire. That is why rename has
an explicit binding.

## When something doesn't attach

```vim
:checkhealth vim.lsp
:lua =vim.lsp.get_clients({ bufnr = 0 })[1].name
:lua =vim.fn.executable("rust-analyzer")
```

`nvim --headless -c 'lua require("core.selftest").run()' -c 'qa!'` checks the
commands, keymaps and parsers this setup depends on.
