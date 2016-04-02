;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Windows shortcut
;; X:\PATH\TO\CYGWIN\run.exe /bin/bash --login -c /bin/emacs --debug-init

;; 基本环境设置
(when (eq system-type 'windows-nt)
  (setenv "HOME" "d:/emacs/")
  ;; set environment
  (setenv "PATH"
          (concat
           "D:/opt/msys64/usr/bin" ";"
           "D:/opt/msys64/mingw64/bin" ";"
;;           "D:/opt/PuTTY" ";"
;;           "d:/opt/leiningen" ";"
           (getenv "PATH")))
  ;; tramp configure for windows
  (setq tramp-default-method "plink"))

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

;; evil-mode
;; (require 'evil)
;; (evil-mode 1)

;; paredit-mode
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

;; rainbow-delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; fill-column-indicator
;; (require 'fill-column-indicator-settings)

;;
(require 'smex-settings)

;; org-mode
(require 'org-mode-settings)

;; projectile
(require 'projectile-settings)

;; yasnippet
(require 'yasnippet-settings)

;; auto-complete
;; (require 'auto-complete-settings)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)

;; clojure ide settings
(require 'clojure-settings)

;; python ide settings
;; (require 'python-settings)
