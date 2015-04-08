;; -*- lisp -*-

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
;; 光标靠近鼠标时，鼠标自动移开
;; (mouse-avoidance-mode 'animate)
;; 解决emacs shell 乱码 
(setq ansi-color-for-comint-mode t) 
(customize-group 'ansi-colors) 
(kill-this-buffer);关闭customize窗口 
(setq default-major-mode 'text-mode);一打开就起用 text 模式 
;; default browser
(setq browse-url-generic-program (executable-find "conkeror"))
(setq browse-url-browser-function 'browse-url-generic)
;;; }}}


;;;; Fonts
;;; {{{
;; Setting English Font
(set-face-attribute
  'default nil :font "Inconsolata 12")
 
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "WenQuanYi Micro Hei" :size 16)))
;;; }}}


;;;; color-theme
;;; {{{
(add-to-list 'custom-theme-load-path "~/.emacs.d/molokai-theme/")
(setq molokai-theme-kit t)
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


;;;; 括号的自动匹配和高亮显示
;;; {{{
;;    (setq electric-pair-skip-self nil)
;;    (electric-pair-mode t)
(smartparens-global-mode t)
(sp-pair "'" nil :actions :rem)
(sp-pair "`" nil :actions :rem)

(setq hl-paren-colors
      '("Red" "DeepSkyBlue" "Yellow" "Lime" "Magenta"))
(define-global-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

(global-highlight-parentheses-mode t)

(require 'mic-paren)
(paren-activate)
(setq paren-dont-touch-blink t)
(setq paren-match-face 'highlight)
(setq paren-sexp-mode nil)
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


;;;; Yasnippet
;;; {{{
(require 'yasnippet)
(setq yas-snippet-dirs
	  '("~/.emacs.d/snippets" ;; personal snippets
        ))
(yas-global-mode 1)
;;; }}}


;;;; org-mode
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
;;; }}}


;;    ;;;; auctex
;;    ;;; {{{
;;    (load "auctex.el" nil t t)
;;    (load "preview.el" nil t t)
;;    (mapc (lambda (mode)
;;    	(add-hook 'LaTeX-mode-hook mode))
;;          (list 'auto-fill-mode
;;    	    'LaTeX-math-mode
;;    	    'turn-on-reftex
;;    	    ; 'linum-mode
;;    	    ))
;;    
;;    (add-hook 'LaTeX-mode-hook
;;    	  (lambda ()
;;    	    (setq TeX-auto-untabify t     ;remove all tabs before saving
;;    		  TeX-engine 'xetex       ;use xelatex default
;;    		  TeX-show-compilation t) ;display compilation windows
;;    	    (TeX-global-PDF-mode t)       ;PDF mode enable, not plain
;;    	    (setq TeX-save-query nil)
;;    	    (imenu-add-menubar-index)
;;    	    (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
;;    (setq TeX-view-program-list '("MuPDF" "mupdf %o"))
;;    (setq TeX-view-program-selection '((output-pdf "MuPDF") (output-dvi "MuPDF")))
;;    ;;; }}}


;;;; slime
;;; {{{
;; (add-to-list 'load-path "d:/Opt/SBCL")
(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy))

(add-hook 'slime-load-hook 
	  #'(lambda ()
	      (define-key 'slime-prefix-map (kbd "M-h") 'slime-documentation-lookup)))
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
(define-key ac-complete-mode-map (kbd "<return>") nil)
(define-key ac-complete-mode-map (kbd "RET") nil)
(define-key ac-complete-mode-map (kbd "\M-j") 'ac-complete)
(define-key ac-complete-mode-map (kbd "\M-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "\M-p") 'ac-previous)

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
