# petrovich-meme-linux

Sticker picker for Linux — grid of memes, press `1` to copy to clipboard, paste anywhere.

## Install

### One-liner (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/gk-succraft/petrovich-meme-linux/main/install.sh | bash
```

Then run:

```bash
petrovich-meme
```

### Nix / NixOS

```bash
nix run github:gk-succraft/petrovich-meme-linux
```

### Dev shell

```bash
nix develop
./petrovich-meme
```

## Usage

```bash
petrovich-meme
```

- Arrow keys / mouse — select sticker
- `1` — copy to clipboard and close
- `q` / `Esc` — quit

## Adding stickers

Drop PNG / JPG / GIF / WebP files into `~/Pictures/stickers/`.

When installed via nix, stickers live in `~/.local/share/petrovich-meme/stickers/`.

## Hotkey

Bind `petrovich-meme` to a keyboard shortcut in your DE/WM settings (e.g. `Ctrl+Shift+S`).

## Env vars

| Variable | Default | Description |
|----------|---------|-------------|
| `STICKER_DIR` | `./stickers` (repo) / `$XDG_DATA_HOME/petrovich-meme/stickers` (installed) | Path to sticker images |
| `STICKER_PICKER_TITLE` | `Stickers` | Window title |
