;;; init.el -- Summary
;;; Commentary:

;;; Code:
(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "lisp/customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; Enable with t if you prefer
(defconst *spell-check-support-enabled* nil)
(defconst *is-mac-p* (eq system-type 'darwin))
(defconst *is-windows-p* (eq system-type 'windows-nt))
(defconst *is-linux-p* (eq system-type 'gnu/linux))


;;;; Temporarily reduce garbage collection during startup
(defconst pufferfish/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold pufferfish/initial-gc-cons-threshold)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when *is-windows-p*
  (setq tramp-default-method "plink")
  (setq default-directory "~/"))
;;
(when (or *is-mac-p* *is-linux-p*)
  (setq shell-file-name "/bin/zsh"))

(when *is-mac-p*
  (setq temporary-file-directory "/tmp/"))

(global-set-key (kbd "C-c t l" ) 'toggle-truncate-lines)

;;;; Bootstrap config
(require 'init-utils)
(require 'init-site-lisp)
(require 'init-elpa)
(when *is-mac-p*
  (require 'init-osx)
  )

;;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts))

;;; basic config
(require 'init-appear)
(require 'init-linum)
(require 'init-evil)
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
(require 'init-org)
(require 'init-plantuml)
(require 'init-projectile)
(require 'init-yaml)
(require 'init-yasnippet)
(require 'mermaid-mode)

;;; IDE
(require 'init-lsp)
(require 'init-python)
(require 'init-clojure)
(require 'init-rust)

;;; init.el ends here
