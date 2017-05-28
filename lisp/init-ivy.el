(defun pufferfish/enable-ivy-flx-matching ()
  "Make `ivy' matching work more like IDO."
  (interactive)
  (require-package 'flx)
  (setq-default ivy-re-builders-alist
                '((t . ivy--regex-fuzzy))))


(use-package ivy
  :ensure t
  :init
  (add-hook 'after-init-hook
            (lambda ()
              (when (bound-and-true-p ido-ubiquitous-mode)
                (ido-ubiquitous-mode -1))
              (when (bound-and-true-p ido-mode)
                (ido-mode -1))
              (ivy-mode t)))
  :bind
  (:map ivy-minibuffer-map
        ("C-j" . ivy-immediate-done)
        ("RET" . ivy-alt-done))
  :config
  (progn
    (setq-default ivy-use-virtual-buffers t
                  ivy-count-format ""
                  projectile-completion-system 'ivy
                  ivy-initial-inputs-alist
                  '((man . "^")
                    (woman . "^")))))


(use-package ivy-historian
  :ensure t
  :init
  (add-hook 'after-init-hook (lambda () (ivy-historian-mode t))))


(use-package counsel
  :ensure t
  :init
  (progn
    (setq-default counsel-mode-override-describe-bindings t)
    (add-hook 'after-init-hook 'counsel-mode))
  :bind
  (:map global-map
        ("M-y" . counsel-yank-pop)))


(use-package swiper
  :ensure t
  :bind
  (:map ivy-mode-map
        ("C-s" . swiper)))


(provide 'init-ivy)
