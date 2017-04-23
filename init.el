;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; config customize
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; My define
(defvar my-home-dir (getenv "HOME"))
(when (eq system-type 'gnu/linux)
  (defvar my-ycmd-dir (expand-file-name
                       ".vim/vimfiles/plugin/youcompleteme/third_party/ycmd"
                       my-home-dir))
  (defvar my-rust-src-dir (expand-file-name
                           ".rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
                           my-home-dir)))
;;
(defun pre-install-packages (pkgs)
  (let ((packages pkgs))
    (mapc #'(lambda (pkg)
              (unless (package-installed-p pkg)
                (package-install pkg)))
          packages)))

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
(pre-install-packages '(company company-quickhelp fcitx flycheck flycheck-pos-tip helm helm-tramp magit
                                monokai-theme nlinum-relative paredit powerline
                                powerline-evil projectile rainbow-delimiters yasnippet))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; My packages
(add-to-list 'load-path (expand-file-name "init-el" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; basic environment
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink")
  (setq default-directory "~/"))

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
(when (require 'nlinum-relative nil :no-error)
  (nlinum-relative-setup-evil) ;; setup for evil
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "") ;; or "" for display current line number
  (setq nlinum-relative-offset 0)) ;; 1 if you want 0, 2, 3...
;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts nil :no-error))

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
  ;; (evil-leader/set-leader ",")
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
(when (require 'powerline nil :no-error)
  (powerline-evil-vim-color-theme)
  (display-time-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; helm
(require 'helm)
(require 'helm-config)
;;
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
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
	(fcitx-prefix-keys-add "C-x" "C-c" "C-h" "M-s" "M-o")
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
;; (add-hook 'lisp-mode-hook #'company-mode)
;; (add-hook 'emacs-lisp-mode-hook #'company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; config flycheck
(when (require 'flycheck nil :noerror)
  (with-eval-after-load 'flycheck (flycheck-pos-tip-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; config ycmd
(pre-install-packages '(ycmd company-ycmd flycheck-ycmd))
(when (and (require 'ycmd nil :noerror)
		   (require 'company-ycmd nil :noerror)
		   (require 'flycheck-ycmd))
  (set-variable 'ycmd-server-command
                `("python" ,(expand-file-name "ycmd" my-ycmd-dir)))
  ;; (set-variable 'ycmd-global-config
  ;;               (expand-file-name "dotfiles/ycmd/ycm_extra_conf.py"
  ;;                                 my-home-dir))
  ;; ycmd for company
  (company-ycmd-setup)
  ;; ycmd for flycheck
  (flycheck-ycmd-setup)
  (when (not (display-graphic-p))
	(setq flycheck-indication-mode nil))
  ;; ycmd for eldoc
  (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Rust IDE
;;; install rust ide packages
(pre-install-packages '(cargo flycheck-rust rust-mode))
;;; config rust ide
;; rust-mode
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'flycheck-mode)
;; flycheck-rust
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; cargo
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'cargo-process-mode-hook (lambda ()
                                     (setq truncate-lines nil)))
;; ycmd
(setq ycmd-rust-src-path my-rust-src-dir)
(setq ycmd-racerd-binary-path
        (expand-file-name "third_party/racerd/target/release/racerd"
                          my-ycmd-dir))
(add-hook 'rust-mode-hook 'ycmd-mode)

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
(pre-install-packages '(elpy py-autopep8))
;; python indent
(add-hook 'python-mode-hook
	      (lambda ()
		    (setq-default indent-tabs-mode t)
		    (setq-default tab-width 4)
		    (setq-default py-indent-tabs-mode t)
			(setq-default python-indent-offset 4)
	        (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))
;;; config python ide
(elpy-enable)
;; pyvenv
(when (require 'pyvenv nil :noerror)
  (cond
   ;; python virtualenv workon directory
   ((or (eq system-type 'gnu/linux) (eq system-type 'darwin))
    (setenv "WORKON_HOME" (expand-file-name "opt/python-venv" (getenv "HOME"))))
   ((eq system-type 'windwos-nt)
    (setenv "WORKON_HOME" "D:/opt/Python/venv"))))
;; flycheck
(add-hook 'python-mode-hook #'flycheck-mode)
;; py-autopep8
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;; ycmd
(add-hook 'python-mode-hook 'ycmd-mode)
