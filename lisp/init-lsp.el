;;; init-lsp --- Summary
;;; Commentary:

;;; Code:
(use-package lsp-mode
  :ensure t
  :init
  (require 'lsp-clients)
  (setq lsp-prefer-flymake nil
        lsp-enable-flycheck t)
  (add-hook 'prog-mode-hook 'lsp))

;; lsp extras
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :init
  (setq company-lsp-async t
        company-lsp-enable-snippet t)
  (with-eval-after-load 'lsp-mode
    (push 'company-lsp company-backends)))

(provide 'init-lsp)
;;; init-lsp ends here
