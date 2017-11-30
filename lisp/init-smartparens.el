;;; init-smartparens --- Summary
;;; Commentary:

;;; Code:
(use-package smartparens
  :ensure t
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode t)))

(provide 'init-smartparens)
