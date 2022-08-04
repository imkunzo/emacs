;;; +osx.el -*- lexical-binding: t; -*-

(defvar osx-use-option-as-meta t
  "If non nil the option key is mapped to meta. Set to `nil` if you need the
  option key to type common characters.")

;; (setenv "LC_CTYPE" "UTF-8")
;; (setenv "LC_ALL" "en_US.UTF-8")
;; (setenv "LANG" "en_US.UTF-8")

(setq shell-file-name "/bin/zsh"
      temporary-file-directory "/tmp/")

(use-package! exec-path-from-shell
  :init
  (setenv "SHELL" "/bin/zsh")
  (exec-path-from-shell-initialize)
  ;; (exec-path-from-shell-copy-envs '("PATH" "PYTHONPATH"))
)

(when (display-graphic-p)
  ;;Treat command as super
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'super)

  (when osx-use-option-as-meta
    ;; Treat option as meta
    (setq mac-option-key-is-meta t))
  (setq mac-option-modifier (if osx-use-option-as-meta 'meta nil))

  ;; Keybindings
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-c") 'kill-ring-save)
  ;; (global-set-key (kbd "s-c") 'evil-yank)
  )

;; Use the OS X Emoji font for Emoticons
(when (fboundp 'set-fontset-font)
  (set-fontset-font "fontset-default"
                    '(#x1F600 . #x1F64F)
                    (font-spec :name "Apple Color Emoji") nil 'prepend))

;; Overview
;; --------
;; Inserts an image from the clipboard by prompting the user for a filename.
;; Default extension for the pasted filename is .png

;; A ./images directory will be created relative to the current Org-mode document to store the images.

;; The default name format of the pasted image is:
;; filename: <yyyymmdd>_<hhmmss>_-_<image-filename>.png

;; Important
;; --------
;; This function depends on 'pngpaste' to paste the clipboard image
;; -> $ brew install pngpaste

;; Basic Customization
;; -------------------
;; Include the current Org-mode header as part of the image name.
;; (setq my/insert-clipboard-image-use-headername t)
;; filename: <yyyymmdd>_<hhmmss>_-_<headername>_-_<image-filename>.png

;; Include the buffername as part of the image name.
;; (setq my/insert-clipboard-image-use-buffername t)
;; filename: <yyyymmdd>_<hhmmss>_-_<buffername>_-_<image-filename>.png

;; Full name format
;; filename: <yyyymmdd>_<hhmmss>_-_<buffername>_-_<headername>_-_<image-filename>.png
(defun my/insert-clipboard-image (filename)
  "Inserts an image from the clipboard"
  (interactive "sFilename to paste: ")
  (let ((file
         (concat
          (file-name-directory buffer-file-name)
          "_imgs/"
          (format-time-string "%Y%m%d_%H%M%S_-_")
          (if (bound-and-true-p my/insert-clipboard-image-use-buffername)
              (concat (s-replace "-" "_"
                                 (downcase (file-name-sans-extension (buffer-name)))) "_-_")
            "")
          (if (bound-and-true-p my/insert-clipboard-image-use-headername)
              (concat (s-replace " " "_" (downcase (nth 4 (org-heading-components)))) "_-_")
            "")
          filename ".png")))

    ;; create images directory
    (unless (file-exists-p (file-name-directory file))
      (make-directory (file-name-directory file)))

    ;; paste file from clipboard
    (shell-command (concat "pngpaste " file))
    (insert (concat "[[./_imgs/" (file-name-nondirectory file) "]]"))))

(map! :desc "Insert clipboard image"
      :n "C-M-y" 'my/insert-clipboard-image)
