;;;; ELPA
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")))

(setq package-enable-at-startup nil)
(package-initialize)

(defvar my-default-packages '(ac-cider
			      auto-complete
			      cider
			      clojure-mode
			      monokai-theme
			      paredit
			      rainbow-delimiters
			      yasnippet))

(dolist (p my-default-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'elpa-settings)