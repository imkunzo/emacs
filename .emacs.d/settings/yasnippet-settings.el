;;;; yasnippet
(defvar yasnippet-packages '(yasnippet))

(dolist (p yasnippet-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(yas-global-mode t)

(provide 'yasnippet-settings)
