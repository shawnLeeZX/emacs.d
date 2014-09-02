;; Display indentation.
(require-package 'highlight-indentation)
(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-hook 'coffee-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-hook 'c-mode-common-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-hook 'web-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(provide 'init-highlight-indentation)
