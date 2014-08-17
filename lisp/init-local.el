;;; init-local
;; Personal configuration for emacs.
;; Author: Shuai Li

;; General.

(require 'init-powerline)
(require 'init-local-util)
(require 'init-key-binding)

;; Display trailing whitespace.
(setq show-trailing-whitespace t)
(setq whitespace-style '(trailing tabs tab-mark))

;; Display line number on the margin.
(linum-mode 1)
(setq linum-format "%4d \u2502")

;; Enable flyspell mode for word checking.
(flyspell-mode 1)
(require 'init-language-tool)

(provide 'init-local)
