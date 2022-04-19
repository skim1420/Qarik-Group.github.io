{
   system ? builtins.currentSystem
 , pkgs ? import <nixpkgs> { inherit system; }
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    bundler
    bundix
  ];
  shellHook = ''
    bundler package --no-install --path vendor
    bundix
    rm -rf .bundle vendor
  '';
}
