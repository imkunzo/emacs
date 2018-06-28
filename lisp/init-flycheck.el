;;; init-flycheck --- Summary
;;; Commentary:

;;; Code:
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (progn
    (setq-default flycheck-disabled-checkers '(emacs-lisp))
    (with-eval-after-load 'flycheck 'flycheck-pos-tip-mode)))

(use-package flycheck-rust
  :ensure t
  :init
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(provide 'init-flycheck)
;;; init-flycheck ends here
