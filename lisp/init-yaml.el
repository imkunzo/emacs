;;; yaml-mode --- Summary
;;; Commentary:
;;; Code:
(use-package yaml-mode
  :ensure t
  :mode (("\\.ya?ml\\'" . yaml-mode)
         ("\\.toml\\'" . yaml-mode))
  :config
  (progn
    (put 'yaml-indent-offset 'safe-local-variable 'integerp)))

(provide 'init-yaml)
;;; init-yaml.el ends here
