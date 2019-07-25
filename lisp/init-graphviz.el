;;; init-graphviz --- configurations for macos
;;; Commentary:
(use-package graphviz-dot-mode
  :ensure t
  :bind(("C-c C-g p" . graphviz-dot-preview)
        ("C-c C-g v" . graphviz-dot-view))
  :init
  (setq graphviz-dot-view-command "dot %s -Tpng | open"))

(provide 'init-graphviz)
;;; Code:
;;; init-graphviz.el ends here
