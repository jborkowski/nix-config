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
      "editor.minimap.enabled" = false ;
    };
  };
}


# # { pkgs, ... }:

# let
#   extensions = (with pkgs.vscode-extensions; [
#       # Make it work with a remote that is also running NixOS.
#       # You need to launch code this way to make it work on a NixOS remote, or
#       # else manually patch the remote by linking node (12) to ~/.vscode-server/bin/*/
#       ms-vscode-remote.remote-ssh
#     ])
#     # ~/.nix-defexpr/channels/nixpkgs/pkgs/misc/vscode-extensions/update_installed_exts.sh | tee nix/extensions.nix
#     ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions.nix).extensions;
#   vscode-with-extensions = pkgs.vscode-with-extensions.override {
#       vscodeExtensions = extensions;
#   };
# in {

#   program.vs

# }


# # { pkgs, ... }:

# # {
# #   vscode-with-extensions..override = {
  
# #     vscodeExtensions = with pkgs.vscode-extensions; [
# #       bbenoist.Nix
# #       #haskell.haskell
# #       vscodevim.vim
# #       scalameta.metals
# #       scala-lang
# #       redhat.vscode-yaml
# #     ];
# #     userSettings = {
# #       "terminal.integrated.fontFamily" = "Hack";
# #       "editor.minimap.enabled" = false ;
# #     };
# #   };
# # }


# # { pkgs, ... }:

# # let
# #   vscode-with-extensions = pkgs.vscode-with-extensions.override {
# #     vscodeExtensions = with pkgs.vscode-extensions; [
# #       bbenoist.Nix
# #     ] ++ [
# #       hls
# #     ];
# #   };
# # in

# # {
# #   environment.systemPackages = [
# #     vscode-with-extensions
# #   ];
# # }