{ pkgs, fetchGH, ... }:

let
  sources = import ../sources.nix;
  easy-ps = import sources.easy-purescript-nix {};
in {

  home.packages = with pkgs.haskellPackages; [
    styx
    # threadscope

    cachix
    # pandoc
    hlint

    hasktags
    hoogle
    stack
    stylish-haskell
    ormolu
    ghcide

    cabal2nix

    # purescript
    easy-ps.purs-0_13_8
    easy-ps.spago
    easy-ps.zephyr
    easy-ps.purty
  ];

  home.file = {
    # ghci
    ".ghci".text = ''
      :set prompt "λ> "
    '';
    # stylish-haskell (obsidian style)
    ".stylish-haskell.yaml".text = ''
      steps:
        - imports:
            align: file
            list_align: after_alias
            long_list_align: inline
            list_padding: 4
            separate_lists: true
        - language_pragmas:
            style: vertical
            align: true
            remove_redundant: true
        - trailing_whitespace: {}
      columns: 110
    '';

  };
}
