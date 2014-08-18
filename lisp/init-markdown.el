(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\|txt\\|text\\)\\'" . markdown-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'flyspell-mode)

(provide 'init-markdown)
