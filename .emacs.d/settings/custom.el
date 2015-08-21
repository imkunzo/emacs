(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
    (rainbow-delimiters pylint py-autopep8 projectile paredit monokai-theme flymake-python-pyflakes elpy company-anaconda color-identifiers-mode clojure-mode-extra-font-locking cider)))
 '(setq tab-stop-list t)
 '(transient-mark-mode t)
 '(vcl-indent-level 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq default-buffer-file-coding-system 'utf-8) ; 设置默认字符编码
(prefer-coding-system 'utf-8)
(setq indent-tabs-mode nil) ; always use spaces, not tabs, when indenting

(when (not (eq window-system nil))
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; (global-set-key [C-tab] 'other-window)

;; ;; linum mode
;; (defun linum-format-func (line)
;;   (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
;;     (propertize (format (format "%%%dd " w) line) 'face 'linum)))
;; (setq linum-format 'linum-format-func)
(global-linum-mode t)

;; indent mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; 设置英文字体
(set-face-attribute
 'default nil :font "Monaco 10")
;; 设置方块字字体

(if (or (eq system-type 'windows-nt) (eq system-type 'cygwin))
    (progn (dolist (charset '(kana han symbol cjk-misc bopomofo))
             (set-fontset-font (frame-parameter nil 'font)
                               charset
                               (font-spec :family "Microsoft YaHei" :size 16)))))

;;;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  (iimage-mode))

;; ido-mode
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-enable-last-directory-history nil)

;;;; monokai theme
;; (load-theme 'monokai t)

;;;; zenburn theme
(load-theme 'zenburn t)

;;;; solarized theme
;; (load-theme 'solarized-dark t)
