;;; init-evil --- Summary
;;; Commentary:

;;; Code:
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  ;; boot evil by default
  :config
  (evil-mode t))

 
(use-package evil-collection
  :ensure t
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  :init
  (evil-collection-init))

;; evil-leader
(use-package evil-leader
    :ensure t
    :init
    (global-evil-leader-mode)
    :config
    (setq evil-leader/in-all-states t)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
    ;;   ;; ace-jump-mode
    ;;   "<SPC>" 'ace-jump-word-mode
    ;;   ;; appearance
    ;;   "mb" 'toggle-menu-bar-mode-from-frame
      ;; buffers
      "bb" 'ivy-switch-buffer
      "bk" 'kill-buffer
      "bd" 'kill-this-buffer
    ;;   ;; windows
    ;;   "wd"'evil-window-delete
    ;;   "wv" 'evil-window-vsplit
    ;;   "ws" 'evil-window-split
    ;;   "wh" 'evil-window-left
    ;;   "wj" 'evil-window-down
    ;;   "wk" 'evil-window-up
    ;;   "wl" 'evil-window-right
      ;; files
      "ff" 'counsel-find-file
      "fr" 'counsel-recentf
      "fs" 'save-buffer
    ;;   ;; command
    ;;   "x" 'counsel-M-x
    ;;   ;; evil-tabs
    ;;   ;; "gt" 'elscreen-goto
    ;;   ;; magit
    ;;   "mgs" 'magit-status
    ;;   "mgc" 'magit-commit
    ;;   "mgt" 'magit-push
    ;;   "mgl" 'magit-pull
    ;;   ;; projectile
    ;;   "pfd" 'project--find-in-directory
    ;;   "pff" 'project-find-file
    ;;   "pfi" 'project-find-file-in
    ;;   "pfm" 'project-find-functions
    ;;   "pfr" 'project-find-regexp
    )
  ;; org download
    (evil-leader/set-key-for-mode 'org-mode "ods" 'org-download-screenshot)
    (evil-leader/set-key-for-mode 'org-mode "odd" 'org-download-delete)
    (evil-leader/set-key-for-mode 'org-mode "ode" 'org-download-edit)
    (evil-leader/set-key-for-mode 'org-mode "odi" 'org-downlaod-image)
    (evil-leader/set-key-for-mode 'org-mode "ody" 'org-download-yank)
;; projectile
    ;; (evil-leader/set-key-for-mode 'projectile-mode "pf" 'project-find-file)
  :bind
  (:map evil-insert-state-map
        ("C-g" . evil-normal-state)
        :map evil-visual-state-map
        ("C-c" . evil-exit-visual-state))
  :config
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
  (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit))

;; evil surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode t))

;; evil-tabs
;; (use-package evil-tabs
;;   :ensure t
;;   :init
;;   (global-evil-tabs-mode t)
;;   :config
;;   (evil-define-key 'normal evil-tabs-mode-map
;;            "gnt" 'elscreen-create
;;            "gkt" 'elscreen-kill))

(use-package org-evil
  :ensure t
  :after (org evil))

(provide 'init-evil)
;;; init-evil ends here
