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

(provide 'init-markdown)
