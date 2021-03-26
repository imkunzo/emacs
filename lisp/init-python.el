;;; init-python --- python configuration
;;; Commentary:

(defun send-input-and-indent ()
  (interactive)
  (comint-send-input)
  (indent-for-tab-command))

(use-package elpy
  :ensure t
  ;; :bind (:map inferior-python-mode-map
  ;;             ("C-j" . send-input-and-indent))
  :init
  ;; (setq ;; elpy-rpc-python-command "python3"
  ;;       ;; python-shell-interpreter "ipython"
  ;;       ;; python-shell-interpreter-args "--simple-prompt --pprint"
  ;;  python-shell-completion-native-enable nil)
  (setq elpy-shell-echo-output nil
        elpy-rpc-python-command "python3.9"
        elpy-rpc-timeout 10
        elpy-rpc-virtualenv-path 'current
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt --pprint"
        python-shell-completion-native-enable nil)
  ;; (setq elpy-shell-echo-output nil
  ;;       elpy-rpc-python-command "python3.9"
  ;;       elpy-rpc-timeout 10
  ;;       elpy-rpc-virtualenv-path 'current
  ;;       python-shell-interpreter "jupyter"
  ;;       python-shell-interpreter-args "console --simple-prompt"
  ;;       python-shell-prompt-detect-failure-warning nil)
  :config
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters
  ;;              "jupyter")
  ;; python indent
  (add-hook 'python-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil
                    python-indent-guess-indent-offset nil
                    python-indent-offset 4)))
  ;; flycheck
  (add-hook 'python-mode-hook #'flycheck-mode)
  ;; python inferior completion
  (add-hook 'inferior-python-mode-hook #'company-mode)
  ;; Remove flymake hook
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  ;; pythonpaths
  (add-hook 'python-mode-hook
          (lambda ()
            (setq python-shell-extra-pythonpaths
                  (list (projectile-ensure-project (projectile-project-root))
                        (concat (projectile-ensure-project (projectile-project-root))
                                "src")))))
  ;; (advice-add 'python-mode :before 'elpy-mode)
  (add-hook 'python-mode-hook #'elpy-enable))

(use-package pipenv
  :ensure t
  :hook (python-mode . pipenv-mode)
  :init
  (setq pipenv-projectile-after-switch-function
        #'pipenv-projectile-after-switch-extended))

(use-package poetry
  :ensure t)

(provide 'init-python)
;;; init-python.el Ends here
