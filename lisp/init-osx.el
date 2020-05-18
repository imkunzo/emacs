;;; init-osx --- configurations for macos
;;; Commentary:

;;; Code:
(defvar osx-use-option-as-meta t
  "If non nil the option key is mapped to meta. Set to `nil` if you need the
  option key to type common characters.")

;; (setenv "LC_CTYPE" "UTF-8")
;; (setenv "LC_ALL" "en_US.UTF-8")
;; (setenv "LANG" "en_US.UTF-8")

(setq shell-file-name "/bin/zsh"
      temporary-file-directory "/tmp/")

(use-package exec-path-from-shell
  :ensure t
  :init
  (setenv "SHELL" "/bin/zsh")
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("PATH" "PYTHONPATH")))

(when (display-graphic-p)
  ;;Treat command as super
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'super)

  (when osx-use-option-as-meta
    ;; Treat option as meta
    (setq mac-option-key-is-meta t))
  (setq mac-option-modifier (if osx-use-option-as-meta 'meta nil))

  ;; Keybindings
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-c") 'kill-ring-save)
  ;; (global-set-key (kbd "s-c") 'evil-yank)
  )

;; Use the OS X Emoji font for Emoticons
(when (fboundp 'set-fontset-font)
  (set-fontset-font "fontset-default"
                    '(#x1F600 . #x1F64F)
                    (font-spec :name "Apple Color Emoji") nil 'prepend))

(provide 'init-osx)
;;; init-osx.el ends here
