;;; +org.el -*- lexical-binding: t; -*-

;;; org journal
(defun org-journal-file-header-func (time)
  "Custom function to create journal header."
  (concat
    (pcase org-journal-file-type
      (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
      (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
      (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
      (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

(after! org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid .t)
     (plantuml . t)
     (python . t)
     (rust . t)))
  ;; org mode
  (setq org-image-actual-width (/ (display-pixel-width) 2))
  ;; (setq org-image-actual-width 1024)
  ;; ob-mermaid
  (setq ob-mermaid-cli-path "/usr/local/bin/mmdc")
  ;; ob-plantuml
  (setq org-plantuml-jar-path (expand-file-name (concat (getenv "HOME") "/bin/plantuml.jar")))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  ;; org journal
  (setq org-journal-dir "~/Dropbox/OrgMode/journal"
        org-journal-file-type 'org-journal-file-header-func
        org-journal-enable-agenda-integration t)
  ;; org roam2
  (setq org-roam-directory "~/Dropbox/OrgMode/Roam")
  (org-roam-db-autosync-mode))

(after! (org-roam websocket)
  (use-package! org-roam-ui
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t)))
