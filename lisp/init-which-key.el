(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.5
        which-key-separator " → "
        which-key-unicode-correction 3
        ;; Set the prefix string that will be inserted in front of prefix commands
        ;; (i.e., commands that represent a sub-map).
        which-key-prefix-prefix "+" )
  (which-key-mode))

(provide 'init-which-key)
