;;; init-python --- python configuration
;;; Commentary:

;;; Code:
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (progn
	(setq python-shell-completion-native-enable nil)
	(add-hook 'python-mode-hook
			  (lambda ()
				(setq-default indent-tabs-mode t)
				(setq-default tab-width 4)
				(setq-default py-indent-tabs-mode t)
				(setq-default python-indent-offset 4)
				(add-to-list 'write-file-functions 'delete-trailing-whitespace)))

    ;; flycheck
    (add-hook 'python-mode-hook #'flycheck-mode)
    ;; python inferior completion
    (add-hook 'inferior-python-mode-hook #'company-mode)


    ;; company-anaconda
    (use-package company-anaconda
      :ensure t
      :init
      (eval-after-load 'company
        '(add-to-list 'company-backends 'company-anaconda)))


    ;; pyvenv
    (use-package pyvenv
      :ensure t
      :config
      (cond
       ((or *is-linux-p* *is-mac-p*)
        (setenv "WORKON_HOME" (expand-file-name "opt/pyvenv" (getenv "HOME"))))
       ((*is-windows-p*)
        (setenv "WORKON_HOME" "D:/opt/Python/venv"))))


    ;; anaconda
    (use-package anaconda-mode
      :ensure t
      :config
      (add-hook 'python-mode-hook #'anaconda-mode)
      (add-hook 'python-mode-hook #'anaconda-eldoc-mode))


    ;; py-autopep8
    ;; (use-package py-autopep8
    ;;   :ensure t
    ;;   :config
    ;;   (add-hook 'python-mode-hook 'yapf-mode)
    ;;   (add-hook 'python-mode-hook 'py-yapf-enable-on-save))
    ))


(provide 'init-python)
;;; init-python.el Ends here
