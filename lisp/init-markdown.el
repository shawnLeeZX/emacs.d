(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)

(provide 'init-markdown)
