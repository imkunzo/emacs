(use-package magit
  :ensure t
  :init
  (global-magit-file-mode)
  :config
  (when *is-windows-p*
    (setq magit-git-executable "d:/opt/msys2/usr/bin/git.exe")))


(provide 'init-magit)
