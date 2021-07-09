{ pkgs, fetchGH, ... }:

let
  sources = import ../../sources.nix;
  easy-ps = import sources.easy-purescript-nix {};
  zghc = pkgs.haskellPackages.ghc.withPackages (hp: with hp; [ pkgs.zlib.dev ]);
in {

  home.packages = with pkgs.haskellPackages; [
    styx
    cabal2nix
    nix-tree

    cabal-install
    # haskell-language-server
    zghc
    hlint

    hasktags
    hoogle
    stack
    stylish-haskell
    # thradscope
    # ormolu

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
