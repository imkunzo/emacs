;;; init-org --- Summary
;;; Commentary:

;;; Code:
(use-package org
  :ensure t
  :init
  (progn
    (setq org-log-done t
          org-startup-indented t
          org-edit-timestamp-down-means-later t
          org-archive-mark-done nil
          org-hide-emphasis-markers t
          org-catch-invisible-edits 'show
          org-export-coding-system 'utf-8
          org-fast-tag-selection-single-key 'expert
          org-html-validation-link nil
          org-html-htmlize-output-type 'css
          org-export-kill-product-buffer-when-displayed t
          org-tags-column 80
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-log-into-drawer t
          org-enforce-todo-dependencies t
          ;; org-bullets
          org-bullets-bullet-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷")
          ;; org directories
          org-directory "~/Dropbox/GTD"
          org-agenda-files (list "~/Dropbox/GTD")
          org-mobile-inbox-for-pull "~/Dropbox/MobileOrg/mobileorg.org"
          org-mobile-directory "~/Dropbox/MobileOrg"
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
          '(("j" "Journal" entry (file+datetree "~/Dropbox/GTD/Note.org")
             "* %?\n %i\n %a\n")
            ("n" "New" entry (file+headline "~/Dropbox/GTD/Inbox.org" "Inbox")
             "* NEW %?\n Entered On: %U\n %a\n")
            ("t" "Task" entry (file+headline "~/Dropbox/GTD/Task.org" "Tasks")
             "* TODO %?\n Entered On: %U\n %a\n")
            ("i" "Idea" entry (file+headline "~/Dropbox/GTD/Task.org" "Ideas")
             "* SOMEDAY %?\n Entered On: %U\n %a\n")
            ("c" "Calendar" entry (file+headline "~/Dropbox/GTD/Task.org" "Calendar")
             "* TODO %?\n Entered On: %U\n %a\n")
            ("p" "Project" entry (file+headline "~/Dropbox/GTD/Project.org" "Projects")
             "* TODO %?\n Entered On: %U\n %a\n")))

    ;; org export setting
    (setq org-export-backends '(ascii freemind gfm html icalendar latex md)))

  :bind
  (:map global-map
        ("C-c c" . org-capture)
        ("C-c a" . org-agenda))

  :config
  (progn
    ;; org bable
    (after-load 'org
      (org-babel-do-load-languages
       'org-babel-load-languages
       `((R . t)
         (dot . t)
         (emacs-lisp . t)
         (latex . t)
         (python . t)
         (ruby . t)
         (screen . nil)
         (,(if (locate-library "ob-sh") 'sh 'shell) . t)
         (sql . t))))

    ;; github flavored markdown exporter
    (use-package ox-gfm
      :ensure t
      :init
      (when (boundp 'org-export-backends)
        (customize-set-variable 'org-export-backends
                                (cons 'gfm org-export-backends))))
    (use-package htmlize
      :ensure t)

    (use-package iimage
      :ensure t
      :init
      (progn
        (autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
        (autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
        (defun org-toggle-iimage-in-org ()
          "display images in your org file"
          (interactive)
          (if (face-underline-p 'org-link)
              (set-face-underline-p 'org-link nil)
            (set-face-underline-p 'org-link t))
          (iimage-mode))))

    ;; org sync with google calendar
    (when (and (require 'calfw nil :noerror)
               (require 'calfw-org nil :noerror)
               (require 'org-gcal nil :noerror))
      (setq org-gcal-client-id "something.apps.googleusercontent.com"
            org-gcal-client-secret "something"
            org-gcal-file-alist '(("lizhikun@growing.io" .  "~/Dropbox/ORG/gcal.org"))))))

(provide 'init-org)
;;; init-org ends here
