;;; +lsp-bridge.el -*- lexical-binding: t; -*-

(use-package! corfu
  :load-path "~/.emacs.d/.local/straight/repos/corfu/extensions"
  ;; Optional customizations
  :bind
  (("M-h" . corfu-complete)
   ("M-," . corfu-first)
   ("M-." . corfu-last))
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator 'separator)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  ;; Enable Corfu only for certain modes.
  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode)
         (rustic-mode . corfu-mode))
  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (require 'corfu-info)
  (require 'corfu-history)
  :config
  ;; (global-corfu-mode)
  (corfu-history-mode t))

(use-package! cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  ;; :bind (("C-c p p" . completion-at-point) ;; capf
  ;;        ("C-c p t" . complete-tag)        ;; etags
  ;;        ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ("C-c p k" . cape-keyword)
  ;;        ("C-c p s" . cape-symbol)
  ;;        ("C-c p a" . cape-abbrev)
  ;;        ("C-c p i" . cape-ispell)
  ;;        ("C-c p l" . cape-line)
  ;;        ("C-c p w" . cape-dict)
  ;;        ("C-c p \\" . cape-tex)
  ;;        ("C-c p _" . cape-tex)
  ;;        ("C-c p ^" . cape-tex)
  ;;        ("C-c p &" . cape-sgml)
  ;;        ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package! tabnine-capf
  :after cape
  ;; :straight (:host github :repo "50ways2sayhard/tabnine-capf" :files ("*.el" "*.sh"))
  :hook (kill-emacs . tabnine-capf-kill-process)
  :config
  (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point))

(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package! lsp-bridge
  :load-path "~/.emacs.d/.local/straight/repos/lsp-bridge"
  :init
  (require 'lsp-bridge-orderless)   ;; make lsp-bridge support fuzzy match, optional
  (require 'lsp-bridge-icon)        ;; show icon for completion items, optional
  :config
  (setq lsp-bridge-completion-provider 'corfu)
  (global-lsp-bridge-mode))

;;   ;; For Xref support
;;   (add-hook 'lsp-bridge-mode-hook
;;             (lambda ()
;;               (add-hook 'xref-backend-functions #'lsp-bridge-xref-backend nil t)))
;;   ;; (setq lsp-bridge-enable-log t)
;;   (dolist (hook (list
;;                  'emacs-lisp-mode-hook
;;                  ))
;;     (add-hook hook (lambda ()
;;                      (setq-local corfu-auto t)          ; Elisp文件自动弹出补全
;;                      )))
;;   (dolist (hook lsp-bridge-default-mode-hooks)
;;     (add-hook hook (lambda ()
;;                      (setq-local corfu-auto nil)        ; 编程文件关闭 Corfu 自动补全， 由 lsp-bridge 来手动触发补全
;;                      (lsp-bridge-mode t)
;;                      (lsp-bridge-mix-multi-backends)    ; 通过 Cape 融合多个补全后端
;;                      ))))
;;
;; ;; 通过Cape融合不同的补全后端，比如lsp-bridge、 tabnine、 file、 dabbrev.
;; (defun lsp-bridge-mix-multi-backends ()
;;   (setq-local completion-category-defaults nil)
;;   (setq-local completion-at-point-functions
;;               (list
;;                (cape-capf-buster
;;                 (cape-super-capf
;;                  #'lsp-bridge-capf
;;                  ;; #'tabnine-completion-at-point
;;                  #'cape-file
;;                  #'cape-dabbrev
;;                  )
;;                 'equal)
;;                )))
;;
;; ;; 融合 `lsp-bridge' `find-function' 以及 `dumb-jump' 的智能跳转
;; (defun lsp-bridge-jump ()
;;   (interactive)
;;   (cond
;;    ((eq major-mode 'emacs-lisp-mode)
;;     (let ((symb (function-called-at-point)))
;;       (when symb
;;         (find-function symb)))
;;     (lsp-bridge-mode
;;      (lsp-bridge-find-def))
;;     (t
;;      (require 'dumb-jump)
;;      (dumb-jump-go)))))
;;
;; (defun lsp-bridge-jump-back ()
;;   (interactive)
;;   (cond
;;    (lsp-bridge-mode
;;     (lsp-bridge-return-from-def))
;;    (t
;;     (require 'dumb-jump)
;;     (dumb-jump-back))))
