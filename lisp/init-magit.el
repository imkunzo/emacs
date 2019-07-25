(use-package magit
  :ensure t
  :init
  (global-magit-file-mode)
  :config
  (when sys/win32p
    (setq magit-git-executable "d:/opt/msys2/usr/bin/git.exe")))


(provide 'init-magit)
