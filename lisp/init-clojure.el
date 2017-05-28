(use-package clojure-mode
  :ensure t
  :init
  (progn
    (use-package cider
      :ensure t
      :init
      (add-hook 'clojure-mode-hook 'cider-mode-hook)
      :config
      (progn
        ;; eldoc setting for clojure
        (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
        ;; paredit setting for clojure
        (add-hook 'cider-mode-hook #'enable-paredit-mode)
        (add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
        ;; rainbow-delimiters setting for clojure
        (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)))
    (use-package flycheck-clojure
      :ensure t
      :init
      (eval-after-load 'flycheck '(flycheck-clojure-setup))))
  :config
  (progn
    (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'clojure-mode-hook 'enable-paredit-mode)
    ;; flycheck setting for clojure
    (add-hook 'clojure-mode-hook 'flycheck-mode-hook)))


(provide 'init-clojure)
