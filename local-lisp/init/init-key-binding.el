;;; Keybindings.

;; Select all content in the buffer.
(defun select-all ()
  (interactive)
  (evil-goto-first-line)
  (evil-visual-line)
  (evil-goto-line)
)

(evil-leader/set-key
  "C-a" 'select-all
)

;; window modifications
;; Do not work
;; (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "S-C-<up>") 'shrink-window)
;; (global-set-key (kbd "S-C-<down>") 'enlarge-window)


(provide 'init-key-binding)
