;;; +cnfonts.el -*- lexical-binding: t; -*-

(defvar my-line-spacing-alist
      '((9 . 0.1) (10 . 0.9) (11.5 . 0.2)
        (12.5 . 0.2) (14 . 0.2) (16 . 0.2)
        (18 . 0.2) (20 . 1.0) (22 . 0.2)
        (24 . 0.2) (26 . 0.2) (28 . 0.2)
        (30 . 0.2) (32 . 0.2)))

(defun my-line-spacing-setup (fontsizes-list)
  (let ((fontsize (car fontsizes-list))
        (line-spacing-alist (copy-list my-line-spacing-alist)))
    (dolist (list line-spacing-alist)
      (when (= fontsize (car list))
        (setq line-spacing-alist nil)
        (setq-default line-spacing (cdr list))))))

(use-package! cnfonts
  :init
  (setq cnfonts--custom-set-fontnames
        '(("Hiragino Sans GB" "Monaco"))
        cnfonts--custom-set-fontsizes
        '((14 14.0 14.0))
        cnfonts-use-face-font-rescale t)
  (add-hook 'cnfonts-set-font-finish-hook #'my-line-spacing-setup)
  :config
  (cnfonts-enable))
