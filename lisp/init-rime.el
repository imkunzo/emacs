(use-package rime
  :straight (rime :type git
                  :host github
                  :repo "DogLooksGood/emacs-rime"
                  :files ("*.el" "Makefile" "lib.c"))
  :bind
  (("S-RET" . 'toggle-input-method)
   :map rime-mode-map
        (("C-`" . 'rime-send-keybinding)
        ("S-SPC" . 'rime-force-enable))
   :map rime-active-mode-map
        ("S-SPC" . 'rime-inline-ascii))
  :init
  (setq rime-show-candidate 'posframe
        rime-posframe-style 'vertical
        rime-disable-predicates ;; 临时英文输入模式断言
        '(rime-predicate-evil-mode-p ;; 在 evil-mode 的非编辑状态下
          rime-predicate-after-alphabet-char-p ;; 在英文字符串之后（必须为以字母开头的英文字符串）
          rime-predicate-prog-in-code-p ;; 在 prog-mode 和 conf-mode 中除了注释和引号内字符串之外的区域
          rime-predicate-punctuation-after-ascii-p ;; 当要在任意英文字符之后输入符号时
          rime-predicate-punctuation-after-space-cc-p ;; 当要在中文字符且有空格之后输入符号时
          rime-predicate-punctuation-line-begin-p ;; 在行首要输入符号时
          ;; rime-predicate-space-after-ascii-p ;; 在任意英文字符且有空格之后
          rime-predicate-current-uppercase-letter-p ;; 将要输入的为大写字母时
          )
        rime-inline-predicates
        '(rime-predicate-punctuation-after-space-cc-p
          rime-predicate-space-after-cc-p)
        ;; support shift-l, shift-r, control-l, control-r
        ;; rime-inline-ascii-trigger 'shift-l
        mode-line-mule-info '((:eval (rime-lighter))))
  :custom
  (rime-librime-root "~/.emacs.d/librime/dist")
  (rime-emacs-module-header-root
   (concat (getenv "HOME") "/opt/gccemacs/Emacs.app/Contents/Resources/include"))
  (default-input-method "rime"))

(provide 'init-rime)
