;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; customize file configuration
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ELPA
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(setq package-enable-at-startup nil)
(when (not package-archive-contents)
  (package-refresh-contents))
;; default packages
(defvar default-packages '(company evil evil-leader flycheck flycheck-pos-tip
  helm magit monokai-theme nlinum-relative paredit projectile
  rainbow-delimiters yasnippet))
;; install default packages
(mapc #'(lambda (pkg)
          (unless (package-installed-p pkg)
            (package-install pkg)))
      default-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; My packages
(add-to-list 'load-path (expand-file-name "mypackages/" user-emacs-directory))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink")
  (setq default-directory "~/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; appearance configuration
;;; default encoding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;; TAB indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; color theme
(load-theme 'monokai t)
;;; rainbow delimiters mode
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;; nlinum-relative
(when (require 'nlinum-relative nil :no-error)
  (nlinum-relative-setup-evil) ;; setup for evil
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "->") ;; or "" for display current line number
  (setq nlinum-relative-offset 0)) ;; 1 if you want 0, 2, 3...
;;; Fonts configuration
;; Setting english font
(set-face-attribute
 'default nil :font "Monaco 10")
;; Setting chinese Font
(if (or (eq system-type 'windows-nt) (eq system-type 'opt/cygwin))
    (progn (dolist (charset '(kana han symbol cjk-misc bopomofo))
             (set-fontset-font (frame-parameter nil 'font)
                               charset
                               (font-spec :family "Microsoft YaHei"
                                          :size 16)))))
;;; long lines
(when (require 'so-long nil :no-error)
  (so-long-enable))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;; evil
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
;; (define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
;;
(define-key evil-motion-state-map (kbd "C-e") nil)
(define-key evil-visual-state-map (kbd "C-c") 'evil-exit-visual-state)
;;; evil leader
(global-evil-leader-mode)
;; (evil-leader/set-leader ",")
(evil-leader/set-key
 "x" 'helm-M-x
 "f" 'helm-find-files
 "b" 'helm-buffers-list
 "k" 'kill-buffer
 "y" 'helm-show-kill-ring)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;; Add vim-like movement to Helm
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-h") 'helm-next-source)
(define-key helm-map (kbd "C-S-h") 'describe-key)
(define-key helm-map (kbd "C-l") (kbd "RET"))
(define-key helm-map [escape] 'helm-keyboard-quit)
(dolist (keymap (list helm-find-files-map helm-read-file-map))
  (define-key keymap (kbd "C-l") 'helm-execute-persistent-action)
  (define-key keymap (kbd "C-h") 'helm-find-files-up-one-level)
  (define-key keymap (kbd "C-S-h") 'describe-key))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; magit
(when (eq system-type 'windows-nt)
  (setq magit-git-executable "d:/opt/msys2/usr/bin/git.exe"))
(global-magit-file-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching nil)
(setq projectile-require-project-root t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; yasnippet
(require 'yasnippet)
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
;; (mapc 'yas/load-directory yas-snippet-dirs)
;; (yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; company mode basic configuration
(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; flycheck basic configuration
(require 'flycheck)
(with-eval-after-load 'flycheck (flycheck-pos-tip-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Rust IDE
(defvar rust-ide-packages '(cargo company-racer flycheck-rust racer rust-mode))
;;; install rust ide packages
(mapc #'(lambda (pkg)
          (unless (package-installed-p pkg)
            (package-install pkg)))
      rust-ide-packages)
;;; config rust ide
;; rust-mode
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'rust-mode-hook #'racer-mode)
;; flycheck-rust
;; (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(eval-after-load 'flycheck '(flycheck-rust-setup))
;; emacs-racer
;; (setq racer-rust-src-path "d:/opt/Rust/rustc-1.13.0-src/src/")
(add-hook 'racer-mode-hook #'eldoc-mode)
;; rust company
(add-hook 'racer-mode-hook #'company-mode)
(setq company-tooltip-align-annotations t)
;; cargo
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'cargo-process-mode-hook (lambda ()
                                     (setq truncate-lines nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Clojure IDE
(defvar clojure-ide-packages '(cider
                               clojure-cheatsheet
                               clojure-mode
                               flycheck-clojure))
;;; install clojure ide packages
(mapc #'(lambda (pkg)
          (unless (package-installed-p pkg)
            (package-install pkg)))
      clojure-ide-packages)
;;; config clojure ide
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
