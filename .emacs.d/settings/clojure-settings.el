(defvar clojure-ide-packages '(clojure-mode
                               ;; clojure-cheatsheet
                               ;; clojure-snippets
                               ;; clojurescript-mode
                               cider
                               ac-cider
                               ;; clj-refactor
                               ;; elein
                               paredit
                               ;; popup
                               ;; ;; Mode for alternating paren colors
                               rainbow-delimiters
                               ;; rainbow-mode
                               ))

(dolist (p clojure-ide-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; clojure-mode
(require 'clojure-mode)

;; clojure indent
;; get better indentation for Compojure macros
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

;; Making it easier to read some Clojure code by changing into actual symbols.
;; (when (fboundp 'global-prettify-symbols-mode)
;;   (defconst clojure--prettify-symbols-alist
;;     '(("fn"  . ?λ)
;;       ("->" . ?→)
;;       ("->>" . ?⇉)
;;       ("<=" . ?≤)
;;       (">=" . ?≥)
;;       ("==" . ?≡)   ;; Do I like this?
;;       ("not=" . ?≠) ;; Or even this?
;;       ("." . ?•)
;;       ("__" . ?⁈))))

;; binding keys to jump to the next "__" phrase
(add-hook 'clojure-mode-hook
          '(lambda ()
             ;; Two under-bars are used as "stuff to do"
             (highlight-phrase "__" 'hi-red-b)))

(defun clojure-next-issue ()
  (interactive)
  (search-forward "__")
  (set-mark (- (point) 2))
  (setq mark-alive t))

(global-set-key (kbd "<f2> q") 'clojure-next-issue)

;; cider-mode
;; color the REPL
(setq cider-repl-use-clojure-font-lock t)
;; Don' t care much for the extra buffers that show up when you start
(setq nrepl-hide-special-buffers t)
;; Stop the error buffer from popping up while working in buffers other than the REPL
(setq cider-popup-stacktraces nil)
;; To get Clojure’s Cider working with org-mode
;; (require 'ob-clojure)
;; (setq org-babel-clojure-backend 'cider)(require 'cider)

;; (defun cider-eval-and-get-value (input &optional ns session)
;;   "Send the INPUT to the nREPL server synchronously and return the value.
;; NS & SESSION specify the evaluation context."
;;   (cider-get-value (cider-eval-sync input ns session)))

;; (defun cider-eval-and-get-value (input &optional ns session no-read)
;;   "Send the INPUT to the nREPL server synchronously and return the value. NS & SESSION specify the evaluation context.  Unless NO-READ is non-nil, use 'read' to convert the output into an emacs object."
;;   (let ((result (plist-get (cider-eval-sync input ns session) :value)))
;;     (if no-read
;;         result
;;       (read result))))
;; 
;; ;; eval last S-Expression
;; (defun cider-eval-last-sexp-and-append ()
;;   "Evaluate the expression preceding point and append result."
;;   (interactive)
;;   (let* ((last-sexp (if (region-active-p)
;;                         (buffer-substring (region-beginning) (region-end))
;;                       (cider-last-sexp)))
;;          (last-results (cider-eval-and-get-value last-sexp)))
;; 
;;     (with-current-buffer (current-buffer)
;;       (comment-indent)
;;       (insert " => ")
;;       (insert (prin1-to-string last-results)))))

;; send the S-Expression to the REPL and evaluate it
(defun cider-send-and-evaluate-sexp ()
  "Sends the s-expression located before the point or the activeregion to the REPL and evaluates it. Then the Clojure buffer isactivated as if nothing happened."
  (interactive)
  (if (not (region-active-p))
      (cider-insert-last-sexp-in-repl)
    (cider-insert-in-repl
     (buffer-substring (region-beginning) (region-end)) nil))
  (cider-switch-to-repl-buffer)
  (cider-repl-closing-return)
  (cider-switch-to-last-clojure-buffer)
  (message ""))


(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "M-e") 'forward-sexp)
            (local-set-key (kbd "M-a") 'backward-sexp)
            ;; (local-set-key (kbd "C-c C-S-v") 'cider-eval-last-sexp-and-append)
            (local-set-key (kbd "C-c C-v") 'cider-send-and-evaluate-sexp)))

;; paredit
(require 'paredit)
;; Associate the following Lisp-based modes with ParEdit
(defun turn-on-paredit () (paredit-mode t))
(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit)
(add-hook 'lisp-mode-hook 'turn-on-paredit)
(add-hook 'lisp-interaction-mode-hook 'turn-on-paredit)
;; (add-hook 'scheme-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'cider-repl-mode-hook 'turn-on-paredit)
;; (add-hook 'sibiliant-mode-hook  'turn-on-paredit)

(defun paredit-delete-indentation (&optional arg)
  "Handle joining lines that end in a comment."
  (interactive "*P")
  (let (comt)
    (save-excursion
      (move-beginning-of-line (if arg 1 0))
      (when (skip-syntax-forward "^<" (point-at-eol))
        (setq comt (delete-and-extract-region (point) (point-at-eol)))))
    (delete-indentation arg)
    (when comt
      (save-excursion
        (move-end-of-line 1)
        (insert " ")
        (insert comt)))))

(defun paredit-remove-newlines ()
  "Removes extras whitespace and newlines from the current pointto the next parenthesis."
  (interactive)
  (let ((up-to (point))
        (from (re-search-forward "[])}]")))
    (backward-char)
    (while (> (point) up-to)
      (paredit-delete-indentation))))

(define-key paredit-mode-map (kbd "C-^") 'paredit-remove-newlines)
(define-key paredit-mode-map (kbd "M-^") 'paredit-delete-indentation)

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\" return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then  open and indent an empty line between the cursor and the text.  Move the  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then  open and indent an empty line between the cursor and the text.  Move the  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

;; rainbow-delimiters-mode
(add-hook 'prog-mode-hook  'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; ac-cider
;; CIDER-specific configuration for auto completion
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))
;; popup doc with C-c C-d
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;; eldoc
;; get ElDoc working with Clojure and Emacs Lisp
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(provide 'clojure-settings)
