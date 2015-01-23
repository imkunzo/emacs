;;;; yasnippet
(when (not (package-installed-p 'yasnippet))
  (package-install 'yasnippet))

(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(yas-global-mode t)

(provide 'yasnippet-settings)
