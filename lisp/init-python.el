;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; python IDE
;;; install python ide packages
;; python indent
(add-hook 'python-mode-hook
	      (lambda ()
		    (setq-default indent-tabs-mode t)
		    (setq-default tab-width 4)
		    (setq-default py-indent-tabs-mode t)
			(setq-default python-indent-offset 4)
	        (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
;;; config python ide
(elpy-enable)
(setq python-shell-completion-native-enable nil)
;; pyvenv
(when (require 'pyvenv nil :noerror)
  (cond
   ;; python virtualenv workon directory
   ((or (eq system-type 'gnu/linux)
        (eq system-type 'darwin))
    (setenv "WORKON_HOME" (expand-file-name "opt/python-venv"
                                            (getenv "HOME"))))
   ((eq system-type 'windwos-nt)
    (setenv "WORKON_HOME" "D:/opt/Python/venv"))))
;; anaconda
(add-hook 'python-mode-hook #'anaconda-mode)
(add-hook 'python-mode-hook #'anaconda-eldoc-mode)
;; flycheck
(add-hook 'python-mode-hook #'flycheck-mode)
;; py-autopep8
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)
;; company
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-anaconda))
;; python inferior completion
(add-hook 'inferior-python-mode-hook #'company-mode)

(provide 'init-python)
