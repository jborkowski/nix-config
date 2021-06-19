{ pkgs, ... }:

let
 extensions = [
    {
    name = "project-manager";
    publisher = "alefragnani";
    version = "12.1.0";
    sha256 = "1zrgjz1nh0r70xfbcki8bwi76gsydfjpdij7axv9i97xd6clm03x";
  }
  {
    name = "vscode-tlaplus";
    publisher = "alygin";
    version = "1.5.4";
    sha256 = "0mf98244z6wzb0vj6qdm3idgr2sr5086x7ss2khaxlrziif395dx";
  }
  {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.7";
    sha256 = "0mralimyzhyp4x9q98x3ck64ifbjqdp8cxcami7clvdvkmf8hxhf";
  }
  {
    name = "Nix";
    publisher = "bbenoist";
    version = "1.0.1";
    sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
  }
  {
    name = "bracket-pair-colorizer";
    publisher = "CoenraadS";
    version = "1.0.61";
    sha256 = "0r3bfp8kvhf9zpbiil7acx7zain26grk133f0r0syxqgml12i652";
  }
  {
    name = "reasonml";
    publisher = "freebroccolo";
    version = "1.0.38";
    sha256 = "1nay6qs9vcxd85ra4bv93gg3aqg3r2wmcnqmcsy9n8pg1ds1vngd";
  }
  {
    name = "go";
    publisher = "golang";
    version = "0.25.1";
    sha256 = "0v0qxa9w2r50h5iivzyzlbznb8b9a30p1wbfxmxp83kkv4vicdb4";
  }
  {
    name = "haskell";
    publisher = "haskell";
    version = "1.4.0";
    sha256 = "1jk702fd0b0aqfryixpiy6sc8njzd1brd0lbkdhcifp0qlbdwki0";
  }
  {
    name = "language-haskell";
    publisher = "justusadam";
    version = "3.4.0";
    sha256 = "0ab7m5jzxakjxaiwmg0jcck53vnn183589bbxh3iiylkpicrv67y";
  }
  {
    name = "magit";
    publisher = "kahole";
    version = "0.6.13";
    sha256 = "0n8g201rikdfm7czrckc2czrzwvkqm2rj06pxdja04hlbm0qc9zx";
  }
  {
    name = "brittany";
    publisher = "MaxGabriel";
    version = "0.0.9";
    sha256 = "1cfbzc8fmvfsxyfwr11vnszvirl47zzjbjp6rihg5518gf5wd36k";
  }
  {
    name = "theme-monokai-pro-vscode";
    publisher = "monokai";
    version = "1.1.19";
    sha256 = "0skzydg68bkwwwfnn2cwybpmv82wmfkbv66f54vl51a0hifv3845";
  }
  {
    name = "cmake-tools";
    publisher = "ms-vscode";
    version = "1.7.3";
    sha256 = "0jisjyk5n5y59f1lbpbg8kmjdpnp1q2bmhzbc1skq7fa8hj54hp9";
  }
  {
    name = "nimvscode";
    publisher = "nimsaem";
    version = "0.1.21";
    sha256 = "09d2x334dy5i74q4fpxas3pd8nwnamc5zca554aa895cff9f3myp";
  }
  {
    name = "nunjucks";
    publisher = "ronnidc";
    version = "0.3.0";
    sha256 = "1xdh3d6azj9al6dcmz0jmivixlz4a3qxcm09x17c0w0f6issmbdf";
  }
  {
    name = "rust";
    publisher = "rust-lang";
    version = "0.7.8";
    sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
  }
  {
    name = "fish-vscode";
    publisher = "skyapps";
    version = "0.2.1";
    sha256 = "0y1ivymn81ranmir25zk83kdjpjwcqpnc9r3jwfykjd9x0jib2hl";
  }
  {
    name = "vim";
    publisher = "vscodevim";
    version = "1.20.3";
    sha256 = "0za138wvp60dhz9abb0j4ida8jk7mzzpj8wga9ihc1cfxp8ad8an";
  }
  {
    name = "clang-format";
    publisher = "xaver";
    version = "1.9.0";
    sha256 = "0bwc4lpcjq1x73kwd6kxr674v3rb0d2cjj65g3r69y7gfs8yzl5b";
  }
 ];
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      justusadam.language-haskell
      # haskell.haskell
      vscodevim.vim
      scalameta.metals
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      # scala-lang
      redhat.vscode-yaml
  
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace ( extensions ) ;
    userSettings = {
      "window.zoomLevel"= -1;
      "terminal.integrated.fontFamily" = "Hack";
      "editor.minimap.enabled" = false;
      "explorer.confirmDelete" = false;
      "editor.fontSize" = 10;
      "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'";
      "editor.fontLigatures" = "Fira Code";
      "editor.tabSize" = 2;
      "vim.useSystemClipboard" = true;
      "[haskell]" = {
        "editor.defaultFormatter" = "haskell.haskell";
      };
      "terminal.integrated.fontSize"= 10;
    };
  };
}
