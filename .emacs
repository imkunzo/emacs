;; Windows shortcut
;; X:\PATH\TO\CYGWIN\run.exe /bin/bash --login -c /bin/emacs --debug-init

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
    (racer rust-mode flycheck-rust company-racer flycheck-clojure clojure-cheatsheet clj-refactor cider yasnippet rainbow-delimiters projectile paredit monokai-theme helm flycheck-pos-tip evil company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; 基本环境设置
(when (eq system-type 'windows-nt)
  (setenv "HOME" "d:/emacs/")
  ;; set environment
  (setenv "PATH"
          (concat
           "D:/opt/msys64/usr/bin" ";"
           "D:/opt/msys64/mingw64/bin" ";"
           "D:/opt/PuTTY" ";"
;;           "d:/opt/leiningen" ";"
           (getenv "PATH")))
  ;; tramp configure for windows
  (setq tramp-default-method "plink"))

;;;; 设置默认访问目录
(setq default-directory "~/")

;;;; 设置英文字体
(set-face-attribute
 'default nil :font "Ubuntu Mono 12")
;; 设置方块字字体
(if (or (eq system-type 'windows-nt) (eq system-type 'cygwin))
    (progn (dolist (charset '(kana han symbol cjk-misc bopomofo))
             (set-fontset-font (frame-parameter nil 'font)
                               charset
                               (font-spec :family "Microsoft YaHei" :size 16)))))


;;;; ELPA
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ;; ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ))

(setq package-enable-at-startup nil)
(package-initialize)
;; 默认插件安装
(defvar my-default-packages '(company
                              evil
                              flycheck
                              flycheck-pos-tip
                              helm
                              monokai-theme
                              paredit
                              projectile
                              rainbow-delimiters
                              yasnippet))

(dolist (p my-default-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;; 外观设置
(when (not (eq window-system nil))
  (tool-bar-mode -1)
  (scroll-bar-mode -1))
;; monokai theme
(load-theme 'monokai t)
;; zenburn theme
;; (load-theme 'zenburn t)
;; rainbow delimiters mode
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;;; 设置默认字符编
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;; 编辑方式设置
;; 选中区块的删除模式
(delete-selection-mode t)
;; TAB indent设置
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;;; auto template
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(setq auto-insert-query nil)
(setq auto-insert-alist
      (append '((org-mode . "template.org"))
              auto-coding-alist))

;;;; org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
          (lambda ()
            (setq truncate-lines nil)))
;; org-capture
(setq org-default-notes-file "d:/Dropbox/GTD/INBOX.org")
(define-key global-map "\C-cr" 'org-capture)
(setq org-capture-templates
      '(("n" "New" entry (file+headline "d:/Dropbox/GTD/INBOX.org" "Temp") "* TODO %?\n %i\n %a")
        ("t" "Todo" entry (file+headline "d:/Dropbox/GTD/TASK.org" "Tasks") "* TODO %?\n %i\n")
        ("i" "Idea" entry (file+headline "d:/Dropbox/GTD/TASK.org" "Ideas") "* TODO %?\nEntered on: %U\n %i\n")
        ("j" "Journal" entry (file+datetree "d:/Dropbox/GTD/NOTE.org") "* %?\nEntered on: %U\n %i\n")))
;;
(setq org-todo_keywords
      '((sequence "TODO(t!)"
                  "NEXT(n)"
                  "WAITTING(w)"
                  "SOMEDAY(s)"
                  "|"
                  "DONE(d@/!)"
                  "ABORT(a@/!)")))

;;;; evil
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd ",f") 'projectile-find-file)
(define-key evil-normal-state-map (kbd ",,") 'evil-buffer)
(define-key evil-normal-state-map (kbd "q") nil)
;;
(define-key evil-insert-state-map (kbd "C-e") nil)
(define-key evil-insert-state-map (kbd "C-d") nil)
(define-key evil-insert-state-map (kbd "C-k") nil)
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
;;
(define-key evil-motion-state-map (kbd "C-e") nil)
(define-key evil-visual-state-map (kbd "C-c") 'evil-exit-visual-state)

;;;; linum mode
(global-linum-mode t)

;;;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(defun org-toggle-iimage-in-org ()
  "Display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  (iimage-mode))

;;;; projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching nil)
(setq projectile-require-project-root t)

;;;; helm
(require 'helm)
(require 'helm-config)
;;
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;;
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(helm-mode t)

;;;; yasnippet
(require 'yasnippet)
;; (add-to-list 'yas-snippet-dirs '("~/.emacs.d/snippets"))
;; (mapc 'yas/load-directory yas-snippet-dirs)
(yas-global-mode 1)
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
;; (add-hook 'org-mode-hook #'yas-minor-mode)

;;;; paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;;;; eldoc
;; make ElDoc aware of ParEdit’s most used commands
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'scheme-mode-hook 'turn-on-eldoc-mode)

;;;; company mode
(add-hook 'after-init-hook 'global-company-mode)

;;;; flycheck
(require 'flycheck)
(with-eval-after-load 'flycheck (flycheck-pos-tip-mode))

;;;; Clojure IDE
;; define clojure ide packages
(defvar clojure-ide-packages '(cider
                               clj-refactor
                               clojure-cheatsheet
                               clojure-mode
                               flycheck-clojure))
;; install clojure ide packages
(dolist (p clojure-ide-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; eldoc setting for clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
;; paredit setting for clojure
(add-hook 'cider-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
;; rainbow-delimiters setting for clojure
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
;; flycheck setting for clojure
(add-hook 'clojure-mode-hook #'flycheck-mode)
(eval-after-load 'flycheck '(flycheck-clojure-setup))

;;;; Rust IDE
(defvar rust-ide-packages '(company-racer
                            flycheck-rust
                            rust-mode
                            racer
                            ))
;;
(dolist (p rust-ide-packages)
  (when (not (package-installed-p p))
    (package-install p)))
