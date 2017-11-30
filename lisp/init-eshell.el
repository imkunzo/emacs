;;; init-eshell --- Summary
;;; Commentary:
;;; Code:
(setq eshell-scroll-to-bottom-on-input 'all
      eshell-error-if-no-glob t
      eshell-hist-ignoredups t
      eshell-save-history-on-exit t
      eshell-prefer-lisp-functions nil)

(add-hook 'eshell-mode-hook (lambda ()
                              (add-to-list 'eshell-visual-commands "ssh")
                              (add-to-list 'eshell-visual-commands "tail")
                              ;; aliases
                              (eshell/alias "ff" "find-file")
                              (eshell/alias "ffo" "find-file-other-window")
                              ;; The 'ls' executable requires the Gnu version on the Mac
                              ;; (let ((ls (if (file-exists-p "/usr/local/bin/gls")
                              ;;               "/usr/local/bin/gls"
                              ;;             "/bin/ls")))
                              ;;   (eshell/alias "ll" (concat ls " -al"))
                              ;;   (eshell/alias "la" (concat ls " -aF")))))

                              (eshell/alias "ll" (concat ls " -al"))
                              (eshell/alias "la" (concat ls " -aF"))))

(provide 'init-eshell)
;;; init-eshell.el ends here
