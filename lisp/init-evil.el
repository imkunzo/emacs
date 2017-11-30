;;; init-evil --- Summary
;;; Commentary:

;;; Code:
(use-package evil
  :ensure t
  :init
  (progn
    ;; boot evil by default
    (evil-mode t)

    ;; elscreen
    ;; (use-package elscreen
    ;;   :ensure t
    ;;   :init
    ;;   (elscreen-start))

    ;; evil-leader
    (use-package evil-leader
      :ensure t
      :init
      (global-evil-leader-mode)
      :config
      (progn
        (setq evil-leader/in-all-states t)
        (evil-leader/set-leader "<SPC>")
        (evil-leader/set-key
          ;; ace-jump-mode
          "<SPC>" 'ace-jump-word-mode
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
          ;; "gt" 'elscreen-goto
          ;; magit
          "mgs" 'magit-status
          "mgc" 'magit-commit
          "mgt" 'magit-push
          "mgl" 'magit-pull))))
  :bind
  (:map evil-insert-state-map
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

    
;; evil-tabs
;; (use-package evil-tabs
;;   :ensure t
;;   :init
;;   (global-evil-tabs-mode t)
;;   :config
;;   (evil-define-key 'normal evil-tabs-mode-map
;;            "gnt" 'elscreen-create
;;            "gkt" 'elscreen-kill))


(provide 'init-evil)
;;; init-evil ends here
