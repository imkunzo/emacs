;;; init-linum --- Summary
;;; Commentary:

;;; Code:
(use-package nlinum-relative
  :ensure t
  :init
  (setq nlinum-relative-redisplay-delay 0)
  (setq nlinum-relative-current-symbol "")
  (setq nlinum-relative-offset 0)
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))


(provide 'init-linum)
;;; init-linum ends here
