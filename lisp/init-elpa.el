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
             `("melpa-stable" . ,(if pufferfish/no-ssl
                              "http://stable.melpa.org/packages/"
                              "https://stable.melpa.org/packages/")))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives
             `("org" . ,(if pufferfish/no-ssl
                            "http://orgmode.org/elpa/"
                          "https://orgmode.org/elpa/")))

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
