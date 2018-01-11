;;; rust --- rust ide configuration
;;; Commentary:

;;; Code:
(use-package rust-mode
  :ensure t
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
    (use-package cargo
      :ensure t
      :init
      (setenv "PATH" (concat (getenv "PATH")
                             ":"
                             (concat (getenv "HOME") "/.cargo/bin")))
      :config
      (progn
        (add-hook 'rust-mode-hook 'cargo-minor-mode)
        (add-hook 'cargo-process-mode-hook (lambda ()
                                             (setq truncate-lines nil)))))
    (use-package racer
      :ensure t
      :init
      (progn
        (setq racer-rust-src-path (concat (replace-regexp-in-string "\n" ""
                                                                    (shell-command-to-string "rustc --print sysroot"))
                                          "/lib/rustlib/src/rust"))
        (setq racer-cmd (executable-find "racer")))
      :config
      (progn
        (add-hook 'rust-mode-hook #'racer-mode)
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
;;; init-rust.el ends here
