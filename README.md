# nvim-kitty-navigator

This is a pure lua port of
[vim-kitty-navigator](https://github.com/knubie/vim-kitty-navigator).
When combined with a set of kitty key bindings and kittens, the plugin allows
you to navigate between nvim and kitty splits using a consistent mappings.

**NOTE**: This requires kitty v0.13.1 or higher.

## Usage

This plugin provides the following mappings which allow you to move between
Vim panes and kitty splits seamlessly.

- `<ctrl-h>` => Left
- `<ctrl-j>` => Down
- `<ctrl-k>` => Up
- `<ctrl-l>` => Right

## Installation

packer.nvim:

```vim
use {
  'hermitmaster/nvim-kitty-navigator',
  run = './install',
  config = function()
    require('nvim-kitty-navigator').setup {}
  end
}
```

The `pass_keys.py` kitten is used to intercept keybindings defined in your kitty
conf and "pass" them through to vim when it is focused. The
`neighboring_window.py` kitten is used to send the `neighboring_window` command
(e.g. `kitten @ neighboring_window.py right`) from vim when you've reached the
last pane and are ready to switch to a non-vim kitty window.

#### Add this snippet to kitty.conf

Add the following to your `~/.config/kitty/kitty.conf` file:

```conf
allow_remote_control yes
map ctrl+j kitten pass_keys.py neighboring_window bottom ctrl+j
map ctrl+k kitten pass_keys.py neighboring_window top    ctrl+k
map ctrl+h kitten pass_keys.py neighboring_window left   ctrl+h
map ctrl+l kitten pass_keys.py neighboring_window right  ctrl+l
```

By default `vim-kitty-navigator` uses the name of the current foreground process
to detect when it is in a (neo)vim session or not. If that doesn't work, (or if
you want to support applications other than vim) you can supply a fourth
optional argument to the `pass_keys.py` call in your `kitty.conf` file to match
the process name.

```conf
allow_remote_control yes
map ctrl+j kitten pass_keys.py neighboring_window bottom ctrl+j "^.* - nvim$"
map ctrl+k kitten pass_keys.py neighboring_window top    ctrl+k "^.* - nvim$"
map ctrl+h kitten pass_keys.py neighboring_window left   ctrl+h "^.* - nvim$"
map ctrl+l kitten pass_keys.py neighboring_window right  ctrl+l "^.* - nvim$"
```

#### Make kitty listen to control messages

Start kitty with the `listen-on` option so that vim can send commands to it.

```
# Linux only:
kitty --single-instance --listen-on unix:@mykitty

# Other unix systems:
kitty --single-instance --listen-on unix:/tmp/mykitty
```
