# petrovich-meme-linux

Sticker picker for Linux — grid of memes, press `1` to copy to clipboard, paste anywhere.

## Install

### Nix / NixOS

```bash
nix run github:user/petrovich-meme-linux     # run directly
nix profile install github:user/petrovich-meme-linux  # install
```

Dev shell (if cloned):

```bash
nix develop
```

### Debian / Ubuntu

```bash
sudo apt install feh xclip xdotool
ln -s "$(pwd)/sticker-picker" ~/.local/bin/sticker-picker
```

### Other distros

Install the equivalents of `feh`, `xclip` (or `wl-clipboard` for Wayland), `xdotool`.

## Usage

```bash
./sticker-picker
```

- Arrow keys / mouse — select sticker
- `1` — copy to clipboard and close
- `q` / `Esc` — quit

## Adding stickers

Drop PNG / JPG / GIF / WebP files into the `stickers/` directory.

When installed via nix, stickers live in `~/.local/share/petrovich-meme/stickers/`.

## Hotkey

Bind `sticker-picker` to a keyboard shortcut in your DE/WM settings (e.g. `Ctrl+Shift+S`).

## Env vars

| Variable | Default | Description |
|----------|---------|-------------|
| `STICKER_DIR` | `./stickers` (repo) / `$XDG_DATA_HOME/petrovich-meme/stickers` (installed) | Path to sticker images |
| `STICKER_PICKER_TITLE` | `Stickers` | Window title |
