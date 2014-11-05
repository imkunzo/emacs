(defvar python-ide-packages '(elpy
                              ;; nose
                              jedi
                              py-autopep8
                              pylint
                              ;; virtualenvwrapper
                              flymake-python-pyflakes
                              color-identifiers-mode))

(dolist (p python-ide-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; (require 'python)

;; tab configuration
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-hook 'python-mode-hook '(lambda () (setq python-indent 4)))

;; color the defined variables
(add-hook 'python-mode-hook 'color-identifiers-mode)

;; self businese
(when (fboundp 'global-prettify-symbols-mode)
  (add-hook 'python-mode-hook
            (lambda ()
              (push '("self" . ?◎) prettify-symbols-alist)
              (modify-syntax-entry ?. "."))))

;; elpy
(when (require 'elpy nil 'noerror)
  (elpy-enable)
  ;; (elpy-clean-modeline)
  (elpy-use-ipython))

;; lint
(when (require 'flymake-python-pyflakes nil 'noerror)
  ;; (require 'flymake-python-pyflakes)
  (add-hook 'python-mode-hook 'flymake-python-pyflakes-load))

;; py-autopep8
(when (require 'py-autopep8 nil 'noerror)
  (add-hook 'before-save-hook 'py-autopep8-before-save))

;; jedi
(when (require 'jedi nil 'noerror)
  ;; (require 'jedi)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t))

(provide 'python-settings)
