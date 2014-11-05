;;;; cider-mode
(require 'cider)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-use-clojure-font-lock t)
;;Stop the error buffer from popping up while working in buffers other than the REPL
(setq cider-popup-stacktraces nil)

;;  (defun cider-eval-last-sexp-and-append ()
;;    "Evaluate the expression preceding point and append result."
;;    (interactive)
;;    (let* ((last-sexp (if (region-active-p)
;;  			(buffer-substring (region-beginning) (region-end))
;;  		      (cider-last-sexp)))
;;           (last-results (cider-eval-and-get-value last-sexp)))
;;      (with-current-buffer (current-buffer)
;;        (comment-indent)
;;        (insert " => ")
;;        (insert (prin1-to-string last-results)))))

(defun cider-send-and-evaluate-sexp ()
  "Sends the s-expression located before the point or the active
region to the REPL and evaluates it. Then the Clojure buffer is
activated as if nothing happened."
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
	    (local-set-key (kbd "C-c C-v") 'cider-send-and-evaluate-sexp)
	    ;; (local-set-key (kbd "C-c C-s") 'cider-eval-last-sexp-and-append)
	    ))

;;;; eldoc-mode
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;;;; paredit-mode
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)

;; ac-cider
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;;;; clojure-color-scheme
;;  (defmacro defclojureface (name color desc &optional others)
;;    `(defface ,name '((((class color)) (:foreground ,color ,@others))) ,desc :group 'faces))
;;  
;;  (defclojureface clojure-parens       "DimGrey"   "Clojure parens")
;;  (defclojureface clojure-braces       "#49b2c7"   "Clojure braces")
;;  (defclojureface clojure-brackets     "SteelBlue" "Clojure brackets")
;;  (defclojureface clojure-keyword      "khaki"     "Clojure keywords")
;;  (defclojureface clojure-namespace    "#c476f1"   "Clojure namespace")
;;  (defclojureface clojure-java-call    "#4bcf68"   "Clojure Java calls")
;;  (defclojureface clojure-special      "#b8bb00"   "Clojure special")
;;  (defclojureface clojure-double-quote "#b8bb00"   "Clojure special" (:background "unspecified"))
;;  
;;  (defun tweak-clojure-syntax ()
;;    (mapcar (lambda (x) (font-lock-add-keywords nil x))
;;            '((("#?['`]*(\\|)"       . 'clojure-parens))
;;              (("#?\\^?{\\|}"        . 'clojure-brackets))
;;              (("\\[\\|\\]"          . 'clojure-braces))
;;              ((":\\w+"              . 'clojure-keyword))
;;              (("#?\""               0 'clojure-double-quote prepend))
;;              (("nil\\|true\\|false\\|%[1-9]?" . 'clojure-special))
;;              (("(\\(\\.[^ \n)]*\\|[^ \n)]+\\.\\|new\\)\\([ )\n]\\|$\\)" 1 'clojure-java-call))
;;              )))
;;  
;;  (add-hook 'clojure-mode-hook 'tweak-clojure-syntax)
;;  (add-hook 'cider-repl-mode-hook 'tweak-clojure-syntax)

(provide 'clojure-settings)
