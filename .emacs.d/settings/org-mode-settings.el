(defvar org-mode-packages '(org))

(dolist (p org-mode-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'org-install)
;; (require 'org-publish)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
          (lambda ()
            (setq truncate-lines nil)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(provide 'org-mode-settings)
