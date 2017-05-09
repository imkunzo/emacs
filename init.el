;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; config customize
(setq custom-file (expand-file-name "els/customize.el" user-emacs-directory))
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ELPA
(when (require 'package nil :noerror)
  (defun pre-install-packages (pkgs)
    (let ((packages pkgs))
      (mapc #'(lambda (pkg)
                (unless (package-installed-p pkg)
                  (package-install pkg)))
            packages))))
;;
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(setq package-enable-at-startup nil)
(when (not package-archive-contents)
  (package-refresh-contents))
;; default packages
(pre-install-packages '(company company-quickhelp exec-path-from-shell
                                fcitx flycheck
                                flycheck-pos-tip helm helm-tramp
                                nlinum-relative magit monokai-theme
                                paredit powerline powerline-evil
                                projectile rainbow-delimiters which-key
                                yasnippet))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; My packages
(add-to-list 'load-path (expand-file-name "els" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink")
  (setq default-directory "~/"))
;;
(when (or (eq system-type 'darwin) (eq system-type 'gnu/linux))
  (setq tramp-default-method "ssh")
  (setq shell-file-name "/bin/zsh")
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; appearance
;;; default encoding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;; TAB indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; color theme
(load-theme 'monokai t)
;; (load-theme 'zenburn t)
;;; rainbow delimiters mode
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;; nlinum-relative
(when (require 'nlinum-relative nil :noerror)
  (nlinum-relative-setup-evil) ;; setup for evil
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "") ;; or "" for display current line number
  (setq nlinum-relative-offset 0)) ;; 1 if you want 0, 2, 3...
;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts nil :no-error))
;; set default split
(setq split-width-threshold nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; evil
;;; install evil packages
(pre-install-packages '(evil evil-leader evil-tabs))
;;; evil configuration
(when (require 'evil nil :no-error)
  (require 'evil)
  (evil-mode 1)
  ;; (define-key evil-normal-state-map (kbd ",f") 'projectile-find-file)
  ;; (define-key evil-normal-state-map (kbd ",,") 'evil-buffer)
  (define-key evil-normal-state-map (kbd "q") nil)
  ;;
  (define-key evil-insert-state-map (kbd "C-e") nil)
  (define-key evil-insert-state-map (kbd "C-d") nil)
  (define-key evil-insert-state-map (kbd "C-k") nil)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
  ;;
  (define-key evil-motion-state-map (kbd "C-e") nil)
  (define-key evil-visual-state-map (kbd "C-c") 'evil-exit-visual-state))
;;; evil tab
(when (require 'evil-tabs nil :no-error)
  (global-evil-tabs-mode)
  (evil-define-key 'normal evil-tabs-mode-map
    "gnt" 'elscreen-create
    "gkt" 'elscreen-kill))
;;; evil leader
(when (require 'evil-leader nil :no-error)
  (setq evil-leader/in-all-states t)
  (global-evil-leader-mode)
  (evil-leader/set-key
    ;; appearance
    "mb" 'toggle-menu-bar-mode-from-frame
    ;; helm
    "x" 'helm-M-x
    "f" 'helm-find-files
    "b" 'helm-buffers-list
    "k" 'kill-buffer
    "y" 'helm-show-kill-ring
    ;; projectile
    "pf" 'project-find-file
    ;; evil-tabs
    "gt" 'elscreen-goto
    ;; magit
    "mgs" 'magit-status
    "mgc" 'magit-commit
    "mgt" 'magit-push
    "mgl" 'magit-pull))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; powerline
(when (require 'powerline nil :noerror)
  (powerline-evil-vim-color-theme)
  (display-time-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; helm
(require 'helm)
(require 'helm-config)
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
;;;; fcitx
(when (eq system-type 'gnu/linux)
  (when (require 'fcitx nil :noerror)
    (fcitx-aggressive-setup)
    (setq fcitx-use-dbus t)
    (setq fcitx-active-evil-states '(insert emacs hybrid))
	;; auto turn off fcitx when "M-x"
	(fcitx-M-x-turn-on)
	;; auto turn off fcitx when "M-!"
	(fcitx-shell-command-turn-on)
	;; auto turn off fcitx when "M-:"
	(fcitx-eval-expression-turn-on)
	;; auto turn off fcitx with prefix keys
	(fcitx-prefix-keys-add "C-c" "C-h" "C-s" "C-x" "M-s" "M-o")
    (fcitx-prefix-keys-turn-on)))

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
;;;; config company mode
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(define-key company-active-map
     (kbd "C-c h") #'company-quickhelp-manual-begin))
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; config flycheck
(when (require 'flycheck nil :noerror)
  (with-eval-after-load 'flycheck (flycheck-pos-tip-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; org mode
;; auto insert header
(defun my/org-file-header ()
  "Insert header on new org mode file"
  (insert "#+TITLE: \n
#+AUTHOR: Zack.Li
#+CATEGORY: \n
#+DATE: \n
#+OPTIONS: toc:t ^:{} f:t \n
#+STARTUP indent \n
")
  (org-mode-restart))
(define-auto-insert "\\.org$" #'my/org-file-header)
;; key binding
(define-key global-map "\C-cc" 'org-capture)
;; capture templates
(setq org-capture-templates
     '(("j" "Journal" entry (file+datetree "~/Org/journal.org")
        "* %?\n Entered On: %U\n %i\n %a"
        :empty-lines 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; iimage mode
(when (require 'iimage nil :noerror)
  (autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
  (autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
  (defun org-toggle-iimage-in-org ()
    "display images in your org file"
    (interactive)
    (if (face-underline-p 'org-link)
        (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
    (iimage-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Rust IDE
;;; install rust ide packages
(pre-install-packages '(cargo company-racer flycheck-rust racer rust-mode))
;;; config rust ide
;; rust-mode
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'flycheck-mode)
;; cargo
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'cargo-process-mode-hook (lambda ()
                                     (setq truncate-lines nil)))
;; racer
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
;; flycheck-rust
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; rust key binding
(add-hook 'rust-mode-hook
          (lambda ()
            (define-key rust-mode-map (kbd "C-c <tab>") #'rust-format-buffer)
            (define-key rust-mode-map (kbd "M-.") #'racer-find-definition)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Clojure IDE
;;; install clojure ide packages
(pre-install-packages '(cider clojure-cheatsheet clojure-mode flycheck-clojure))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; python IDE
;;; install python ide packages
(pre-install-packages '(anaconda-mode company-anaconda elpy py-yapf))
;; python indent
(add-hook 'python-mode-hook
	      (lambda ()
		    (setq-default indent-tabs-mode t)
		    (setq-default tab-width 4)
		    (setq-default py-indent-tabs-mode t)
			(setq-default python-indent-offset 4)
	        (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
;;; config python ide
(elpy-enable)
(setq python-shell-completion-native-enable nil)
;; pyvenv
(when (require 'pyvenv nil :noerror)
  (cond
   ;; python virtualenv workon directory
   ((or (eq system-type 'gnu/linux) (eq system-type 'darwin))
    (setenv "WORKON_HOME" (expand-file-name "opt/python-venv" (getenv "HOME"))))
   ((eq system-type 'windwos-nt)
    (setenv "WORKON_HOME" "D:/opt/Python/venv"))))
;; anaconda
(add-hook 'python-mode-hook #'anaconda-mode)
(add-hook 'python-mode-hook #'anaconda-eldoc-mode)
;; flycheck
(add-hook 'python-mode-hook #'flycheck-mode)
;; py-autopep8
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)
;; company
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-anaconda))
;; python inferior completion
(add-hook 'inferior-python-mode-hook #'company-mode)
