;;; init.el -- Summary
;;; Commentary:


;;; server mode
(server-start)

;;; initialize
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "lisp/customize.el" user-emacs-directory))
(load custom-file 'noerror)

;;; Constants
(require 'init-const)

;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when sys/win32p
  (setq tramp-default-method "plink"))
;;
(when sys/linuxp
  (setq shell-file-name "/bin/zsh"))

(when (or sys/linuxp sys/macp)
  (setq remote-file-name-inhibit-cache nil)
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))
  (setq tramp-verbose 1))

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/.cargo/bin")
;; (global-set-key (kbd "C-c t l" ) 'toggle-truncate-lines)

(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))     
(setq prefer-coding-system        'utf-8
      set-terminal-coding-system  'utf-8
      set-keyboard-coding-system  'utf-8
      set-selection-coding-system 'utf-8
      locale-coding-system   'utf-8
      buffer-file-coding-system 'utf-8)

;; default directory
(setq default-directory "~/")

;;;; Bootstrap config
;; (require 'init-utils)
;; (require 'init-site-lisp)
(require 'init-elpa)

(when sys/macp
  (require 'init-osx))

(when (display-graphic-p)
  (require 'init-gui-fonts))

(let ((gc-cons-threshold most-positive-fixnum)
      (file-name-handler-alist nil))
  (use-package benchmark-init
    :ensure t
    :init
    (benchmark-init/activate))
  
  ;;; basic config
  (require 'init-appear)
  (require 'init-awesome-tab)
  (require 'init-linum)
;;  (require 'init-evil)
  (require 'init-hydra)
  (require 'init-ivy)
  (require 'init-which-key)
  (require 'init-smartparens)
  (require 'init-snails)
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
  ;; (require 'init-pyim)
  (require 'init-rime)
  (require 'init-treemacs)
  (require 'init-yaml)
  (require 'init-yasnippet)
  ;; (require 'mermaid-mode)
  
  ;;; IDE
  (require 'init-lsp)
  (require 'init-python)
  ;; (require 'init-clojure)
  (require 'init-rust)
)
;;; init.el ends here
