;;; init-company --- Summary
;;; Commentary:

;;; Code:
(use-package company
  :ensure t
  :init
  (progn
    (setq company-minimum-prefix-length 1)
    (setq company-idle-delay 0.5)
    
    (setq tab-always-indent 'complete) ;; use 't when company is disabled
    (add-to-list 'completion-styles 'initials t)
    ;; Stop completion-at-point from popping up completion buffers so eagerly
    (setq completion-cycle-threshold 5)
    (setq company-dabbrev-downcase nil)
    (add-hook 'after-init-hook 'global-company-mode))
  :config
  (progn
    (use-package company-quickhelp
      :ensure t
      :init
      (add-hook 'after-init-hook 'company-quickhelp-mode))

    (defun pufferfish/local-push-company-backend (backend)
      "Add BACKEND to a buffer-local version of `company-backends'."
      (set (make-local-variable 'company-backends)
           (append (list backend) company-backends)))

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
        (add-hook 'company-completion-cancelled-hook 'pufferfish/page-break-lines-maybe-reenable))))
  :bind (
         :map company-active-map
         ("C-c h" . company-quickhelp-manual-begin)
         :map company-mode-map
         ("M-/" . company-complete)))


(provide 'init-company)
;;; init-company ends here
