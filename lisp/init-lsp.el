;;; init-lsp --- Summary
;;; Commentary:

;;; Code:
(use-package lsp-mode
  :ensure t
  :init
  (require 'lsp-clients)
  (add-hook 'programming-mode-hook 'lsp)
  :config
  (setq lsp-prefer-flymake nil))

;; lsp extras
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :init
  (with-eval-after-load 'lsp-mode
    (push 'company-lsp company-backends)))

;; (use-package lsp-rust
  ;; :ensure t
  ;; :init
  ;; (with-eval-after-load 'lsp-mode
    ;; (setq lsp-rust-rls-command '("rustup" "run" "stable" "rls")))
  ;; :config
  ;; (add-hook 'rust-mode-hook #'lsp-rust-enable))

(provide 'init-lsp)
;;; init-lsp ends here
