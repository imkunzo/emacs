;;; init-gui-font --- Summary
;;; Commentary:

;; ;;; Code:
;; ;; Gui Fonts configuration
;; (defun font-existsp (font)
;;   (if (null (x-list-fonts font)) nil t))
;; ;;
;; (defun make-font-string (font-name font-size)
;;   (if (and (stringp font-size)
;;            (equal ":" (string (elt font-size 0))))
;;       (format "%s%s" font-name font-size)
;;     (format "%s %s" font-name font-size)))
;; ;;
;; (defun set-font (english-fonts
;;                  english-font-size
;;                  chinese-fonts
;;                  &optional chinese-font-size)
;;   "english-font-size could be set to \":pixelsize=18\" or a integer.
;; If set/leave chinese-font-size to nil, it will follow english-font-size"
;;   (require 'cl)
;;   (let ((en-font (make-font-string
;;                   (find-if #'font-existsp english-fonts)
;;                   english-font-size))
;;         (zh-font (font-spec :family (find-if #'font-existsp chinese-fonts)
;;                             :size chinese-font-size)))
;;     ;; Set the default English font
;;     ;; The following 2 method cannot make the font settig work in new frames.
;;     ;; (set-default-font "Consolas:pixelsize=18")
;;     ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
;;     ;; We have to use set-face-attribute
;;     (message "Set English Font to %s" en-font)
;;     (set-face-attribute
;;      'default nil :font en-font)
;;     ;; Set Chinese font
;;     ;; Do not use 'unicode charset, it will cause the english font setting invalid
;;     (message "Set Chinese Font to %s" zh-font)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font (frame-parameter nil 'font) charset
;;       zh-font))))
;; ;; setup default fonts
;; (cond
;;  (*is-linux-p*
;;   (set-font
;;    '("Monaco" "mononoki Nerd Font" "Ubuntu Mono" "DejaVu Sans Mono" "Consolas") 13
;;    '("WenQuanYi Micro Hei Mono" "Microsoft Yahei")))
;;  (*is-mac-p*
;;   (set-font
;;    '("Monaco" "mononoki Nerd Font" "Ubuntu Mono" "DejaVu Sans Mono" "Consolas") 14
;;    '("Noto Sans CJK SC" "WenQuanYi Micro Hei Mono" "Microsoft Yahei") 16)))

(use-package cnfonts
  :ensure t
  :init
  (setq cnfonts--custom-set-fontnames
        '(("Hiragino Sans GB" "Monaco"))
        cnfonts--custom-set-fontsizes
        '((14 14.0 14.0))
        cnfonts-use-face-font-rescale t)
  :config
  (cnfonts-enable))

(provide 'init-gui-fonts)
;;; init-gui-font ends here
