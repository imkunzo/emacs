;;; init-org --- Summary
;;; Commentary:

;;; Code:

(use-package org
  :ensure org-plus-contrib
  :init
  (progn
    (setq org-agenda-custom-commands '(("c" "Simple agenda view"
                                        ((agenda "")
                                         (alltodo ""))))
          org-archive-mark-done nil
          org-catch-invisible-edits 'show
          org-edit-timestamp-down-means-later t
          org-enforce-todo-dependencies t
          org-export-coding-system 'utf-8
          org-export-kill-product-buffer-when-displayed t
          org-fast-tag-selection-single-key 'expert
          org-hide-emphasis-markers t
          org-hide-leading-stars t
          org-html-htmlize-output-type 'css
          org-html-validation-link nil
          org-image-actual-width nil
          org-log-done t
          org-log-into-drawer t
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-startup-indented t
          org-startup-with-inline-images t
          org-tags-column 80
          ;; org directories
          org-directory "~/Dropbox/OrgMode/GTD"
          org-agenda-files (list "~/Dropbox/OrgMode/GTD")
          org-mobile-inbox-for-pull "~/Dropbox/OrgMode/MobileOrg/mobileorg.org"
          org-mobile-directory "~/Dropbox/OrgMode/MobileOrg"
          ;; org todo keywords
          org-todo-keywords '((sequence "TODO(t!)" "DONE(d!)")
                              (sequence "|" "NEW(n)" "WAIT(w@)" "ABORT(a@/!)" "SOMEDAY(s)"))
          org-todo-keyword-faces '(("TODO" . org-warning)
                                   ("WAIT" . "yellow")
                                   ("SOMEDAY" . "white")
                                   ("NEW" . "red")
                                   ("ABORT" . "Grey"))
          ;; org latex
          org-latex-classes '(("article"
                               "\\documentclass[12pt,a4paper]{article}
                                \\usepackage[margin=2cm]{geometry}
                                \\usepackage{ctex}"
                               ("\\section{%s}" . "\\section*{%s}")
                               ("\\subsection{%s}" . "\\subsection*{%s}")
                               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                               ("\\paragraph{%s}" . "\\paragraph*{%s}")
                               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
          ;;
          org-latex-with-hyperref t
          org-latex-default-packages-alist '(("" "hyperref" nil)
                                             ("AUTO" "inputenc" t)
                                             ("" "fixltx2e" nil)
                                             ("" "graphicx" t)
                                             ("" "longtable" nil)
                                             ("" "float" nil)
                                             ("" "wrapfig" nil)
                                             ("" "rotating" nil)
                                             ("normalem" "ulem" t)
                                             ("" "amsmath" t)
                                             ("" "textcomp" t)
                                             ("" "marvosym" t)
                                             ("" "wasysym" t)
                                             ("" "multicol" t)
                                             ("" "amssymb" t)
                                             "\\tolerance=1000")
          ;; Use XeLaTeX to export PDF in Org-mode
          org-latex-pdf-process '("xelatex -interaction nonstopmode -output-directory %o %f"
                                  "xelatex -interaction nonstopmode -output-directory %o %f"
                                  "xelatex -interaction nonstopmode -output-directory %o %f"))

    ;; capture templates
    (setq org-capture-templates
          '(("a" "Appointment" entry (file  "~/Dropbox/OrgMode/GTD/gcal.org" )
	         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
            ("j" "Journal" entry (file+olp+datetree "~/Dropbox/OrgMode/GTD/note.org")
             "* %?\n %i\n\n")
            ("n" "New" entry (file+headline "~/Dropbox/OrgMode/GTD/task.org" "Inbox")
             "* NEW %?\nEntered On: %U\n\n")
            ("t" "Task" entry (file+headline "~/Dropbox/OrgMode/GTD/task.org" "Tasks")
             "* TODO %?\nEntered On: %U\n\n")
            ("i" "Idea" entry (file+headline "~/Dropbox/OrgMode/GTD/task.org" "Ideas")
             "* SOMEDAY %?\nEntered On: %U\n\n")
            ("c" "Calendar" entry (file+headline "~/Dropbox/OrgMode/GTD/task.org" "Calendar")
             "* TODO %?\nEntered On: %U\n\n")
            ("p" "Project" entry (file+headline "~/Dropbox/OrgMode/GTD/project.org" "Projects")
             "* TODO %?\nEntered On: %U\n\n")))

    ;; org export setting
    (setq org-export-backends '(ascii freemind gfm html icalendar latex md)))

  :bind
  (:map global-map
        ("C-c c" . org-capture)
        ("C-c a" . org-agenda))

  :config
  (progn
    ;; org bable
    (with-eval-after-load 'org
      (org-babel-do-load-languages
       'org-babel-load-languages
       `((R . t)
         (dot . t)
         (emacs-lisp . t)
         (latex . t)
         (plantuml . t)
         (python . t)
         (ruby . t)
         (screen . nil)
         (,(if (locate-library "ob-sh") 'sh 'shell) . t)
         (sql . t))))))

(use-package htmlize
  :ensure t)

;; org-bullets
(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷"))
  ;; (setq org-bullets-bullet-list '("①" "②" "③" "④" "⑤" "⑥" "⑦" "⑧"))
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode t))))

(use-package org-download
  :ensure-system-package (pngpaste . "brew install pngpaste") 
  :bind (("C-c d s" . org-download-screenshot)
         ("C-c d i" . org-download-image)
         ("C-c d y" . org-download-yank))
  :init
  (setq org-download-image-dir "./imgs"
        org-download-image-org-width 600
        org-download-image-attr-list '("#+ATTR_HTML: :width 60% :align center"))
  (cond (sys/macp
         (setq org-download-screenshot-method "pngpaste %s"))
        (sys/win32p
         (setq org-download-screenshot-method "convert clipboard: %s")))
  :config
  (add-hook 'dired-mode-hook 'org-download-enable))

;; org-web-tools
(use-package org-web-tools
  :ensure t)

;; github flavored markdown exporter
(use-package ox-gfm
  :ensure t
  :init
  (when (boundp 'org-export-backends)
    (customize-set-variable 'org-export-backends
                            (cons 'gfm org-export-backends))))

;; org export pandoc
(use-package ox-pandoc
  :ensure t
  :init
  (setq org-pandoc-options '((standalone . t))
		org-pandoc-options-for-docx '((standalone . nil))
		org-pandoc-options-for-beamer-pdf '((pdf-engine . "xelatex"))
		org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex"))))

;; org reveal
(use-package ox-reveal
  :ensure t)

;; org-gcal
(use-package org-gcal
  :ensure t
  :init
  (setq org-gcal-client-id "101938823939-ls7ugi8curo1ksg6v1ctr0md0vk917m8.apps.googleusercontent.com"
        org-gcal-client-secret "VdjZiK1gZi748bub_fwmQc51"
        org-gcal-fetch-file-alist '(("lizhikun@growing.io" .  "~/Dropbox/OrgMode/GTD/gcal.org")))
  :config
  (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync)))
  (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync))))

;; plantuml for org
(with-eval-after-load 'plantuml-mode
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml)))

;; org-roam
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Dropbox/Documents/org/roam")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

;; orag-roam-server
(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)
  (require 'org-roam-protocol))

(provide 'init-org)
;;; init-org ends here
