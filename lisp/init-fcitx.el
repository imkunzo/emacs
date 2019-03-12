;;; init-fcitx --- fcitx remote configuration
;;; Commentary:

;;; Code:
(use-package fcitx
  :ensure t
  :init
  (progn
    ;; (setq fcitx-active-evil-states '(insert emacs hybrid))
    (fcitx-aggressive-setup))
    (when *is-linux-p*
      (setq fcitx-use-dbus t))
  :config
  (progn
    ;; auto turn off fcitx when "M-x"
    (fcitx-M-x-turn-on)
    ;; auto turn off fcitx when "M-!"
    (fcitx-shell-command-turn-on)
    ;; auto turn off fcitx when "M-:"
    (fcitx-eval-expression-turn-on)
    ;; auto turn off fcitx with prefix keys
    (fcitx-prefix-keys-add "C-c" "C-h" "C-s" "C-x" "M-s" "M-o")
      (fcitx-prefix-keys-turn-on)))

(provide 'init-fcitx)
;;; init-fcitx.el ends here
