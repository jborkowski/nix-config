{ pkgs, ... }:

let
 extensions = [
    {
      name = "haskell";
      publisher = "haskell";
      version = "1.1.0";
      sha256 = "1wg06lyk0qn9jd6gi007sg7v0z9z8gwq7x2449d4ihs9n3w5l0gb";
    }
 ];
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      justusadam.language-haskell
      vscodevim.vim
      scalameta.metals
      # scala-lang
      redhat.vscode-yaml
  
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace ( extensions ) ;
    userSettings = {
      "terminal.integrated.fontFamily" = "Hack";
      "editor.minimap.enabled" = false;
      "explorer.confirmDelete" = false;
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'";
      # "editor.fontLigatures" = "Fira Code";
      "editor.tabSize" = 2;
    };
  };
}
