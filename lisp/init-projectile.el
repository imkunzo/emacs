(use-package projectile
  :ensure t
  :bind
  (:map projectile-mode-map
        ("C-c p" . projectile-command-map))
  :init
  (setq projectile-enable-caching nil
        projectile-indexing-method 'native
        projectile-require-project-root t)
  (projectile-global-mode))

(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-mode))

(provide 'init-projectile)
