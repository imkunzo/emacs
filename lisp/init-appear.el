;;;; appearance
;;; default encoding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;; TAB indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; highlight current line
(global-hl-line-mode)
;;; set default split
(setq split-width-threshold nil)

(use-package monokai-alt-theme
  :ensure t
  :init
  (load-theme 'monokai-alt t))


(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


(use-package powerline
  :ensure t
  :init
  (display-time-mode t)
  :config
  (use-package powerline-evil
    :ensure t
    :init
    (powerline-evil-vim-color-theme)))


(provide 'init-appear)
