(use-package evil
  :init
  (progn
    (use-package evil-tabs
      :init
      (global-evil-tabs-mode)
      :config
      (progn (evil-define-key 'normal evil-tabs-mode-map
               "gnt" 'elscreen-create
               "gkt" 'elscreen-kill)))
    (use-package evil-leader
      :init
      (global-evil-leader-mode)
      :config
      (progn
        (setq evil-leader/in-all-states t)
        (evil-leader/set-leader "<SPC>")
        (evil-leader/set-key
         ;; appearance
         "mb" 'toggle-menu-bar-mode-from-frame
         ;; buffers
         "bb" 'ivy-switch-buffer
         "bk" 'kill-buffer
         "bd" 'kill-this-buffer
         ;; windows
         "wv" 'evil-window-vsplit
         "ws" 'evil-window-split
         "wh" 'evil-window-left
         "wj" 'evil-window-down
         "wk" 'evil-window-up
         "wl" 'evil-window-right
         ;; files
         "ff" 'counsel-find-file
         "fr" 'counsel-recentf
         "fs" 'save-buffer
         ;; command
         "x" 'counsel-M-x
         ;; projectile
         "pf" 'project-find-file
         ;; evil-tabs
         "gt" 'elscreen-goto
         ;; magit
         "mgs" 'magit-status
         "mgc" 'magit-commit
         "mgt" 'magit-push
         "mgl" 'magit-pull)))
    (evil-mode t))
  :bind (:map evil-insert-state-map
              ("C-g" . evil-normal-state)
              :map evil-visual-state-map
              ("C-c" . evil-exit-visual-state))
  :config
  (progn
    (define-key evil-normal-state-map (kbd "q") nil)
    (define-key evil-insert-state-map (kbd "C-e") nil)
    (define-key evil-insert-state-map (kbd "C-d") nil)
    (define-key evil-insert-state-map (kbd "C-k") nil)
    (define-key evil-motion-state-map (kbd "C-e") nil)
    ;; esc should always quit
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)))


(provide 'init-evil)
