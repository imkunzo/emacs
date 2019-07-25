;;;; yasnippet
(use-package yasnippet
  :ensure t
  :init
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"))
  (yas-global-mode t)
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t)

(use-package ivy-yasnippet
  :ensure t
  :bind (:map yas-minor-mode-map
              ("C-c y" . ivy-yasnippet)))

(provide 'init-yasnippet)
