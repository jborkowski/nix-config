{ pkgs, ... }: {
  imports = [ ./emacs.nix ];

  home.extraOutputsToInstall = [ "doc" "info" "devdoc" ];

  home.file.gdbinit = {
    target = ".gdbinit";
    text = ''
      set auto-load safe-path /
    '';
  };

  programs.emacs = {
    enable = true;
    #package = pkgs.emacsGit;
    package = pkgs.emacsGccPgtk;
    
    extraPackages = epkgs: with epkgs; [
      magit

      nyan-mode

      projectile
      helm-projectile
      
      # evil
      evil
      evil-magit
      evil-mc
      evil-leader
      evil-collection
      evil-org
      evil-surround
      evil-nerd-commenter

      git-timemachine

      duplicate-thing
      dumb-jump
      eyebrowse
      ormolu
      nix-haskell-mode
      direnv
      dap-mode
      helm-lsp
      lsp-treemacs
      ob-sql-mode
      ob-rust
      ob-go
      ob-http
      ob-restclient
      ob-ammonite
      org-kindle
      # lsp-haskell
      # flycheck-haskell
      smartparens
      ace-window
      avy
      bash-completion
      csv-mode 
      eglot 
      emojify 
      flymake 
      ghub 
      git-commit 
      graphql-mode 
      hl-todo 
      htmlize 
      hydra 
      jsonrpc 
      lsp-ui 
      lv 
      magit 
      sbt-mode 
      scala-mode 
      transient 
      treepy 
      which-key 
      with-editor 
      yasnippet-snippets 
      helm-ag 
      helm-ag-r 
      helm-etags-plus
      zoom-window 
      zoom 
      yasnippet-classic-snippets 
      yaml-mode 
      wttrin 
      terraform-mode 
      terminal-here 
      string-edit 
      stack-mode 
      react-snippets 
      purescript-mode 
      org-bullets 
      nyan-mode 
      neotree
      multiple-cursors 
      moe-theme 
      keyfreq 
      json-mode 
      highlight-symbol
      goto-chg 
      exec-path-from-shell
      eno
      encourage-mode 
      elmacro
      ebdb
      company
      company-lsp 
      auto-package-update
      auto-highlight-symbol 
      # vannoying-arrows-mode 
      ag
    ];

    init.enable = true;
  };
}
