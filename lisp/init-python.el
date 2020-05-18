;;; init-python --- python configuration
;;; Commentary:

;;; Code:
;; python mode
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i --pprint"
      python-shell-completion-native-enable nil)

(defun my-extra-pythonpaths ()
  (add-to-list 'python-shell-extra-pythonpaths
               projectile-project-root))

(add-hook 'python-mode-hook 'my-extra-pythonpaths)

;; (use-package elpy
;;   :ensure t
;;   :init
;;   ;; (setq ;; elpy-rpc-python-command "python3"
;;   ;;       ;; python-shell-interpreter "ipython"
;;   ;;       ;; python-shell-interpreter-args "--simple-prompt --pprint"
;;   ;;  python-shell-completion-native-enable nil)
;;   (setq elpy-shell-echo-output nil
;;         elpy-rpc-virtualenv-path 'current
;;         python-shell-interpreter "ipython"
;;         python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i")
;;   ;; (elpy-enable)
;;   (advice-add 'python-mode :before 'elpy-enable)
;;   :config
;;   ;; flycheck
;;   (add-hook 'python-mode-hook #'flycheck-mode)
;;   ;; python inferior completion
;;   (add-hook 'inferior-python-mode-hook #'company-mode)
;;   ;; Remove flymake hook
;;   (remove-hook 'elpy-modules 'elpy-module-flymake))

;; lsp-python
;; (use-package lsp-python
;;   :ensure t
;;   :config
;;   (add-hook 'python-mode-hook #'lsp-python-enable))

;; ;; anaconda
;; (use-package anaconda-mode
;;       :ensure t
;;       :config
;;       (add-hook 'python-mode-hook #'anaconda-mode)
;;       (add-hook 'python-mode-hook #'anaconda-eldoc-mode))
;;
;; ;; company-anaconda
;; (use-package company-anaconda
;;       :ensure t
;;       :init
;;       (with-eval-after-load 'company
;;         (push 'company-anaconda company-backends)))

;; pyvenv
;; (use-package pyvenv
;;       :ensure t
;; 	  :after (:all python-mode elpy)
;;       :config
;;       (cond
;;        ((or *is-linux-p* *is-mac-p*)
;;         (setenv "WORKON_HOME" (expand-file-name "venv" (getenv "HOME"))))
;;        ((*is-windows-p*)
;;         (setenv "WORKON_HOME" "D:/opt/Python/venv"))))

;; py-autopep8
;; (use-package py-autopep8
;;       :ensure t
;;       :config
;;       (add-hook 'python-mode-hook 'yapf-mode)
;;       (add-hook 'python-mode-hook 'py-yapf-enable-on-save))

(use-package pipenv
  :ensure t
  :hook (python-mode . pipenv-mode)
  :init
  (setq pipenv-projectile-after-switch-function
        #'pipenv-projectile-after-switch-extended))

(provide 'init-python)
;;; init-python.el Ends here
