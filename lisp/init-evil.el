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


;; evil surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode t))

;; evil org
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; general.el
(use-package general
  :ensure t
  :init
  (setq general-describe-priority-keymaps nil
        general-describe-keymap-sort-function #'general-sort-by-car
        general-describe-state-sort-function #'general-sort-by-car
        ;; sort keybindings alphabetically by key
        general-describe-keybinding-sort-function #'general-sort-by-car
        ;; sort keybindings alphabetically by definition
        general-describe-keybinding-sort-function #'general-sort-by-cadr)
  :config
  (general-define-key
   :keymaps 'ansi-term-raw-map
   "s-c" 'term-paste)
  
  (general-create-definer leader-definer
    :prefix "SPC")

  (general-create-definer mode-leader-definer
    :prefix "SPC m")

  (general-create-definer prog-leader-definer
    :prefix "SPC p")

  (general-create-definer org-leader-definer
    :prefix "SPC o")

  (leader-definer
    :states 'normal
    ;; hydra of awesome-tab
    "b" '(hydra/awesome-fast-switch/body :wk "awesome-tab")
    ;; counsel file
    "f f" 'counsel-find-file
    "f r" 'counsel-recentf
    "f s" 'save-buffer
    "x" 'counsel-M-x)

  (leader-definer
    :states 'normal
    :keymaps 'elpy-refactor-map
    "r" '(elpy-refactor-mode-map :wk "elpy-refactor"))

  (mode-leader-definer
    :states 'normal
    "p" '(projectile-command-map :wk "projectile")
    "t" '(treemacs :wk "treemacs"))

  (prog-leader-definer
    :states 'normal
    :keymaps '(python-mode-map elpy-mode-map)
    :wk "python-mode"
    "p" '(poetry :wk "poetry")
    "s" '(elpy-shell-map :wk "elpy-shell-command")
    "r" '(elpy-format-code :wk "elpy-format-code")))

(provide 'init-evil)
;;; init-evil ends here
