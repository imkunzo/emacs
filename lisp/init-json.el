;;; json-mode --- Summary
;;; Commentary:
;;; Code:
(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)))

(use-package json-reformat
  :ensure t)

(provide 'init-json)
;;; init-json.el ends here
