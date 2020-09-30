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
    package = pkgs.emacsGit;
    #package = pkgs.emacsGccPgtk;
    
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
      magit 
      scala-mode 
      transient 
      treepy 
      which-key 
      with-editor 
      yasnippet-snippets 
      helm-ag 
      helm-ag-r 
      zoom-window 
      zoom 
      yaml-mode 
      wttrin 
      string-edit 
      purescript-mode 
      org-bullets 
      nyan-mode 
      multiple-cursors 
      moe-theme 
      keyfreq 
      json-mode 
      highlight-symbol
      exec-path-from-shell
      eno
      encourage-mode 
      elmacro
      ebdb
      company
      company-lsp 
      annoying-arrows-mode 
      ag
    ];

    init.enable = true;
  };
}
