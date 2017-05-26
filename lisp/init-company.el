;; TODO Default sort order should place [a-z] before punctuation

(setq tab-always-indent 'complete)  ;; use 't when company is disabled
(add-to-list 'completion-styles 'initials t)
;; Stop completion-at-point from popping up completion buffers so eagerly
(setq completion-cycle-threshold 5)


(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (diminish 'company-mode "CMP")
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-select-next)
    (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev)
                  company-dabbrev-other-buffers 'all))
  (global-set-key (kbd "M-C-/") 'company-complete)
  (when (maybe-require-package 'company-quickhelp)
    (add-hook 'after-init-hook 'company-quickhelp-mode))

  (defun pufferfish/local-push-company-backend (backend)
    "Add BACKEND to a buffer-local version of `company-backends'."
    (set (make-local-variable 'company-backends)
         (append (list backend) company-backends))))


;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines-mode
    (defvar pufferfish/page-break-lines-on-p nil)
    (make-variable-buffer-local 'pufferfish/page-break-lines-on-p)

    (defun pufferfish/page-break-lines-disable (&rest ignore)
      (when (setq pufferfish/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun pufferfish/page-break-lines-maybe-reenable (&rest ignore)
      (when pufferfish/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'pufferfish/page-break-lines-disable)
    (add-hook 'company-completion-finished-hook 'pufferfish/page-break-lines-maybe-reenable)
    (add-hook 'company-completion-cancelled-hook 'pufferfish/page-break-lines-maybe-reenable)))


(provide 'init-company)
