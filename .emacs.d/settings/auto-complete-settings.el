;;;; auto-complete
(when (not (package-installed-p 'auto-complete))
  (package-install 'auto-complete))

(require 'auto-complete)
(require 'auto-complete-config)

(setq ac-delay 0.0)
(setq ac-quick-help-delay 0.5)
;; (setq ac-dwim t)
(setq ac-quick-help-prefer-pos-tip t)
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))
(set-default 'ac-sources
             '(ac-source-yasnippet
               ac-source-abbrev
               ac-source-dictionary
                                        ; ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
                                        ; ac-source-symbols
                                        ; ac-source-variables
                                        ; ac-source-imenu
                                        ; ac-source-functions
                                        ; ac-source-features
                                        ; ac-source-emacs-lisp-features
                                        ; ac-source-semantic
               ))

(add-to-list 'ac-dictionary-directories "~/.emacs.d/db/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;;  ;; keymap
;;  (setq ac-use-menu-map t)
;;  (define-key ac-complete-mode-map (kbd "<return>") nil)
;;  (define-key ac-complete-mode-map (kbd "RET") nil)
;;  (define-key ac-complete-mode-map (kbd "\M-j") 'ac-complete)
;;  (define-key ac-complete-mode-map (kbd "\M-n") 'ac-next)
;;  (define-key ac-complete-mode-map (kbd "\M-p") 'ac-previous)

(provide 'auto-complete-settings)
