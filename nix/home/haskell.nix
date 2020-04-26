{ pkgs, fetchGH, ... }:

let
  ormoluSrc = fetchGH "tweag/ormolu" "683cbea";

  # 'cachix use hercules-ci' before 'home-manager switch'
  ghcideNixSrc = fetchGH "cachix/ghcide-nix" "c940edd";

  # https://github.com/haskell/cabal/issues/4739#issuecomment-359209133
  macOSCaseNameFix = drv:
   pkgs.haskell.lib.appendConfigureFlag drv "--ghc-option=-optP-Wno-nonportable-include-path";
in {
  home.packages = with pkgs.haskellPackages; [

    # Some commonly used tools
    cachix
    pandoc
    hlint

    hoogle
    stylish-haskell

    # ormolu code formatter
    (macOSCaseNameFix (import ormoluSrc { }).ormolu)
    # ghcide : disabling, because uttery broken and unreliable
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
            long_list_align: after_alias
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
