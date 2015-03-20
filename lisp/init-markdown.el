(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\|txt\\|text\\)\\'" . markdown-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; Fix tab for autocompletion.
(add-hook 'markdown-mode-hook 'sanityinc/never-indent)

(add-hook 'flyspell-mode-hook
          (lambda ()
            "Use ispell to corrent the word instead of flyspell's."
            (define-key flyspell-mode-map (kbd "C-M-i") 'ispell-complete-word)
          )
)

;; Enable syntax highlighting for math.
(setq markdown-enable-math t)
;; Make $$ auto pair in markdown-mode.
(sp-local-pair 'markdown-mode "$" "$")

;; Disable whitespace cleanup since trailing whitespace is important
;; for indentation.
(add-hook 'markdown-mode-hook (lambda ()
                                (whitespace-cleanup-mode -1)
                              )
)

(provide 'init-markdown)
