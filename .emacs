;; 基本环境设置
(when (eq system-type 'windows-nt)
  (setenv "HOME" "d:/emacs/")
  ;; tramp configure for windows
  (setq tramp-default-method "plink"))

; (setenv "PATH" (concat (getenv "PATH") ""))
(setq default-directory "~/") ; 设置默认访问目录

;; Path where settings files are kept
(add-to-list 'load-path "~/.emacs.d/settings")

;; elpa
(require 'elpa-settings)

;; Put auto 'custom' changes in a separate file (this is stuff like
;; custom-set-faces and custom-set-variables)
(load 
 (setq custom-file
       (expand-file-name "settings/custom.el" user-emacs-directory))
 'noerror)

;; paredit-mode
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

;; rainbow-delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; fill-column-indicator
;; (require 'fill-column-indicator-settings)

;; yasnippet
(require 'yasnippet-settings)

;; auto-complete
;; (require 'auto-complete-settings)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)

;; clojure ide settings
(require 'clojure-settings)

;; python ide settings
(require 'python-settings)

