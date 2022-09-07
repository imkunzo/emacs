;;; +lsp-bridge.el -*- lexical-binding: t; -*-

(use-package! lsp-bridge
  :load-path "~/.emacs.d/.local/straight/repos/lsp-bridge"
  :init
  (setq lsp-bridge-enable-debug nil
        lsp-bridge-enable-log nil
        lsp-bridge-python-command "/usr/local/bin/python3.9")
  ;; (setq lsp-bridge-enable-auto-format-code t)
  :config
  (evil-collection-define-key 'insert 'lsp-bridge-mode-map (kbd "C-n") #'acm-select-next)
  (evil-collection-define-key 'insert 'lsp-bridge-mode-map (kbd "C-p") #'acm-select-prev)
  (evil-collection-define-key 'insert 'lsp-bridge-mode-map (kbd "C-j") #'acm-select-next)
  (evil-collection-define-key 'insert 'lsp-bridge-mode-map (kbd "C-k") #'acm-select-prev)
  (global-lsp-bridge-mode))

(map! :after lsp-bridge
      :map (lsp-bridge-mode-map)
      :leader
      (:prefix-map ("l" . "lsp-bridge")
       :desc "documentation" "d" 'lsp-bridge-lookup-documentation
       (:prefix ("f" . "find")
        :desc "define" "d" 'lsp-bridge-find-def
        :desc "references" "r" 'lsp-bridge-find-references
        :desc "backward" "b" 'lsp-bridge-return-from-def
        (:prefix ("j" "jump to diagnostic")
         :desc "define" "d" 'lsp-bridge-jump-to-def-in-other-window
         :desc "next" "n" 'lsp-bridge-jump-to-next-diagnostic
         :desc "prev" "p" 'lsp-bridge-jump-to-prev-diagnostic)
        (:prefix ("o" . "other-window")
         :desc "define" "d" 'lsp-bridge-find-def-other-window
         :desc "impl" "i" 'lsp-bridge-find-impl-other-window))))
