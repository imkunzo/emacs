;;; init-awesome-tab --- Summary
;;; Commentary:

;;; Code:
(use-package awesome-tab
  :straight (awesome-tab :type git
                         :host github
                         :repo "manateelazycat/awesome-tab")
  :init
  (setq awesome-tab-height 140
        awesome-tab-icon-height 0.9
        awesome-tab-style 'box)
  :config
  (awesome-tab-mode t)

  ;; winum users can use `winum-select-window-by-number' directly.
  (defun my-select-window-by-number (win-id)
    "Use `ace-window' to select the window by using window index.
  WIN-ID : Window index."
    (let ((wnd (nth (- win-id 1) (aw-window-list))))
      (if wnd
          (aw-switch-to-window wnd)
        (message "No such window."))))

  (defun my-select-window ()
    (interactive)
    (let* ((event last-input-event)
           (key (make-vector 1 event))
           (key-desc (key-description key)))
      (my-select-window-by-number
       (string-to-number (car (nreverse (split-string key-desc "-")))))))
  
  (with-eval-after-load 'hydra
    (defhydra hydra/awesome-fast-switch (:hint nil :exit t)
	"
	 ^^^^Fast Move             ^^^^Tab                    ^^Search            ^^Misc
	-^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
	   ^_k_^   prev group    | _C-a_^^     select first | _b_ search buffer | _C-k_   kill buffer
	 _h_   _l_  switch tab   | _C-e_^^     select last  | _g_ search group  | _C-S-k_ kill others in group
	   ^_j_^   next group    | _C-j_^^     ace jump     | ^^                | ^^
	 ^^0 ~ 9^^ select window | _C-h_/_C-l_ move current | ^^                | ^^
	-^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
	"
	  ("h" awesome-tab-backward-tab)
	  ("j" awesome-tab-forward-group)
	  ("k" awesome-tab-backward-group)
	  ("l" awesome-tab-forward-tab)
	  ("0" my-select-window)
	  ("1" my-select-window)
	  ("2" my-select-window)
	  ("3" my-select-window)
	  ("4" my-select-window)
	  ("5" my-select-window)
	  ("6" my-select-window)
	  ("7" my-select-window)
	  ("8" my-select-window)
	  ("9" my-select-window)
	  ("C-a" awesome-tab-select-beg-tab)
	  ("C-e" awesome-tab-select-end-tab)
	  ("C-j" awesome-tab-ace-jump)
	  ("C-h" awesome-tab-move-current-tab-to-left)
	  ("C-l" awesome-tab-move-current-tab-to-right)
	  ("b" ivy-switch-buffer)
	  ("g" awesome-tab-counsel-switch-group)
	  ("C-k" kill-current-buffer)
	  ("C-S-k" awesome-tab-kill-other-buffers-in-current-group)
	  ("q" nil "quit"))))

(provide 'init-awesome-tab)
;;; init-awesome-tab ends here
