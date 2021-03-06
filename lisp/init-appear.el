;;; init-appear --- Summary
;;; Commentary:
;;; Code:

;; transparent
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; default encoding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;; TAB indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; highlight current line
(global-hl-line-mode)
;;; set default split
(setq split-width-threshold nil)
;;; very long line performence optimizy
(when emacs/>=27p
  (global-so-long-mode t))

;; (use-package monokai-theme
;;   :ensure t
;;   :init
;;   (load-theme 'monokai t))

;; (use-package zenburn-theme
;;   :ensure t
;;   :init
;;   (load-theme 'zenburn t))

;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-tomorrow-eighties t))

(use-package atom-one-dark-theme
  :ensure t
  :init
  (load-theme 'atom-one-dark t))

;; (use-package srcery-theme
;;   :ensure t
;;   :init
;;   (setq srcery-org-height nil)
;;   :config
;;   (load-theme 'srcery))

;; (use-package solarized-theme
;;   :ensure t
;;   :init
;;   (setq solarized-emphasize-indicators nil)
;;   (setq solarized-scale-org-headlines nil)
;;   (load-theme 'solarized-light t))

;; (use-package color-theme-sanityinc-solarized
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-solarized-light t))

;; (use-package spacemacs-theme
;;   :ensure t
;;   :init
;;   (load-theme 'spacemacs-light t))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package awesome-tab
  :straight (awesome-tab :type git
                         :host github
                         :repo "manateelazycat/awesome-tab")
  :init
  (setq awesome-tab-style 'box)
  :config
  (awesome-tab-mode t))

;; (use-package doom-modeline
;;   :ensure t
;;   :after (projectile all-the-icons)
;;   :hook (after-init . doom-modeline-mode)
;;   :init
;;   (setq doom-modeline-minor-modes nil
;;         doom-modeline-github t
;;         doom-modeline-lsp t))

;; (use-package spaceline-all-the-icons
;;   :ensure t
;;   :init
;;   (spaceline-all-the-icons-theme)
;;   (spaceline-all-the-icons--setup-anzu)            ;; Enable anzu searching
;;   (spaceline-all-the-icons--setup-package-updates) ;; Enable package update indicator
;;   (spaceline-all-the-icons--setup-git-ahead)       ;; Enable # of commits ahead of upstream in git
;;   (spaceline-all-the-icons--setup-paradox)         ;; Enable Paradox mode line
;;   (spaceline-all-the-icons--setup-neotree)         ;; Enable Neotree mode line
;;   (setq spaceline-all-the-icons-separator-type 'arrow))

(provide 'init-appear)
;;; init-appear ends here
