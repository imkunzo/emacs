;;;; flycheck
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (with-eval-after-load 'flycheck 'flycheck-pos-tip-mode))


(provide 'init-flycheck)
