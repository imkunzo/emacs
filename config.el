;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "KlausZL"
      user-mail-address "zachariah.li@gmail.com")

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
;; (setq doom-font (font-spec :family "Noto Sans Mono CJK SC" :size 14 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 16))
;; (setq doom-font (font-spec :family "Noto Sans Mono" :size 14 :weight 'Regular)
;;       doom-variable-pitch-font (font-spec :family "Noto Sans SC" :size 14))
;; (setq doom-font (font-spec :family "Monaco" :size 14 :weight 'Regular)
;;       doom-variable-pitch-font (font-spec :family "Lantinghei SC" :size 14))
;;
(defun +my/better-font()
(interactive)
;; english font
(if (display-graphic-p)
    (progn
      (set-face-attribute 'default nil :font (font-spec :family "Monaco" :size 14))
      (set-fontset-font t 'unicode (font-spec :family "Monaco Nerd Font Mono") nil 'prepend)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "Lantinghei SC" :size 16)))) ;; 14 16 20 22 28
  ))

(defun +my|init-font(frame)
(with-selected-frame frame
  (if (display-graphic-p)
      (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
  (add-hook 'after-make-frame-functions #'+my|init-font)
 (+my/better-font))
(add-hook 'doom-init-ui-hook #'+my/better-font)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-spacegrey)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to

;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq projectile-project-search-path '("~/Workspace/"))

;; (setq python-shell-interpreter "/usr/local/bin/python3.9")
(setq +python-jupyter-repl-args '("--simple-prompt"))

;; (load! "+cnfonts")
(load! "+flycheck")
(load! "+graphql")
;; (load! "+lsp-bridge")
(load! "+org")
(load! "+osx")
(load! "+rime")
(load! "+sql")

;; pythonpaths
(add-hook 'python-mode-hook
  (lambda ()
    (setq python-shell-extra-pythonpaths
          (list (projectile-ensure-project (projectile-project-root))
                (concat (projectile-ensure-project (projectile-project-root))
                        "src")))))

;; lsp-ui
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-delay 2
        lsp-ui-doc-position 'at-point))

;; lsp-pyright
(use-package! lsp-pyright
  :config
  (setq lsp-pyright-extra-paths "./src"
        lsp-pyright-auto-import-completions t
        lsp-pyright-use-library-code-for-types t
        lsp-pyright-venv-path ".venv"
        lsp-pyright-venv-directory ".venv")
  :hook ((python-mode . (lambda ()
                          (require 'lsp-pyright) (lsp-deferred)))))

;; tree-sitter
(use-package! tree-sitter
  :config
  (global-tree-sitter-mode))
