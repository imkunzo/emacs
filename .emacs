;; Path where settings files are kept
(add-to-list 'load-path "~/.emacs.d/settings")

;; 基本环境设置
(when (eq system-type 'windows-nt)
  (setenv "HOME" "d:/emacs/")
  ;; tramp configure for windows
  (setq tramp-default-method "plink"))

; (setenv "PATH" (concat (getenv "PATH") ""))
(setq default-directory "~/") ; 设置默认访问目录
(setq default-buffer-file-coding-system 'utf-8) ; 设置默认字符编码
(prefer-coding-system 'utf-8)
(setq indent-tabs-mode nil) ; always use spaces, not tabs, when indenting

(tool-bar-mode -1)
(scroll-bar-mode -1)

;; (global-set-key [C-tab] 'other-window)

;; ido-mode
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-enable-last-directory-history nil)

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
(require 'auto-complete-settings)

;; clojure ide settings
(require 'clojure-settings)

;; python ide settings
(require 'python-settings)
