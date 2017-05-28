;;;; Rust IDE
(use-package rust-mode
  :ensure t
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
    (use-package cargo
      :ensure t
      :config
      (progn
        (add-hook 'rust-mode-hook 'cargo-minor-mode)
        (add-hook 'cargo-process-mode-hook (lambda ()
                                             (setq truncate-lines nil)))))
    (use-package racer
      :ensure t
      :init
      (add-hook 'rust-mode-hook #'racer-mode)
      :config
      (progn
        (add-hook 'racer-mode-hook #'eldoc-mode)
        (add-hook 'racer-mode-hook #'company-mode))
      :bind
      (:map rust-mode-map
            ("M-." . racer-find-definition))))
  :config
  (progn
    (add-hook 'rust-mode-hook #'flycheck-mode))
  :bind
  (:map rust-mode-map
        ("C-c <tab>" . rust-format-buffer)))


(provide 'init-rust)