# petrovich-meme-linux

Sticker picker for Linux — grid of memes, press `1` to copy to clipboard, paste anywhere.

## Install

```bash
# deps
sudo apt install feh xclip xdotool

# optional: symlink to PATH
ln -s "$(pwd)/sticker-picker" ~/.local/bin/sticker-picker
```

## Usage

```bash
./sticker-picker
```

- Arrow keys / mouse — select sticker
- `1` — copy to clipboard and close
- `q` / `Esc` — quit

## Hotkey

Bind `sticker-picker` to a keyboard shortcut in your DE/WM settings (e.g. `Ctrl+Shift+S`).

## Env vars

| Variable | Default | Description |
|----------|---------|-------------|
| `STICKER_DIR` | `./stickers` | Path to sticker images |
| `STICKER_PICKER_TITLE` | `Stickers` | Window title |
