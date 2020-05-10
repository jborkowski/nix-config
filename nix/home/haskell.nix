{ pkgs, fetchGH, ... }:

let
  ormoluSrc = fetchGH "tweag/ormolu" "683cbea";

  # 'cachix use hercules-ci' before 'home-manager switch'
  ghcideNixSrc = fetchGH "cachix/ghcide-nix" "c940edd";

  easyPS = fetchGH "justinwoo/easy-purescript-nix" "d4879bf";

  # https://github.com/haskell/cabal/issues/4739#issuecomment-359209133
  macOSCaseNameFix = drv:
   pkgs.haskell.lib.appendConfigureFlag drv "--ghc-option=-optP-Wno-nonportable-include-path";
in {

  home.packages = with pkgs.haskellPackages; [

    # Some commonly used tools
    cachix
    pandoc
    hlint

    hasktags
    hoogle
    stack
    stylish-haskell

    (import easyPS {}).purs-0_13_6
    (import easyPS {}).spago
    (import easyPS {}).zephyr
    (import easyPS {}).purty

    # ormolu code formatter
    # (macOSCaseNameFix (import ormoluSrc { }).ormolu)
    (import ghcideNixSrc {}).ghcide-ghc865
  ];

  home.file = {
    # ghci
    ".ghci".text = ''
      :set prompt "λ> "
    '';
    # stylish-haskell (obsidian style)
    # I now use ormolu; retaining this config for legacy purposes.
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
