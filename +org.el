;;; +org.el -*- lexical-binding: t; -*-

(after! org
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

  ;; :bind
  ;; (:map global-map
  ;;       ("C-c c" . org-capture)
  ;;       ("C-c a" . org-agenda))

  :config
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
       (sql . t)))))
