(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (setq projectile-completion-system 'ivy
        projectile-enable-caching nil
        projectile-indexing-method 'native
        projectile-require-project-root t)
  (projectile-global-mode))

(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-mode))

(provide 'init-projectile)
