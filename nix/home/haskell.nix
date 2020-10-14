{ pkgs, fetchGH, ... }:

let
  ormoluSrc = fetchGH "tweag/ormolu" "dec158c";

  ghcideNixSrc = fetchGH "cachix/ghcide-nix" "7014271";

  easyPS = fetchGH "justinwoo/easy-purescript-nix" "1ec689d";

  haskellOverridez = fetchGH "adetokunbo/haskell-overridez" "v0.10.3.1";

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

    cabal2nix
    styx

    (import haskellOverridez {}).haskell-overridez

    # ormolu code formatter
    # (macOSCaseNameFix (import ormoluSrc { }).ormolu)
    (import ghcideNixSrc {}).ghcide-ghc865
    # (import ghcideNixSrc {}).ghcide-ghc884
    # (import ghcideNixSrc {}).ghcide-ghc8102
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
