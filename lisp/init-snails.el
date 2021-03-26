;;; snails --- Summary
;;; Commentary:
;;; Code:
(use-package snails
  :straight (snails :type git
                    :host github
                    :repo "manateelazycat/snails")
  :init
  (snails '(snails-backend-buffer)))

(provide 'init-snails)
;;; init-snails.el ends here
