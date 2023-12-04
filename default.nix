{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation (finalAttrs: {
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
})
