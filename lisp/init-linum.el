(use-package nlinum-relative
  :init
  (setq nlinum-relative-redisplay-delay 0)
  (setq nlinum-relative-current-symbol "")
  (setq nlinum-relative-offset 0)
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))


(provide 'init-linum)