;;; +sql.el -*- lexical-binding: t; -*-

(use-package! ejc-sql
  :commands
  (ejc-create-connection ejc-connect ejc-set-column-width-limit ejc-set-max-rows)
  :config
  (setq ejc-set-row-limit 1000
        ejc-result-table-impl 'orgtbl-mode      ;; 'ejc-result-mode
        ejc-use-flx t
        ejc-flx-threshold 3
        nrepl-sync-request-timeout 30)
  ;; company integration
  (push 'ejc-company-backend company-backends)
  (add-hook 'ejc-sql-minor-mode-hook
            (lambda ()
              (company-mode t)))
  (setq ejc-complete-on-dot t))
