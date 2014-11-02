;;; Initialize terminal config.

(add-hook 'term-mode-hook
          (lambda ()
            (setq yas-dont-activate t)
          )
)

(provide 'init-term)
