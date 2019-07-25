;;; init-mermaid --- Sammury
;;; Commentary:
;;; Code:

(use-package mermaid-mode
  :ensure t
  :mode (("\\.mmd\\'" . mermaid-mode)
         ("\\.mermaid\\'" . mermaid-mode))
  :init
  (setq mermaid-mmdc-location (expand-file-name "~/node_modules/.bin/mmdc")))

(provide 'init-mermaid)

;;; init-mermaid.el ends here
