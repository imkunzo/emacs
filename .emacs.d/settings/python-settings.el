(defvar python-ide-packages '(elpy
                              anaconda-mode
                              company-anaconda
                              ;; nose
                              ;;jedi
                              py-autopep8
                              pylint
                              ;; virtualenvwrapper
                              flymake-python-pyflakes
                              color-identifiers-mode))

(dolist (p python-ide-packages)
  (when (not (package-installed-p p))
    (package-install p)))

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

;; anaconda mode
(add-to-list 'company-backends 'company-anaconda)
(add-hook 'python-mode-hook 'anaconda-mode)

;; lint
(when (require 'flymake-python-pyflakes nil 'noerror)
  (add-hook 'python-mode-hook 'flymake-python-pyflakes-load))

;; py-autopep8
(when (require 'py-autopep8 nil 'noerror)
  (add-hook 'before-save-hook 'py-autopep8-before-save))

;;    ;; jedi
;;    (when (require 'jedi nil 'noerror)
;;      ;; (require 'jedi)
;;      ;; (add-hook 'python-mode-hook 'jedi:setup)
;;      ;; (add-hook 'python-mode-hook 'jedi:ac-setup)
;;      (add-to-list 'company-backends 'company-jedi)
;;      (setq jedi:setup-keys t)
;;      (setq jedi:complete-on-dot t))

;;eldoc
(add-hook 'python-mode-hook 'turn-on-eldoc-mode)

(provide 'python-settings)
