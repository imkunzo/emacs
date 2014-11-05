(require 'fill-column-indicator)

(setq fci-rule-column 78)
(setq fci-rule-width 1)
; (setq fci-rule-color "darkgray")
(define-globalized-minor-mode global-fci-mode
  fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

(provide 'fill-column-indicator-settings)
