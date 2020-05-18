;;; init-ivy --- Summary
;;; Commentary:

;;; Code:
;; (defun pufferfish/enable-ivy-flx-matching ()
;;  "Make 'ivy' matching work more like IDO."
;;  (interactive)
;;  (require-package 'flx)
;;  (setq-default ivy-re-builders-alist
;;                '((t . ivy--regex-fuzzy))))

(use-package ivy
  :ensure t
  :bind
  (:map global-map
        ("C-x b" . ivy-switch-buffer))
  (:map ivy-minibuffer-map
        ("C-j" . ivy-immediate-done)
        ("RET" . ivy-alt-done))
  :init
  (setq ivy-use-virtual-buffers t
        ivy-count-format ""
        projectile-completion-system 'ivy)
  (ivy-mode t))

;; (use-package ivy-historian
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook (lambda () (ivy-historian-mode t))))

(use-package counsel
  :ensure t
  :init
  (setq-default counsel-mode-override-describe-bindings t)
  (add-hook 'after-init-hook 'counsel-mode)
  :bind
  (:map global-map
        ("M-y" . counsel-yank-pop))
  :config
  (setq-default ivy-initial-inputs-alist
                '((Men-completion-table . "^")
                  (woman . "^"))))

(use-package swiper
  :ensure t
  :bind
  (:map ivy-mode-map
        ("C-s" . swiper)))

(use-package ivy-rich
  :ensure t
  :after (ivy counsel)
  :preface
  (eval-when-compile
    (defvar ivy-rich-path-style)
    (declare-function ivy-rich-mode nil))
  :init
  (defun ivy-rich-switch-buffer-icon (candidate)
     (with-current-buffer
   	  (get-buffer candidate)
	(let ((icon (all-the-icons-icon-for-mode major-mode)))
	  (if (symbolp icon)
	      (all-the-icons-icon-for-mode 'fundamental-mode)
	    icon))))
  (setq ivy-rich-path-style 'abbrev
        ivy-rich-display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-switch-buffer-icon (:width 2))
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand)))))
  :config
  (ivy-rich-mode t))

(use-package prescient
  :straight t
  :preface
  (eval-when-compile
    (declare-function prescient-persist-mode nil))
  :config
  (prescient-persist-mode t))

(use-package ivy-prescient
  :after (ivy prescient)
  :straight t
  :preface
  (eval-when-compile
    (declare-function ivy-prescient-mode nil))
  :config
  (ivy-prescient-mode t))

;; (use-package all-the-icons-ivy
;;   :ensure
;;   :config
;;   (with-eval-after-load 'ivy
;;     (all-the-icons-ivy-setup)))

(provide 'init-ivy)
;;; init-ivy ends here
