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


(provide 'init-flycheck)
;;; init-flycheck ends here
