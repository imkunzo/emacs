(use-package ein
  :ensure t
  :commands ein:notebooklist-open
  :init
  (require 'ein)
  (require 'ein-notebook)
  (require 'ein-subpackages)
  (setq ein:completion_backend '(ein:use-company-backend)
        ein:notebook-mode '(ein:notebook-plain-mode ein:notebook-python-mode)))

;; (use-package jupyter
  ;; :ensure t
  ;; :defer t
  ;; :init
  ;; (add-to-list 'load-path "~/.emacs.d/jupyter/jupylet-0.8.2.tar")
  ;; (require 'jypyter))

(provide 'init-ein)
