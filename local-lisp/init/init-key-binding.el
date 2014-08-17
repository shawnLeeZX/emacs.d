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

(provide 'init-key-binding)
