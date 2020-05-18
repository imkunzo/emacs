(use-package pyim
  :ensure t
  :demand t
  :bind
  (("S-SPC" . pyim-convert-string-at-point)
   ("C-;" . pyim-delete-word-from-personal-buffer)
   :map pyim-mode-map
   ("." . pyim-page-next-page)
   ("," . pyim-page-previous-page))
  :init
  (setq default-input-method "pyim"
        pyim-default-scheme 'rime-quanpin
        pyim-page-tooltip 'posframe
        pyim-page-length 5)
  :config
  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions '(pyim-probe-dynamic-english
                                                      pyim-probe-isearch-mode
                                                      pyim-probe-program-mode
                                                      pyim-probe-org-structure-template)
                pyim-punctuation-half-width-functions '(pyim-probe-punctuation-line-beginning
                                                        pyim-probe-punctuation-after-punctuation))
  (pyim-isearch-mode t))

(use-package pyim-basedict
  :ensure t
  :init
  (pyim-basedict-enable))

(use-package liberime
  :if sys/macp
  :load-path "~/.emacs.d/pyim/rime"
  :config
  (liberime-start (expand-file-name "/Library/Input Methods/Squirrel.app/Contents/SharedSupport")
                  (expand-file-name "~/.emacs.d/pyim/rime"))
  (liberime-select-schema "luna_pinyin_simp"))

(provide 'init-pyim)
