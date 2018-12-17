;;; init-rust --- rust ide configuration
;;; Commentary:

;;; Code:
(use-package rust-mode
  :ensure t
  :init
  (setq rust-format-on-save t)
  :config
  (add-hook 'rust-mode-hook #'flycheck-mode)
  :bind
  (:map rust-mode-map
        ("C-c <tab>" . rust-format-buffer))
  :mode "\\.rs\\'"
  :interpreter "rust")

(use-package cargo
      :ensure t
      :init
      (progn
        (setenv "PATH" (concat (getenv "PATH")
                             ":"
                             (concat (getenv "HOME") "/.cargo/bin")))
        (add-hook 'rust-mode-hook 'cargo-minor-mode)
        (add-hook 'cargo-process-mode-hook (lambda ()
                                             (setq truncate-lines nil)))))

(use-package racer
      :ensure t
      :init
      (progn
        (setq racer-rust-src-path (concat (replace-regexp-in-string "\n" ""
                                                                    (shell-command-to-string "rustc --print sysroot"))
                                          "/lib/rustlib/src/rust/src")
              racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
        (add-hook 'rust-mode-hook #'racer-mode)
        (add-hook 'racer-mode-hook #'eldoc-mode)
        (add-hook 'racer-mode-hook #'company-mode)))

(use-package evcxr
  :straight (evcxr
             :type git
             :host github
             :repo "serialdev/evcxr-mode"
             :config
             (add-hook 'rust-mode-hook #'evcxr-minor-mode)))

(provide 'init-rust)
;;; init-rust.el ends here
