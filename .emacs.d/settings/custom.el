(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-message t)
 '(make-backup-files nil)

 '(column-number-mode t)
 '(global-linum-mode t)
 '(transient-mark-mode t) ; 反显选中区域
 )

;; 设置英文字体
(set-face-attribute
 'default nil :font "Ubuntu Mono 12")
;; 设置方块字字体

(if (eq system-type 'windows-nt)
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

;;;; monokai theme
;; (load-theme 'flatland t)
(load-theme 'monokai t)
