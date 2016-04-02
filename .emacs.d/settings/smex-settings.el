(defvar smex-packages '(smex))

(dolist (p smex-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(provide 'smex-settings)
