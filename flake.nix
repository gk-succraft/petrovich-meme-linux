{
  description = "Petrovich meme sticker picker for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        runtimeDeps = with pkgs; [
          bash
          feh
          xclip
          wl-clipboard
          xdotool
        ];

        stickerPicker = pkgs.stdenv.mkDerivation {
          pname = "petrovich-meme-linux";
          version = "1.0.0";

          src = ./.;

          dontBuild = true;

          installPhase = ''
            mkdir -p $out/bin
            cp sticker-picker $out/bin/sticker-picker
            chmod +x $out/bin/sticker-picker
          '';

          nativeBuildInputs = with pkgs; [ makeWrapper ];

          postFixup = ''
            wrapProgram $out/bin/sticker-picker \
              --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps}
          '';
        };
      in
      {
        packages.default = stickerPicker;

        apps.default = {
          type = "app";
          program = "${stickerPicker}/bin/sticker-picker";
        };

        devShells.default = pkgs.mkShell {
          packages = runtimeDeps ++ (with pkgs; [ git direnv ]);
          STICKER_DIR = "$PWD/stickers";
          shellHook = ''
            mkdir -p "$STICKER_DIR"
            echo "petrovich-meme-linux dev shell — stickers: $STICKER_DIR"
          '';
        };
      });
}
