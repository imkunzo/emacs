(when *is-linux-p*
  (use-package fcitx
    :ensure t
    :init
    (progn
      (setq fcitx-use-dbus t)
      (setq fcitx-active-evil-states '(insert emacs hybrid))
      (fcitx-aggressive-setup))
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
    (fcitx-prefix-keys-turn-on))))


(provide 'init-fcitx)
