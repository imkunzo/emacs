;;; init-lsp --- Summary
;;; Commentary:

;;; Code:
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :hook (prog-mode . lsp)
  :init
  (require 'lsp-clients)
  (require 'lsp-ui-imenu)
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-flycheck t
        lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  :config
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  ;;; ;; lsp python
  ;;; (lsp-register-client
  ;;;  (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
  ;;;                   :major-modes '(python-mode)
  ;;;                   :server-id 'pyls))
  ;;; 
  ;;; (add-hook 'python-mode-hook #'lsp)
  ;;; 
  ;;; ;; NB: only required if you prefer flake8 instead of the default
  ;;; ;; send pyls config via lsp-after-initialize-hook -- harmless for
  ;;; ;; other servers due to pyls key, but would prefer only sending this
  ;;; ;; when pyls gets initialised (:initialize function in
  ;;; ;; lsp-define-stdio-client is invoked too early (before server
  ;;; ;; start)) -- cpbotha
  ;;; (defun lsp-set-cfg ()
  ;;;   (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
  ;;;     ;; TODO: check lsp--cur-workspace here to decide per server / project
  ;;;     (lsp--set-configuration lsp-cfg)))
  ;;; 
  ;;; (add-hook 'lsp-after-initialize-hook 'lsp-set-cfg)
  )

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
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-sideline-show-code-actions nil)
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
        company-lsp-cache-candidates 'auto)
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ivy
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

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
