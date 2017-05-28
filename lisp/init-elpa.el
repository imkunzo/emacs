;;; init-elpa --- Summary
;;; Commentary:

;;; Code:
(defun pufferfish/set-tabulated-list-column-width (col-name width)
  "Set any column with name COL-NAME to the given WIDTH."
  (when (> width (length col-name))
    (cl-loop for column across tabulated-list-format
             when (string= col-name (car column))
             do (setf (elt column 1) width))))

(defun pufferfish/maybe-widen-package-menu-columns ()
  "Widen some columns of the package menu table to avoid truncation."
  (when (boundp 'tabulated-list-format)
    (pufferfish/set-tabulated-list-column-width "Version" 13)
    (let ((longest-archive-name (apply 'max (mapcar 'length (mapcar 'car package-archives)))))
      (pufferfish/set-tabulated-list-column-width "Archive" longest-archive-name))))

(require 'package)

;;; Standard package repositories

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;; windows & dos will not use ssl
(defconst pufferfish/no-ssl (and (memq system-type '(windows-nt ms-dos))
                                (not (gnutls-available-p))))

;;; Also use Melpa for most packages
(add-to-list 'package-archives
             `("melpa" . ,(if pufferfish/no-ssl
                              "http://melpa.org/packages/"
                            "https://melpa.org/packages/")))

;;; initiate use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; initialize package
(setq package-enable-at-startup nil)
(package-initialize)

(use-package fullframe
  :ensure t
  :config
  (fullframe list-packages quit-window))

(use-package cl-lib
  :ensure t)

(add-hook 'package-menu-mode-hook 'pufferfish/maybe-widen-package-menu-columns)


(provide 'init-elpa)
;;; init-elpa ends here
