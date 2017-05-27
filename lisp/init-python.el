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
    ;; company
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-anaconda))
    ;; python inferior completion
    (add-hook 'inferior-python-mode-hook #'company-mode)


    ;; pyvenv
    (use-package pyvenv
      :ensure t
      :config
      (cond
       ((or *is-linux-p* *is-mac-p*)
        (setenv "WORKON_HOME" (expand-file-name "opt/python-venv" (getenv "HOME"))))
       ((*is-windows-p*)
        (setenv "WORKON_HOME" "D:/opt/Python/venv"))))


    ;; anaconda
    (use-package anaconda-mode
      :ensure t
      :config
      (add-hook 'python-mode-hook #'anaconda-mode)
      (add-hook 'python-mode-hook #'anaconda-eldoc-mode))


    ;; py-autopep8
    (use-package py-autopep8
      :ensure t
      :config
      (add-hook 'python-mode-hook 'py-yapf-enable-on-save))))


(provide 'init-python)
