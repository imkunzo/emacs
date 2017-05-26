;; key binding
(define-key global-map "\C-cc" 'org-capture)

;; Various preferences
(setq org-log-done t
      org-edit-timestamp-down-means-later t
      org-archive-mark-done nil
      org-hide-emphasis-markers t
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)

;; capture templates
(setq org-capture-templates
     '(("j" "Journal" entry (file+datetree "~/Dropbox/ORG/journal.org")
        "* %?\n Entered On: %U\n %i\n %a")))

;;; org sync with google calendar
;;
(when (and (require 'calfw nil :noerror)
           (require 'calfw-org nil :noerror)
           (require 'org-gcal nil :noerror))
  (setq org-gcal-client-id "something.apps.googleusercontent.com"
        org-gcal-client-secret "something"
        org-gcal-file-alist '(("lizhikun@growing.io" .  "~/Dropbox/ORG/gcal.org"))))

;;; org bable
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
     ;; (,(if (locate-library "ob-sh") 'sh 'shell) . t)
     (shell . t)
     (sql . t))))

;; org babel defaul header args
(add-to-list 'org-babel-default-header-args:shell
             '(:results . drawer))

;;; github flavored markdown exporter
(use-package ox-gfm
  :init
  (when (boundp 'org-export-backends)
    (customize-set-variable 'org-export-backends
                            (cons 'gfm org-export-backends))))

;; org export setting
(setq org-export-backends '(ascii freemind gfm html icalendar latex md))


(provide 'init-org)
