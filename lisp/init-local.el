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
(global-linum-mode)
(setq linum-format "%4d \u2502")

;; Enable flyspell mode for word checking.
(require 'init-language-tool)

;; Display a visual indicator for fill column width.
(require 'fill-column-indicator)
(define-global-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

(provide 'init-local)
