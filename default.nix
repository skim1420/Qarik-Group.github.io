{ pkgs ? import <nixpkgs> {}, ... }:

let
  gems = pkgs.bundlerEnv {
    name = "qarik-group.github.io-gems";
    ruby = pkgs.ruby;
    gemdir = ./.;
  };
in
pkgs.stdenv.mkDerivation({
  name = "qarik-group.github.io";
  src = ./.;

  buildInputs = with pkgs; [
    gems
    gems.wrappedRuby
  ];

  buildPhase = ''
    bundle exec jekyll build
  '';

  installPhase = ''
    mkdir -p $out
    cp -R _site/* $out
  '';
})
