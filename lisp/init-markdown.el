(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\|txt\\|text\\)\\'" . markdown-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; TODO: Fix tab for autocompletion.
(add-hook 'markdown-mode-hook 'sanityinc/never-indent)

(provide 'init-markdown)
