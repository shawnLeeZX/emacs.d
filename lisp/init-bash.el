(add-hook 'sh-mode-hook 'comment-auto-fill)
(add-hook 'sh-mode-hook 'flyspell-prog-mode)

;; Add bash header at the beginning.
(add-hook 'sh-mode-hook (lambda ()
    (add-to-list 'make-header-hook 'header-shell)
                          ))

(provide 'init-bash)
