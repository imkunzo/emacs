;;; init-plantuml --- Sammury
;;; Commentary:
;;; Code:

(use-package plantuml-mode
  :ensure t
  :init
  (setq org-plantuml-jar-path (expand-file-name "~/bin/plantuml.jar")
        plantuml-jar-path (expand-file-name "~/bin/plantuml.jar")
        plantuml-jar-args (list "-charset" "utf-8" "-tpng")
        plantuml-mode-debug-enabled t)
  :config
  (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode)))

(provide 'init-plantuml)

;;; init-plantuml.el ends here
