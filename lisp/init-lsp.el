;;; init-lsp --- Summary
;;; Commentary:

;;; Code:
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :hook (prog-mode . lsp)
  :init
  (require 'lsp-clients)
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-flycheck t
        lsp-clients-python-library-directories '("/usr/local/" "/usr/")))

;; lsp extras
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
              lsp-ui-sideline-ignore-duplicate t)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(use-package company-lsp
  :ensure t
  :init
  (setq company-lsp-async t
        company-lsp-enable-snippet t
        company-lsp-cache-candidates 'auto))

(use-package lsp-treemacs
  :ensure t)

(use-package dap-mode
  :ensure t
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode t))

(provide 'init-lsp)
;;; init-lsp ends here
