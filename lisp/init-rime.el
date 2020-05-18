(use-package rime
  :straight (rime :type git
                  :host github
                  :repo "DogLooksGood/emacs-rime"
                  :files ("*.el" "Makefile" "lib.c"))
  :bind
  (("S-SPC" . 'toggle-input-method)
   :map rime-mode-map
        ("C-`" . 'rime-send-keybinding)
        ;; ("S-SPC" . 'rime-force-enable)
   ;; :map rime-active-mode-map
        ;; ("S-SPC" . 'rime-inline-ascii))
  )
  :init
  (setq rime-show-candidate 'posframe
        ;; rime-disable-predicates
        ;; '(rime-predicate-after-alphabet-char-p
        ;;   rime-predicate-prog-in-code-p)
        ;; support shift-l, shift-r, control-l, control-r
        rime-inline-ascii-trigger 'shift-l)
  :custom
  (rime-librime-root "~/.emacs.d/librime/dist")
  (default-input-method "rime"))

(provide 'init-rime)
