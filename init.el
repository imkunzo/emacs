;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
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


;;;; Bootstrap config
(require 'init-utils)
(require 'init-site-lisp)
(require 'init-elpa)

(require 'init-linum)
(require 'init-evil)
(require 'init-company)
(require 'init-ivy)

(require 'init-org)
(require 'init-python)
(require 'init-yaml)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; insert date and time
(defvar current-date-format "%F %a")
;;
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y")
;;
(defvar current-time-format "%a %H:%M:%S")
;;
(defun insert-current-date ()
       (interactive)
;;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-format (current-time))))
(defun insert-current-date-time ()
       (interactive)
;;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time))))
;;
(defun insert-current-time ()
       (interactive)
       (insert (format-time-string current-time-format (current-time))))
;;
;; (global-set-key (kbd "C-i d") 'insert-current-date-time)
;; (global-set-key (kbd "C-i t") 'insert-current-time)

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

;;; highlight current line
(global-hl-line-mode)
;;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts nil :noerror))
;;; set default split
(setq split-width-threshold nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; which-key
(when (require 'which-key nil :noerror)
  (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; powerline
(when (require 'powerline nil :noerror)
  (powerline-evil-vim-color-theme)
  (display-time-mode t))

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
(when (require 'yasnippet nil :noerror)
  ;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/")
  ;; (mapc 'yas/load-directory yas-snippet-dirs)
  (yas-global-mode 1)
  (yas-reload-all))

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
