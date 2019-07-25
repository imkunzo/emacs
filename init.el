;;; init.el -- Summary
;;; Commentary:

;;; Code:
(when (< emacs-major-version 27)
  (package-initialize))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "lisp/customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; Enable with t if you prefer
;; (defconst *spell-check-support-enabled* nil)
;; (defconst *is-mac-p* (eq system-type 'darwin))
;; (defconst *is-windows-p* (eq system-type 'windows-nt))
;; (defconst *is-linux-p* (eq system-type 'gnu/linux))

;; Constants
(require 'init-const)

;;;; Temporarily reduce garbage collection during startup
(defconst pufferfish/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold pufferfish/initial-gc-cons-threshold)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when sys/win32p
  (setq tramp-default-method "plink")
  (setq default-directory "~/"))
;;
(when sys/linuxp
  (setq shell-file-name "/bin/zsh"))

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/.cargo/bin")
;; (global-set-key (kbd "C-c t l" ) 'toggle-truncate-lines)

(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))     
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

;;;; Bootstrap config
;; (require 'init-utils)
(require 'init-site-lisp)
(require 'init-elpa)
(when sys/macp
  (require 'init-osx)
  )

;;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts))

;;; basic config
(require 'init-appear)
(require 'init-linum)
;; (require 'init-evil)
(require 'init-ivy)
(require 'init-which-key)
(require 'init-smartparens)
(require 'init-eshell)

;;; tools
(require 'init-all-the-icons)
(require 'init-ace-jump)
(require 'init-company)
(require 'init-fcitx)
(require 'init-flycheck)
(require 'init-graphviz)
(require 'init-markdown)
(require 'init-magit)
(require 'init-mermaid)
(require 'init-org)
(require 'init-plantuml)
(require 'init-projectile)
(require 'init-pyim)
(require 'init-treemacs)
(require 'init-yaml)
(require 'init-yasnippet)
;; (require 'mermaid-mode)

;;; IDE
(require 'init-lsp)
(require 'init-python)
(require 'init-clojure)
(require 'init-rust)

;;
(when (require 'so-long nil :noerror)
  (so-long-enable))
;;; init.el ends here
