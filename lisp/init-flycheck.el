;;; init-flycheck --- Summary
;;; Commentary:

;;; Code:
(use-package flycheck
  :ensure t
  :init
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)
  (progn
    (setq-default flycheck-disabled-checkers '(emacs-lisp))
    (with-eval-after-load 'flycheck 'flycheck-pos-tip-mode)))

(use-package flycheck-rust
  :ensure t
  :after (rust-mode)
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package flycheck-pycheckers
  :ensure t
  :after (:all python-mode elpy flycheck)
  :init
  (setq flycheck-pycheckers-checkers 'pyflakes)
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))

(provide 'init-flycheck)
;;; init-flycheck ends here
