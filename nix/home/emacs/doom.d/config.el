;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jonatan Borkowski"
      user-mail-address "jonatan.borkowski@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;;; Fonts
(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 18))

(setq js-indent-level 2
      typescript-indent-level 2
      json-reformat:indent-width 2
      css-indent-offset 2
      +org-capture-todo-file "work.org"
      projectile-project-search-path '("~/projects/"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq deft-directory "~/org/"
      deft-extensions '("org", "txt", "md")
      deft-recursive t)

;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.75 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org" :side 'bottom :size 0.95 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(setq org-roam-directory "~/roam")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq neuron-default-zettelkasten-directory "~/zettelkasten")
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(setq circe-network-options
      '(("Freenode"
         :tls t
         :nick "jonatanb"
         :sasl-username "jonatanb"
         ;;:sasl-password "my-password"
         :channels ("#haskell", "#nixos")
         )))

(setenv "PATH" (concat (getenv "PATH") ":/$HOME/.cabal/bin:/$HOME/.ghcup/bin"))
;;;;;;;;;;;;
;; direnv ;;
;;;;;;;;;;;;

(add-hook 'before-hack-local-variables-hook #'direnv-update-environment)


;; Autocompletion(company)
(setq company-idle-delay 0.5
      company-minimum-prefix-length 2
      ;; company-show-numbers t
      )


;; lsp-ui
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-glance 1
        lsp-ui-doc-delay 0.5
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'Top
        lsp-ui-doc-border "#fdf5b1"
        lsp-ui-doc-max-width 65
        lsp-ui-doc-max-height 70
        lsp-ui-sideline-enable t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-peek-enable t
        lsp-ui-flycheck-enable -1)

  (add-to-list 'lsp-ui-doc-frame-parameters '(left-fringe . 0))
)

;;;;;;;;;;;;;
;; haskell ;;
;;;;;;;;;;;;;
(map! :leader
      (:after lsp-mode
       (:prefix ("l" . "LSP")
          :desc "Restart LSP server" "r" #'lsp-workspace-restart
          :desc "Excute code action" "a" #'lsp-execute-code-action
          :desc "Go to definition" "d" #'lsp-find-definition
          :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
          (:prefix ("u" . "LSP UI")
            :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
            :desc "Toggle sideline mode"  "s" #'lsp-ui-sideline-mode
            :desc "Glance at doc" "g" #'lsp-ui-doc-glance
            :desc "Toggle imenu"  "i" #'lsp-ui-imenu
            )
          )))

(setq haskell-stylish-on-save t)

;; (use-package lsp-haskell
;;
;;  :ensure t
;;  :config
;;  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
;;  (setq lsp-haskell-process-args-hie '("-d"))
;;  ;; Comment/uncomment this line to see interactions between lsp client/server.
;;  ;; (setq lsp-log-io t)
;;  )
;; (after! lsp-haskell
;;   (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
;; )
