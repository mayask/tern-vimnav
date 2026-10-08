# tern-vimnav

[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for [Tern](https://stencil.so/tern): the same `ctrl+h/j/k/l` move between Neovim splits and Tern panes.

- In a pane running `nvim` or `vim`, the key goes through to Vim, which moves between its own splits.
- Anywhere else, Tern moves focus to the pane in that direction.
- At the edge of Vim's splits, Vim sets its title to `tern-nav:<left|down|up|right>`; the plugin sees it and moves Tern's focus on.

## Install

```sh
tern plugin install github.com/mayask/tern-vimnav
```

Bind the keys in Tern's `settings.json` (`~/Library/Application Support/Tern/settings.json` on macOS):

```json
"keybinds": {
  "ctrl+h": "plugin.vimnav.left",
  "ctrl+j": "plugin.vimnav.down",
  "ctrl+k": "plugin.vimnav.up",
  "ctrl+l": "plugin.vimnav.right"
}
```

Tern does not reread `settings.json` edited on disk; restart Tern after editing it.

## Neovim

With [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) (AstroNvim ships it with `<C-h/j/k/l>` mapped), copy [`nvim/tern-navigator.lua`](nvim/tern-navigator.lua) into your lazy.nvim plugin specs, e.g. `~/.config/nvim/lua/plugins/`. It sets smart-splits' `at_edge` to hand off to Tern inside Tern and keeps wrapping elsewhere.

Without smart-splits, any mapping works that moves between windows and, when the window did not change, sets the title to `tern-nav:<direction>` and back (see `tern_move` in that file).

## Notes

- Bound keys no longer reach shells: zsh loses `ctrl+k` (kill line) and `ctrl+j` (accept line) in plain shell panes.
- Movement is directional (`focus_pane:<dir>`); at the outermost pane it stops instead of wrapping.
