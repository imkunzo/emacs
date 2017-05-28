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


;;;; Bootstrap config
(require 'init-utils)
(require 'init-site-lisp)
(require 'init-elpa)

;;; config gui fonts
(when (window-system)
  (require 'init-gui-fonts))

;;; basic config
(require 'init-appear)
(require 'init-linum)
(require 'init-evil)
(require 'init-ivy)
(require 'init-which-key)
(require 'init-paredit)

;;; tools
(require 'init-org)
(require 'init-magit)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-projectile)
(require 'init-flycheck)
(require 'init-fcitx)
(require 'init-yaml)

;;; IDE
(require 'init-python)
(require 'init-clojure)
(require 'init-rust)

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

;;; init.el ends here
