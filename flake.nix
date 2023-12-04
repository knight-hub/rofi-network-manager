{
  description = "rofi network manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "rofi-nm";
      version = "0.0.1";

      src = ./.;

      nativeBuildInputs = [
        pkgs.makeWrapper
      ];

      installPhase = ''
        mkdir -p $out/bin
        cp rofi-network-manager.sh $out/bin/rofi-nm
        cp rofi-network-manager.conf $out/bin
        cp rofi-network-manager.rasi $out/bin
      '';
      postFixup = ''
        wrapProgram $out/bin/rofi-nm \
        --set PATH ${pkgs.lib.makeBinPath (with pkgs; [ uutils-coreutils-noprefix networkmanager gnused gnugrep gawk qrencode rofi-wayland imagemagick ])}
      '';
    });
  };
}
