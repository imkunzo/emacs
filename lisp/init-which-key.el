(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (progn
    (setq which-key-idle-delay 0.5)))

(provide 'init-which-key)
