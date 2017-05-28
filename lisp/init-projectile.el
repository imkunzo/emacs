(use-package projectile
  :ensure t
  :init
  (projectile-global-mode)
  :config
  (progn
    (setq projectile-indexing-method 'native)
    (setq projectile-enable-caching nil)
    (setq projectile-require-project-root t)))


(provide 'init-projectile)
