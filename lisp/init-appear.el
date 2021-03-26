;;; init-appear --- Summary
;;; Commentary:
;;; Code:

;; transparent
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; default encoding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;; TAB indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; highlight current line
(global-hl-line-mode)
;;; set default split
(setq split-width-threshold nil)
;;; very long line performence optimizy
;; (when emacs/>=27p
;;   (global-so-long-mode t))

;; (use-package monokai-theme
;;   :ensure t
;;   :init
;;   (load-theme 'monokai t))

;; (use-package zenburn-theme
;;   :ensure t
;;   :init
;;   (load-theme 'zenburn t))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-eighties t))

;; (use-package atom-one-dark-theme
;;   :ensure t
;;   :init
;;   (load-theme 'atom-one-dark t))

;; (use-package srcery-theme
;;   :ensure t
;;   :init
;;   (setq srcery-org-height nil)
;;   :config
;;   (load-theme 'srcery))

;; (use-package solarized-theme
;;   :ensure t
;;   :init
;;   (setq solarized-emphasize-indicators nil)
;;   (setq solarized-scale-org-headlines nil)
;;   (load-theme 'solarized-light t))

;; (use-package color-theme-sanityinc-solarized
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-solarized-light t))

;; (use-package spacemacs-theme
;;   :ensure t
;;   :init
;;   (load-theme 'spacemacs-light t))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :defer t
  :after (projectile all-the-icons)
  :hook
  (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-bar-width 3
        doom-modeline-window-width-limit fill-column
        doom-modeline-major-mode-icon t
        doom-modeline-minor-modes nil
        doom-modeline-icon t
        doom-modeline-indent-info t
        doom-modeline-project-detection 'project
        doom-modeline-lsp t
        doom-modeline-buffer-file-name-style 'file-name))

;; (use-package spaceline-all-the-icons
;;   :ensure t
;;   :init
;;   (spaceline-all-the-icons-theme)
;;   (spaceline-all-the-icons--setup-anzu)            ;; Enable anzu searching
;;   (spaceline-all-the-icons--setup-package-updates) ;; Enable package update indicator
;;   (spaceline-all-the-icons--setup-git-ahead)       ;; Enable # of commits ahead of upstream in git
;;   (spaceline-all-the-icons--setup-paradox)         ;; Enable Paradox mode line
;;   (spaceline-all-the-icons--setup-neotree)         ;; Enable Neotree mode line
;;   (setq spaceline-all-the-icons-separator-type 'arrow))

(use-package posframe
  :ensure t)

;; (use-package maple-minibuffer
;;   :straight (maple-minibuffer :type git
;;                               :host github
;;                               :repo "honmaple/emacs-maple-minibuffer")
;;   :ensure t
;;   :hook (after-init . maple-minibuffer-mode)
;;   :config
;;   (setq maple-minibuffer:position-type 'window-center
;;         maple-minibuffer:border-color "gray50"
;;         maple-minibuffer:height nil
;;         maple-minibuffer:width 0.8
;;         maple-minibuffer:cache t)
;; 
;;   (setq maple-minibuffer:action '(read-from-minibuffer read-string)
;;         maple-minibuffer:ignore-action '(evil-ex eval-expression))
;; 
;;   (add-to-list 'maple-minibuffer:ignore-action 'org-schedule)
;;   (add-to-list 'maple-minibuffer:ignore-regexp "^ivy-")
;; 
;;   ;; more custom parameters for frame
;;   (defun maple-minibuffer:parameters ()
;;     "Maple minibuffer parameters."
;;     `((height . ,(or maple-minibuffer:height 10))
;;       (width . ,(or maple-minibuffer:width (window-pixel-width)))
;;       (left-fringe . 5)
;;       (right-fringe . 5))))

;;; prefer vertical split
(defun split-window-sensibly-prefer-horizontal (&optional window)
"Based on split-window-sensibly, but designed to prefer a horizontal split,
i.e. windows tiled side-by-side."
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
         ;; Split window horizontally
         (with-selected-window window
           (split-window-right)))
    (and (window-splittable-p window)
         ;; Split window vertically
         (with-selected-window window
           (split-window-below)))
    (and
         ;; If WINDOW is the only usable window on its frame (it is
         ;; the only one or, not being the only one, all the other
         ;; ones are dedicated) and is not the minibuffer window, try
         ;; to split it horizontally disregarding the value of
         ;; `split-height-threshold'.
         (let ((frame (window-frame window)))
           (or
            (eq window (frame-root-window frame))
            (catch 'done
              (walk-window-tree (lambda (w)
                                  (unless (or (eq w window)
                                              (window-dedicated-p w))
                                    (throw 'done nil)))
                                frame)
              t)))
     (not (window-minibuffer-p window))
     (let ((split-width-threshold 0))
       (when (window-splittable-p window t)
         (with-selected-window window
           (split-window-right))))))))

(defun split-window-really-sensibly (&optional window)
  (let ((window (or window (selected-window))))
    (if (> (window-total-width window) (* 2 (window-total-height window)))
        (with-selected-window window (split-window-sensibly-prefer-horizontal window))
      (with-selected-window window (split-window-sensibly window)))))

(setq split-height-threshold 4
      split-width-threshold 40
      split-window-preferred-function 'split-window-really-sensibly)

(provide 'init-appear)
;;; init-appear ends here
