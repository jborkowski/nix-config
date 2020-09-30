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

   # packageRequires = [ epkgs.async ];
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
    python3
    xclip
    sqlite
    haskellPackages.haskell-language-server
  ];


  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    prelude = ''
      ;; nyancut flying around :)
      (nyan-mode 1)

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
      
      (setq recentf-max-saved-items 200
         recentf-max-menu-items 15)
      
      (defalias `yes-or-no-p `y-or-n-p)
      
      (setq org-directory "~/Nextcloud/org")
      
      ;; Set up fonts early.
      (set-face-attribute 'default
                          nil
                          :height 110
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

      (setq wttrin-default-cities '("Warsaw"))
      (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

      ;; auto-refresh all buffers when files have changed on disk
      (global-auto-revert-mode t)
      (column-number-mode 1)
      (global-linum-mode 1)
      (encourage-mode 1)
      (which-key-mode)

      ;; Make moving cursor past bottom only scroll a single line rather
      ;; than half a page.
      (setq scroll-step 1
            scroll-conservatively 5)

    '';
   
    usePackage = {

      encourage-mode = {
         enable = true;
         config = "(encourage-mode 1)";
      };
      
      company = {
        enable = true;
        bind = {
          "C-." = "#'company-complete";
        };
        hook = [
          "(prog-mode . company-mode)"
        ];
        config = ''
           (global-company-mode 1)
           (add-to-list 'company-backends 'company-etags)
           ;; numberic helper to select company completition candidates
           (let ((map company-active-map))
             (mapc (lambda (x) (define-key map (format "%d" x)
			                            `(lambda () (interactive) (company-complete-number ,x))))
	                 (number-sequence 0 9))
           )

          (setq company-idle-delay 0)
          (setq company-echo-delay 0)
      ;;    (setq company-minimum-prefix-length)
          (setq company-dabbrev-downcase nil)
          (setq company-show-numbers t)
          (setq company-tooltip-limit 20)
          (setq company-async-timeout 20)
          (setq company-transformers '(company-sort-by-o))
          (setq company-selection-wrap-around t)
          (setq company-transformers '(company-sort-by-occurrence
                             company-sort-by-backend-importance))
        '';
      };

      company-lsp = {
        enable = true;
        config = ''
          (push 'company-lsp company-backends)
        '';
      };

      company-yasnippet = {
        enable = true;
        bind = {
          "M-/" = "company-yasnippet";
        };
      };

      protobuf-mode = {
        enable = true;
        mode = [ ''"'\\.proto\\'"'' ];
      };

      yasnippet = {
        enable = true;
        defer = 1;
        diminish = [ "yas-minor-mode" ];
        command = [ "yas-global-mode" "yas-minor-mode" ];
        hook = [
          # Yasnippet interferes with tab completion in ansi-term.
          "(term-mode . (lambda () (yas-minor-mode -1)))"
          "(yas-minor-mode-hook . (lambda () (yas-activate-extra-mode 'fundamental-mode)))"
        ];
        config = "(yas-global-mode 1)";
      };

      # Doesn't seem to work, complains about # in go snippets.
      yasnippet-snippets = {
        enable = false;
        after = [ "yasnippet" ];
      };

      dired = {
        enable = true;
        defer = true;
        config = ''
          (put 'dired-find-alternate-file 'disabled nil)
          ;; Use the system trash can.
          (setq delete-by-moving-to-trash t)
        '';
      };

      direnv = {
        enable = true;
        config = "(direnv-mode)";
      };
      
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
          "C-x C-f" = "helm-find-files";
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

      recentf = {
        enable = true;
        config = ''
          (setq recentf-max-saved-items 200
                recentf-max-menu-items 15)
          (recentf-mode +1)
        '';
      };
      
      helm-projectile = {
        enable = true;
        config = ''
          (projectile-mode +1)
        '';
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

      all-the-icons-dired = {
        enable = true;
        after = [ "all-the-icons" ];
        hook = [ "(dired-mode-hook . all-the-icons-dired-mode)" ];
      };

      undo-tree = {
        enable = true;
        demand = true;
        diminish = [ "undo-tree-mode" ];
        command = [ "global-undo-tree-mode" ];
        config = ''
          (setq undo-tree-visualizer-relative-timestamps t
                undo-tree-visualizer-timestamps t)
          (global-undo-tree-mode 1)
        '';
      };

      neuron-mode = {
        enable = true;
        package = neuron-mode;
      };

      eyebrowse = {
        enable = true;
        demand = true;
        command = [
          "eyebrowse-mode"
        ];
        bind = {
          "<C-tab>" = "eyebrowse-next-window-config";
          "<C-iso-lefttab>" = "eyebrowse-prev-window-config";
        };
   #     init = builtins.readFile ./emacs-inits/eyebrowse.el;
     };

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
                org-agenda-skip-deadline-if-done t
                org-agenda-skip-scheduled-if-done t
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
        config = ''
          (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         35)
          
        (treemacs-follow-mode t)
        (treemacs-filewatch-mode t)
        (treemacs-fringe-indicator-mode t)
        (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
                 (`(t . t)
                 (treemacs-git-mode 'deferred))
                 (`(t . _)
                 (treemacs-git-mode 'simple))))
        '';
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

      treemacs-evil = {
        enable = true;
        after = [ "treemacs" "evil" ];
      };

      treemacs-magit = {
        enable = true;
        after = [ "treemacs" "magit" ];
      };

      doom-modeline = {
        enable = true;
        hook = [ "(after-init . doom-modeline-mode)" ];
        config = ''
          (setq doom-modeline-buffer-file-name-style 'truncate-except-project)
        '';
      };
      
     evil = {
       enable = true;
       config = ''
       (evil-mode 1)
       (setq evil-normal-state-cursor '(box "yellow"))
       '';
     };
          
     # evil-collection.enable = true;
     evil-org = {
       enable = true;
       config = ''
         (add-hook 'org-mode-hook 'evil-org-mode)
         (add-hook 'evil-org-mode-hook
                   (lambda () wh
                      (evil-org-set-key-theme)))
       '';
        after = [ "evil" "org" ];
     };

     evil-mc = {
       enable = true;
       config = ''
        (evil-define-key 'visual evil-mc-key-map
                         "A" #'evil-mc-make-cursor-in-visual-selection-end
                         "I" #'evil-mc-make-cursor-in-visual-selection-beg)
       '';
     };

     evil-magit.enable = true;

     evil-surround = {
       enable = true;
       config = "(global-evil-surround-mode 1)";
     };
     
     evil-leader = {
       enable = true;
       config = ''
         (global-evil-leader-mode)
         (evil-leader/set-leader "<SPC>")
         (evil-leader/set-key
            "y"  'helm-show-kill-ring
            "u"  'undo-tree-visualize
            ;; "r"  'undo-tree-visualize-redo
            "bb" 'helm-mini
            "bp" 'helm-projectile-find-file
            "br" 'helm-projectile-recentf
            "ww" 'ace-window
            "w1" 'eyebrowse-switch-to-window-config-1
            "w2" 'eyebrowse-switch-to-window-config-2
            "w3" 'eyebrowse-switch-to-window-config-3
            "w4" 'eyebrowse-switch-to-window-config-4
            "wv" 'split-window-horizontally
            "wh" 'split-window-vertically
            "wx" 'ace-delete-window
            "k"  'kill-buffer
            "g"  'hydra-git/body
            "m"  'major-mode-hydra
            "p"  'helm-projectile-switch-project
            "nn" 'eno-word-goto
            "n]" 'sp-backward-sexp
            "n[" 'sp-forward-sexp
            "nl" 'goto-line
            "nc" 'goto-last-change
            "nw" 'evil-avy-goto-char-timer
            "jj" 'dumb-jump-go
            "jb" 'dumb-jump-back
            "jw" 'dumb-jump-go-prompt
            "0"  'treemacs-select-window
            "do" 'treemacs-delete-other-windows
            "tt" 'treemacs
            "tb" 'treemacs-bookmark
            "tf" 'treemacs-find-file
            "ff" 'treemacs-find-tag
            "st" 'vterm-toggle
         )

       '';
     };
         
    smartparens = {
        enable = true;
        defer = 1;
        diminish = [ "smartparens-mode" ];
        command = [ "smartparens-global-mode" "show-smartparens-global-mode" ];
        bindLocal = {
          smartparens-mode-map = {
            "C-M-f" = "sp-forward-sexp";
            "C-M-b" = "sp-backward-sexp";
          };
        };
        config = ''
          (require 'smartparens-config)
          (smartparens-global-mode t)
          (show-smartparens-global-mode t)
          (sp-local-pair 'prog-mode "{" nil :post-handlers '((indent-between-pair "RET")))
          (sp-local-pair 'prog-mode "[" nil :post-handlers '((indent-between-pair "RET")))
          (sp-local-pair 'prog-mode "(" nil :post-handlers '((indent-between-pair "RET")))
        '';
      };     

    lsp-ui = {
      enable = true;
      command = [ "lsp-ui-mode" ];
      bind = {
        "C-c r d" = "lsp-ui-doc-show";
        "C-c f s" = "lsp-ui-find-workspace-symbol";
      };
      config = ''
        (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
        (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
      '';
    };
    
    lsp-ui-flycheck = {
      enable = true;
      command = [ "lsp-flycheck-enable" ];
      after = [ "flycheck" "lsp-ui" ];
    };

    lsp-mode = {
      enable = true;
      command = [ "lsp" ];
      defer = 1;
      after = [ "flycheck" "yasnippet" ];
      bind = {
        "C-c r r" = "lsp-rename";
        "C-c r f" = "lsp-format-buffer";
        "C-c r g" = "lsp-format-region";
        "C-c r a" = "lsp-execute-code-action";
        "C-c f r" = "lsp-find-references";
      };
      hook = [
        "((haskell-mode . lsp)
          (lsp-mode . lsp-enable-which-key-integration))"
      ];
      bindLocal = {
        lsp-mode-map = {
          "C-=" = "lsp-extend-selection";
        };
      };
      config = ''
        (setq
            lsp-diagnostic-package :flycheck
            lsp-headerline-breadcrumb-enable t)
        ;; lsp-eldoc-render-all nil
        ;;lsp-modeline-code-actions-enable nil
        (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
        (lsp-register-client
        (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                         :major-modes '(nix-mode)
                         :server-id 'nix))
        '';
        #                 lsp-prefer-flymake nil
        # (setq lsp-enable-semantic-highlighting t)
    };

    
    lsp-treemacs = {
      enable = true;
      command = [ "lsp-treemacs-errors-list" ];
      after = [ "lsp-mode" "treemacs" ];
    };

    lsp-haskell = {
      enable = true;
      after = [ "lsp" ];
    }; 

    };

    postlude = ''
      (add-hook 'haskell-mode-hook #'lsp)
      (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")

      (global-set-key (kbd "s-<left>") 'shrink-window-horizontally)
      (global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)
      (global-set-key (kbd "s-<down>") 'shrink-window)
      (global-set-key (kbd "s-<up>") 'enlarge-window)
    '';
  };
}
