;;; init-elpa --- Summary
;;; Commentary:

;;; Code:
(require 'package)

;;; Standard package repositories
;; windows & dos will not use ssl
(defconst pufferfish/no-ssl (and (memq system-type '(windows-nt ms-dos))
                                (not (gnutls-available-p))))

;;; Also use Melpa for most packages
(add-to-list 'package-archives
             `("melpa" . ,(if pufferfish/no-ssl
                              "http://melpa.org/packages/"
                              "https://melpa.org/packages/")))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives
             `("org" . ,(if pufferfish/no-ssl
                            "http://orgmode.org/elpa/"
                          "https://orgmode.org/elpa/")))

;;; straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; initiate use-package
(straight-use-package 'use-package)
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

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
