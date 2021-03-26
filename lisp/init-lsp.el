;;; init-lsp --- Summary
;;; Commentary:

;;; Code:
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :hook ((python-mode . lsp-deferred)
         (rust-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-flycheck t))

;;; lsp extras
(use-package lsp-ui
  :ensure t
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable t
              lsp-ui-doc-header t
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'top
              lsp-ui-doc-use-webkit t
              lsp-ui-doc-border (face-foreground 'default)
              lsp-ui-sideline-enable nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-sideline-show-code-actions nil))

;; (use-package company-lsp
;;   :ensure t
;;   :init
;;   (setq company-lsp-async t
;;         company-lsp-enable-snippet t
;;         company-lsp-cache-candidates 'auto)
;;   :config
;;   (push 'company-lsp company-backends))

(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemac-error-list)

(use-package dap-mode
  :ensure t
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode t)
  (tooltip-mode t)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(provide 'init-lsp)
;;; init-lsp ends here
