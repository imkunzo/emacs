;;; +flycheck.el -*- lexical-binding: t; -*-

(use-package! flycheck-rust
  :after (:all rustic rust-mode flycheck)
  :config
  (push 'rustic-clippy flycheck-checkers)
  (setq flycheck-rust-cargo-executable "~/.cargo/bin/cargo"
        flycheck-rust-clippy-executable "~/.cargo/bin/cargo-clippy")
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package! flycheck-pycheckers
  :after (:all python-mode flycheck)
  :config
  (setq flycheck-pycheckers-checkers 'pyflakes
        flycheck-python-pylint-executable "pylint")

  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))
