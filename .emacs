(setenv "HOME" "D:/Emacs")
(setenv "PATH" (concat "D:\\Opt\\Cygwin\\bin;" (getenv "PATH")))
(add-to-list 'exec-path "d:/Opt/Cygwin/bin")
(setq default-directory "~/")

;;;;    (add-hook 'comint-output-filter-functions 
;;;;    	  'shell-strip-ctrl-m nil t)
;;;;    (add-hook 'comint-output-filter-functions 
;;;;    	  'comint-watch-for-password-prompt nil t)
;;;;    (setq explicit-shell-file-name "bash.exe")
;;;;    ;; For subprocesses invoked via the shell
;;;;    ;; (e.g., "shell -c command")
;;;;    (setq shell-file-name explicit-shell-file-name) 

;;;; Emacs
;;; {{{
(tool-bar-mode -1)
;; (menu-bar-mode nil)
(scroll-bar-mode -1)
;; 不显示欢迎界面
(setq inhibit-startup-message t)
;; 不生成临时文件
(setq-default make-backup-files nil)
;; 反显选中区域
(transient-mark-mode t)
;; 自动匹配括号
(electric-pair-mode t)
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 光标靠近鼠标时，鼠标自动移开
;; (mouse-avoidance-mode 'animate)
;; 解决emacs shell 乱码 
(setq ansi-color-for-comint-mode t) 
(customize-group 'ansi-colors) 
(kill-this-buffer);关闭customize窗口 
(setq default-major-mode 'text-mode);一打开就起用 text 模式 

;; (set-frame-parameter (selected-frame) 'alpha (list 90 50))
;; (add-to-list 'default-frame-alist (cons 'alpha (list 90 50)))
;; 启动后最大化Emacs窗口
(run-with-idle-timer 1 nil 'w32-send-sys-command 61488)
;; (add-to-list 'default-frame-alist '(width  . 90))
;; (add-to-list 'default-frame-alist '(height . 40))

(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")

(setq indent-tabs-mode nil) 
(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
(setq tab-stop-list (number-sequence 4 120 4)) 

(setq default-buffer-file-coding-system 'gbk)
(prefer-coding-system 'gbk)

;; 设置默认浏览器为Conkeror
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "d:/Opt/Conkeror/conkeror/conkeror.exe")

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(setq save-abbrevs t)

;; 设置临时目录
(setq temporary-file-directory "d:/_WinTMP")
;;; }}}


;;;; Fonts
;;; {{{
;; Setting English Font
(set-face-attribute
  'default nil :font "Monaco")
 
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "MicroSoft YaHei" :size 16)))
;;; }}}


;;;; color-theme
;;; {{{
(add-to-list 'custom-theme-load-path "~/.emacs.d/molokai-theme/")
(load-theme 'molokai t)
;;; }}}


;;;; linum-mode
;;; {{{
(global-linum-mode 1)
;; (setq linum-format "%5d")
;;; }}}


;;;; ido-mode
;;; {{{
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-enable-last-directory-history nil)
;;; }}}


;;;; iimage mode
;;; {{{
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (iimage-mode))
;;; }}}


;;;; el-get
;;; {{{
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)
;;; }}}


;;;; load path
;;; {{{
(setq load-path
      (append (list nil
		    "~/.emacs.d/plugins"
		    ) load-path))
;;; }}}


;;;; cedet
;;; {{{
(require 'semantic/ia)
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/db/semanticdb"))

(setq semantic-default-submodes
      '(
	global-semanticdb-minor-mode
	global-semantic-highlight-edits-mode
	global-semantic-idle-local-symbol-highlight-mode
;;	global-cedet-m3-minor-mode
	;; code helpers
	global-semantic-idle-scheduler-mode
	global-semantic-idle-summary-mode
	global-semantic-idle-completions-mode
	;; eye candy
	global-semantic-decoration-mode
	global-semantic-highlight-func-mode
	global-semantic-highlight-edits-mode
	global-semantic-stickyfunc-mode
	;; debugging semantic itself
	global-semantic-show-parser-state-mode t
	global-semantic-show-unmatched-syntax-mode t
	))
(semantic-mode t)

(global-ede-mode t)
;;; }}}


;;;; Tramp
;;; {{{
(add-to-list 'load-path "~/.emacs.d/tramp/lisp/")
(require 'tramp)
(add-to-list 'exec-path "d:/Opt/PuTTY")
(setq tramp-default-method "plink")
(setq tramp-debug-buffer t)
;;; }}}


;;;;; Yasnippet
;;; {{{
(require 'yasnippet)
(setq yas-snippet-dirs
	  '("~/.emacs.d/snippets" ;; personal snippets
        ))
(yas-global-mode 1)
;;; }}}


;;;;; org-mode
;;; {{{
(require 'org-install)
(require 'org-publish)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; fix some org-mode + yasnippet conflicts:
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "d:/Dropbox/org/index.org" "Tasks")
         "* TODO %^{Description} %^g\n%?\nAdded: %U\n")
        ("c" "Calendar" entry (file+headline "d:/Dropbox/org/index.org" "Calendar")
         "* TODO %^{Description} %^g\n%?\nAdded: %U\n")
        ("p" "Projects" entry (file+headline "d:/Dropbox/org/index.org" "Projects")
         "* TODO %^{Description} %^g\n%?\nAdded: %U\n")
        ("n" "Notes" entry (file+headline "d:/Dropbox/org/notes.org" "Notes")
         "* %^{Description} %^g %? Added: %U\n")
        ("j" "Journal" entry (file+datetree "d:/Dropbox/org/journal.org")
         "* %^{Description} %^g %? Added: %U\n")))

(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")
))

(setq org-agenda-files (list "d:/Dropbox/org/index.org"
                             "d:/Dropbox/org/notes.org"
                             "d:/Dropbox/org/journal.org"))
;;; }}}


;;;; slime
;;; {{{
(add-to-list 'load-path "d:/Opt/SBCL")
(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy))
;;; }}}


;;;; php-mode
;;; {{{
;;    (require 'php-mode)
;;    
;; To use abbrev-mode
(add-hook 'php-mode-hook
	  '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
;;; }}}


;;    ;;;; nxhtml-mode
;;    ;;; {{{
;;    
;;    ;; Workaround the annoying warnings:
;;    ;;    Warning (mumamo-per-buffer-local-vars):
;;    ;;    Already 'permanent-local t: buffer-file-name
;;    (when (and 
;;           (>= emacs-major-version 24)
;;           (>= emacs-minor-version 2))
;;      (eval-after-load "mumamo"
;;        '(setq mumamo-per-buffer-local-vars
;;               (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;;    ;;; }}}


;;;; xcscope
;;; {{{
(require 'xcscope)
;; (setq cscope-do-not-update-database t)
;;; }}}


;;;; auto-complete 
;;; {{{
(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-yasnippet)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/db/ac-dict")
;; (require 'auto-complete+)
(ac-config-default)
(global-auto-complete-mode t)

(setq ac-quick-help-prefer-pos-tip t)

;; keymap
(setq ac-use-menu-map t)
;;    (define-key ac-complete-mode-map (kbd "<return>") nil)
;;    (define-key ac-complete-mode-map (kbd "RET") nil)
;;    (define-key ac-complete-mode-map (kbd "\M-j") 'ac-complete)
;;    (define-key ac-complete-mode-map (kbd "\M-n") 'ac-next)
;;    (define-key ac-complete-mode-map (kbd "\M-p") 'ac-previous)

;; auto-complete semantic
(defun ac-semantic-construct-candidates (tags)
   "Construct candidates from the list inside of tags."
   (apply 'append
	  (mapcar (lambda (tag)
		    (if (listp tag)
			(let ((type (semantic-tag-type tag))
			      (class (semantic-tag-class tag))
			      (name (semantic-tag-name tag)))
			  (if (or (and (stringp type)
				       (string= type "class"))
				  (eq class 'function)
				  (eq class 'variable))
			      (list (list name type class))))))
		  tags)))


(defvar ac-source-semantic-analysis nil)
(setq ac-source-semantic
  `((sigil . "b")
    (init . (lambda () 
	      (setq ac-source-semantic-analysis
		    (condition-case nil
			(ac-semantic-construct-candidates (semantic-fetch-tags))))))
    (candidates . (lambda ()
                    (if ac-source-semantic-analysis
                        (all-completions ac-target (mapcar 'car ac-source-semantic-analysis)))))))

;; auto-complete slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
;;; }}}
