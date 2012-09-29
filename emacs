;;;;;
;; KlausLee's emacs configuration
;; Time-stamp: <klaus 09/28/2012 03:00:39>

;;;;;
;; Emacs common configurations
;; {{{
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ecb-layout-window-sizes (quote (("left8" (0.25 . 0.2916666666666667) (0.25 . 0.22916666666666666) (0.25 . 0.2916666666666667) (0.25 . 0.16666666666666666)))))
 '(ecb-options-version "2.40")
 '(scroll-bar-mode nil)
 '(semantic-python-dependency-system-include-path (quote ("/usr/lib64/python2.7/site-packages/rope-0.9.4-py2.7.egg" "/usr/lib64/python2.7/site-packages/ropemacs-0.7-py2.7.egg" "/usr/lib64/python2.7/site-packages/ropemode-0.2-py2.7.egg" "/home/klaus/Workspace/Python/jingfen" "/usr/lib64/portage/pym" "/usr/share/emacs/24.1/etc" "/usr/lib64/python27.zip" "/usr/lib64/python2.7" "/usr/lib64/python2.7/plat-linux2" "/usr/lib64/python2.7/lib-tk" "/usr/lib64/python2.7/lib-old" "/usr/lib64/python2.7/lib-dynload" "/usr/lib64/python2.7/site-packages" "/usr/lib64/python2.7/site-packages/gtk-2.0")))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-message t)
(set-frame-parameter (selected-frame) 'alpha (list 80 80))
(add-to-list 'default-frame-alist (cons 'alpha (list 80 80)))
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")
;; }}}

;;;;;
;; Load Path
;; {{{
(setq load-path
	     (append (list nil 
			   "~/.emacs.d/plugins/color-theme" 
			   "~/.emacs.d/plugins/pymacs" 
			   "~/.emacs.d/plugins/pycomplete" 
			   "~/.emacs.d/plugins/ropemacs-0.7" 
			   "~/.emacs.d/plugins/python-mode.el-6.0.11" 
			   "~/.emacs.d/plugins/ecb" 
			   "~/.emacs.d/plugins/yasnippet" 
			   "~/.emacs.d/plugins/auto-complete-1.3.1"
			   "~/.emacs.d/plugins/ac-plugins"
			   ) load-path))
;; }}}

;;;;;
;; color theme
;; {{{
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-dark-laptop)))
;; }}}

;;;;;
;; Python IDE Configuration
;; {{{
(require 'python-mode)
(require 'pymacs)
(require 'pycomplete)
;; Initialize Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
;; Python-Mode
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook 
	  (lambda () 
	    (set (make-variable-buffer-local 'beginning-of-defun-function) 
		 'py-beginning-of-def-or-class) 
	    (setq outline-regexp "def\\|class ")))
;; }}}

;;;;;
;; Cedet
;; {{{
(load-file "~/.emacs.d/plugins/cedet/common/cedet.el")
;;(require 'cedet)
(require 'semantic-ia)
(global-ede-mode t)
;; (semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
;; (semantic-load-enable-guady-code-helpers)
;; (semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
;; }}}

;;;;;
;; ECB
;;; {{{
(require 'ecb)
(require 'ecb-autoloads)
(setq stack-trace-on-error t)

;; 窗口间切换
(global-set-key [M-left]  'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up]    'windmove-up)
(global-set-key [M-down]  'windmove-down)
;; show&hide window
(global-set-key [C-f1] 'ecb-hide-ecb-windows)
(global-set-key [C-f2] 'ecb-show-ecb-windows)
;; 使某一ecb窗口最大化
(global-set-key (kbd "C-c 1") 'ecb-maximize-window-directories)
(global-set-key (kbd "C-c 2") 'ecb-maximize-window-sources)
(global-set-key (kbd "C-c 3") 'ecb-maximize-window-methods)
(global-set-key (kbd "C-c 4") 'ecb-maximize-window-history)
;; 恢复原始窗口布局
(global-set-key (kbd "C-c 0") 'ecb-restore-default-window-sizes)
;; }}}

;;;;;
;; Yasnippet
;; {{{
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        "~/.emacs.d/plugins/yasnippet/snippets"    ;; the default collection
        ))
(yas-global-mode 1)
;;(add-hook 'prog-mode-hook
;;	  '(lambda ()
;;	     (yas-minor-mode)))
;;(yas-reload-all)
;; }}}

;;;;;
;; Auto complete
;; {{{
(require 'auto-complete)
(global-auto-complete-mode)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
	     "~/.emacs.d/plugins/auto-complete-1.3.1/dict")
(setq ac-comphist-file (expand-file-name
             "~/.emacs.d/plugins/ac-comphist.dat"))
(require 'auto-complete-yasnippet)
(require 'auto-complete-extension)
(require 'auto-complete+)

(defun auto-complete-settings ()
  "Settings for `auto-complete'."
  ;; After do this, isearch any string, M-: (match-data) always
  ;; return the list whose elements is integer
  (global-auto-complete-mode 1)
 
  ;; 不让回车的时候执行`ac-complete', 因为当你输入完一个
  ;; 单词的时候, 很有可能补全菜单还在, 这时候你要回车的话,
  ;; 必须要干掉补全菜单, 很麻烦, 用M-j来执行`ac-complete'
  (apply-define-key
   ac-complete-mode-map
   `(("<return>"   nil)
     ("RET"        nil)
     ("M-j"        ac-complete)
     ("<C-return>" ac-complete)
     ("M-n"        ac-next)
     ("M-p"        ac-previous)))
 
  (setq ac-dwim t)
  (setq ac-candidate-max ac-candidate-menu-height)
 
  (set-default 'ac-sources
               '(ac-source-semantic
                 ac-source-yasnippet
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-words-in-all-buffer
                 ac-source-imenu
                 ac-source-files-in-current-dir
                 ac-source-filename))
  (setq ac-modes ac+-modes)

(eval-after-load "auto-complete"
  '(auto-complete-settings))
(defun ac-settings-4-lisp ()
  "Auto complete settings for lisp mode."
  (setq ac-omni-completion-sources '(("\\<featurep\s+'" ac+-source-elisp-features)
                                     ("\\<require\s+'"  ac+-source-elisp-features)
                                     ("\\<load\s+\""    ac-source-emacs-lisp-features)
				     (cons "\\'" '(ac-source-semantic))))
  (ac+-apply-source-elisp-faces)
  (setq ac-sources
        '(ac-source-yasnippet
          ac-source-symbols
          ;; ac-source-semantic
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ;; ac-source-imenu
          ac-source-files-in-current-dir
          ac-source-filename)))
 
(defun ac-settings-4-python ()
  (setq ac-omni-completion-sources (list (cons "\\." '(ac-source-semantic))))
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-java ()
  (setq ac-omni-completion-sources (list (cons "\\." '(ac-source-semantic))
                                         (cons "->" '(ac-source-semantic))))
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-text ()
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-imenu)))

(defun ac-settings-4-html ()
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(am-add-hooks
 `(lisp-mode-hook emacs-lisp-mode-hook lisp-interaction-mode-hook
                  svn-log-edit-mode-hook change-log-mode-hook)
 'ac-settings-4-lisp)
 
(apply-args-list-to-fun
 (lambda (hook fun)
   (am-add-hooks hook fun))
 `(('python-mode-hook 'ac-settings-4-python)
   ('java-mode-hook   'ac-settings-4-java)
;;   ('c-mode-hook      'ac-settings-4-c)
;;   ('c++-mode-hook    'ac-settings-4-cpp)
   ('text-mode-hook   'ac-settings-4-text)
;;   ('eshell-mode-hook 'ac-settings-4-eshell)
;;   ('ruby-mode-hook   'ac-settings-4-ruby)
   ('html-mode-hook   'ac-settings-4-html)))
;;   ('awk-mode-hook    'ac-settings-4-awk)
;;   ('tcl-mode-hook    'ac-settings-4-tcl)))

(eal-eval-by-modes
 ac-modes
 (lambda (mode)
   (let ((mode-name (symbol-name mode)))
     (when (and (intern-soft mode-name) (intern-soft (concat mode-name "-map")))
       (define-key (symbol-value (am-intern mode-name "-map")) (kbd "C-c a") 'ac-start)))))
)
 
(provide 'auto-complete-settings)
;; }}}

