{ pkgs, ... }:

let
  sources = import ../../sources.nix;
  nurpkgs = import sources.nixpkgs { };
  nurNoPkgs = import sources.NUR { inherit pkgs nurpkgs; };
  neuron-mode = epkgs: epkgs.trivialBuild rec {
    pname = "neuron-mode";
    version = "2020-09-22";
    
    dontBuild = true;

    src = pkgs.fetchFromGitHub {
      owner = "felko";
      repo = pname;
      rev = "f7bfb7685787eb68691beb11466182de3427a8da";
      sha256 = "1wvi1apnsxmlc93lnhgkrvxcb9b3d13sr722lzwjr0sv1vjp8gnq";
    };

   # packageRequires = [ epkgs.async epkgs.evil ];
  };
in
{
  imports = [ nurNoPkgs.repos.rycee.hmModules.emacs-init ];

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    ispell
    aspell
    aspellDicts.en-computers
    aspellDicts.en
    aspellDicts.en-science
  ];


  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    prelude = ''
      ;; nyancut flying around :)
      (nyan-mode 1)

;;      (key-chord-mode 1)

      ;; Write backups to ~/.emacs.d/backup/
      (setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
            backup-by-copying      t  ; Don't de-link hard links
            version-control        t  ; Use version numbers on backups
            delete-old-versions    t  ; Automatically delete excess backups:
            kept-new-versions      20 ; how many of the newest versions to keep
            kept-old-versions      5) ; and how many of the old

      (keyfreq-mode 1)
      (keyfreq-autosave-mode 1)
     
      ;; UI tweaks
      (desktop-save-mode 0)
      (tool-bar-mode 0)
      (menu-bar-mode 0)
      ;; (toggle-frame-fullscreen)
      (scroll-bar-mode 0)
      (blink-cursor-mode 0)

      (defalias `yes-or-no-p `y-or-n-p)
      
      (setq org-directory "~/Nextcloud/org")
      
      ;; Set up fonts early.
      (set-face-attribute 'default
                          nil
                          :height 90
                          :family "Fira Code")
      
      (set-face-attribute 'variable-pitch
                          nil
                          :family "DejaVu Sans")

      ;; Always show line and column number in the mode line.
      (line-number-mode)
      (column-number-mode)

      ;; Enable some features that are disabled by default.
      ;; (put 'narrow-to-region 'disabled nil)

      (setq-default indent-tabs-mode nil
                    tab-width 2
                    c-basic-offset 4)

      (prefer-coding-system 'utf-8)


      (global-set-key (kbd "M-]") 'next-buffer)
      (global-set-key (kbd "M-[") 'previous-buffer)

      (global-company-mode)

      (setq wttrin-default-cities '("Warsaw"))
      (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

      ;; auto-refresh all buffers when files have changed on disk
      (global-auto-revert-mode t)
      (column-number-mode 1)
      (global-linum-mode 1)
    '';

    usePackage = {
      dumb-jump = {
        enable = true;
      };

      duplicate-thing = {
        enable = true;
      };

      nyan-mode = {
        enable = true;
        command = [ "nyan-mode" ];
        config = ''
          (setq nyan-wavy-trail t)
        '';
      };

      magit = {
        enable = true;
        bind = {
          "C-x g" = "magit-status";
        };
        config = ''
          (add-to-list 'git-commit-style-convention-checks
                       'overlong-summary-line)
        '';
      };

      multiple-cursors = {
        enable = true;
        bind = {
          "C-S-c C-S-c" = "mc/edit-lines";
          "C-c m" = "mc/mark-all-like-this";
          "C->" = "mc/mark-next-like-this";
          "C-<" = "mc/mark-previous-like-this";
        };
      };

      helm = {
        enable = true;
        bind = {
          "M-x"     = "helm-M-x";
          "C-x b"   = "helm-mini";
          "C-x C-b" = "helm-buffers-list";
          "C-x r l" = "helm-bookmarks";
        };
      };

      helm-config = {
        enable = true;
        demand = true;
        after = [ "helm" ];
      };

      helm-swoop = {
        enable = true;
        bind = {
          "C-s" = "helm-swoop";
          "C-r" = "helm-swoop";
        };
      };

      moe-theme = {
        enable = true;
        config = "(load-theme 'moe-dark t)";
      };

      haskell-mode = {
        enable = true;
      };

      which-key = {
        enable = true;
        command = [ "which-key-mode" ];
        diminish = [ "which-key-mode" ];
        defer = 2;
        config = "(which-key-mode)";
      };

      all-the-icons = {
        enable = true;
      };

      undo-tree = {
        enable = true;
        demand = true;
        diminish = [ "undo-tree-mode" ];
        command = [ "global-undo-tree-mode" ];
        config = ''
          (setq undo-tree-visualizer-relative-timestamps t
                undo-tree-visualizer-timestamps t)
          (global-undo-tree-mode)
        '';
      };

      neuron-mode = {
        enable = true;
        package = neuron-mode;
      };

   #   eyebrowse = {
   #     enable = true;
   #     demand = true;
   #     command = [
   #       "eyebrowse-mode"
   #     ];
   #     bind = {
   #       "<C-tab>" = "eyebrowse-next-window-config";
   #       "<C-iso-lefttab>" = "eyebrowse-prev-window-config";
   #     };
   #     init = builtins.readFile ./emacs-inits/eyebrowse.el;
   #   };

      nginx-mode.enable = true;

      vterm = {
        enable = true;
        command = [ "vterm" ];
      };

      markdown-mode = {
        enable = true;
        mode = [
          ''"\\.mdwn\\'"''
          ''"\\.markdown\\'"''
          ''"\\.md\\'"''
        ];
      };

      nix-mode = {
        enable = true;
        mode = [ ''"\\.nix\\'"'' ];
        hook = [ "(nix-mode . subword-mode)" ];
      };

      ripgrep = {
        enable = true;
        command = [ "ripgrep-regexp" ];
      };

      org = {
        enable = true;
        bind = {
          "C-c c" = "org-capture";
          "C-c a" = "org-agenda";
          "C-c l" = "org-store-link";
          "C-c b" = "org-switchb";
        };
        hook = [
          ''
            (org-mode
             . (lambda ()
                 (add-hook 'completion-at-point-functions
                           'pcomplete-completions-at-point nil t)))
          ''
        ];
        config = ''
          ;; Some general stuff.
          (setq org-reverse-note-order t
                org-use-fast-todo-selection t
                org-adapt-indentation nil
                org-hide-emphasis-markers t)
          ;;(setq org-tag-alist rah-org-tag-alist)
          ;; Refiling should include not only the current org buffer but
          ;; also the standard org files. Further, set up the refiling to
          ;; be convenient with IDO. Follows norang's setup quite closely.
          (setq org-refile-targets '((nil :maxlevel . 2)
                                     (org-agenda-files :maxlevel . 2))
                org-refile-use-outline-path t
                org-outline-path-complete-in-steps nil
                org-refile-allow-creating-parent-nodes 'confirm)
          ;; Add some todo keywords.
          (setq org-todo-keywords
                '((sequence "TODO(t)"
                            "STARTED(s!)"
                            "WAITING(w@/!)"
                            "DELEGATED(@!)"
                            "|"
                            "DONE(d!)"
                            "CANCELED(c@!)")))
          ;; Setup org capture.
          ;; (setq org-default-notes-file (rah-org-file "capture"))
          (setq org-default-notes-file (concat org-directory "/inbox.org"))
          ;; Active Org-babel languages
          (org-babel-do-load-languages 'org-babel-load-languages
                                       '((plantuml . t)
                                         (http . t)
                                         (dot . t)
                                         (restclient . t)
                                         (R . t)
                                         (sql . t)
                                         (shell . t)))
          ;; Unfortunately org-mode tends to take over keybindings that
          ;; start with C-c.
          (unbind-key "C-c SPC" org-mode-map)
          (unbind-key "C-c w" org-mode-map)
          (define-advice org-set-tags-command (:around (fn &rest args) my-counsel-tags)
            "Forward to `counsel-org-tag' unless given non-nil arguments."
            (if (remq nil args)
                (apply fn args)
              (counsel-org-tag)))
          (setq org-image-actual-width 400)
          (setq org-extend-today-until 4)
          (setq org-export-backends (quote (ascii html icalendar latex md odt)))
          ;; https://old.reddit.com/r/orgmode/comments/hg8qik/weird_joined_lines_bug/fw73kml/
          (add-hook 'org-capture-prepare-finalize-hook 'add-newline-at-end-if-none)
        '';
      };

      org-bullets.enable = true;

      # org-super-agenda = {
      #   enable = true;
      #   after = [ "org" ];
      #   config = ''
      #     (org-super-agenda-mode t)
      #     (setq org-super-agenda-groups '((:auto-parent t)))
      #   '';
      # };

      org-habit = {
        enable = true;
        after = [ "org" ];
        # defer = true;
        config = ''
          ;; for using with Orgzly
          (setq org-log-into-drawer "LOGBOOK")
        '';
      };

      org-agenda = {
        enable = true;
        after = [ "org" ];
        defer = true;
        config = ''
          ;; Set up agenda view.
          ;; org-agenda-files (rah-all-org-files)
          (setq org-agenda-files
                (list
                 (concat org-directory "/inbox.org")
                 (concat org-directory "/gtd.org")))
          (setq org-agenda-span 5
                org-deadline-warning-days 14
                org-agenda-show-all-dates t
                org-agenda-skip-scheduled-id-done t
                org-agenda-start-on-weekday nil)
        '';
      };

      ob-http = {
        enable = true;
        after = [ "org" ];
        defer = true;
      };

      ob-plantuml = {
        enable = true;
        after = [ "org" ];
        defer = true;
      };

      org-table = {
        enable = true;
        after = [ "org" ];
        command = [ "orgtbl-to-generic" ];
        hook = [
          # For orgtbl mode, add a radio table translator function for
          # taking a table to a psql internal variable.
          ''
            (orgtbl-mode
             . (lambda ()
                 (defun rah-orgtbl-to-psqlvar (table params)
                   "Converts an org table to an SQL list inside a psql internal variable"
                   (let* ((params2
                           (list
                            :tstart (concat "\\set " (plist-get params :var-name) " '(")
                            :tend ")'"
                            :lstart "("
                            :lend "),"
                            :sep ","
                            :hline ""))
                          (res (orgtbl-to-generic table (org-combine-plists params2 params))))
                     (replace-regexp-in-string ",)'$"
                                               ")'"
                                               (replace-regexp-in-string "\n" "" res))))))
          ''
        ];
        config = ''
          (unbind-key "C-c SPC" orgtbl-mode-map)
          (unbind-key "C-c w" orgtbl-mode-map)
        '';
        extraConfig = ''
          :functions org-combine-plists
        '';
      };

      org-capture = {
        enable = true;
        after = [ "org" ];
        config = ''
          (setq org-capture-templates `(("t" "Todo [inbox]" entry
                                         (file+headline ,(concat org-directory "/inbox.org") "Tasks")
                                         "* TODO %i%?")
                                        ("T" "Tickler" entry
                                         (file+headline ,(concat org-directory "/tickler.org") "Tickler")
                                         "* %i%? \n %U")))
        '';
      };

      org-clock = {
        enable = true;
        after = [ "org" ];
        config = ''
          (setq org-clock-rounding-minutes 5
                org-clock-out-remove-zero-time-clocks t)
        '';
      };

      org-duration = {
        enable = true;
        after = [ "org" ];
        config = ''
          ;; I always want clock tables and such to be in hours, not days.
          (setq org-duration-format (quote h:mm))
        '';
      };

      org-superstar = {
        enable = true;
        hook = [ "(org-mode . org-superstar-mode)" ];
      };

      org-edna = {
        enable = true;
        defer = 1;
        config = "(org-edna-mode)";
      };

      org-tree-slide = {
        enable = true;
        command = [ "org-tree-slide-mode" ];
      };

      org-variable-pitch = {
        enable = true;
        hook = [ "(org-mode . org-variable-pitch-minor-mode)" ];
      };

      ## treemacs

      treemacs = {
        enable = true;
        bind = {
          "C-c t f" = "treemacs-find-file";
          "C-c t t" = "treemacs";
        };
      };

      projectile = {
        enable = true;
        diminish = [ "projectile-mode" ];
        command = [ "projectile-mode" ];
        bindKeyMap = {
          "C-c p" = "projectile-command-map";
        };
        config = ''
          (setq projectile-completion-system 'default)
          (setq projectile-enable-caching t)
          (push "vendor" projectile-globally-ignored-directories)
          (push ".yarn" projectile-globally-ignored-directories)
          (push ".direnv" projectile-globally-ignored-directories)
          (projectile-mode 1)
        '';
      };

      treemacs-projectile = {
        enable = true;
        after = [ "treemacs" "projectile" ];
      };

      
      #vil-mode = {
      # enable = true;
      # config = ''
      # (evil-mode 1)
      # '';
   #  #  config = ''
   #  #    (setq evil-normal-state-cursor '(box "yellow"))
   #  #  '';
      #;
      
      
      
   #   evil-collection.enable = true;
      #evil-org = {
      #  enable = true;
      #  config = ''
      #    (add-hook 'org-mode-hook 'evil-org-mode)
      #    (add-hook 'evil-org-mode-hook
      #              (lambda ()
      #                 (evil-org-set-key-theme)))
      #  '';
      #  after = [ "evil" "org" ];
      #};

    };
  };
}
