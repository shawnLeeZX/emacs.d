;;; Package -- summary
;; Config for appearance of EMACS.

;;; Commentary:

; don't show the startup screen
(setq inhibit-startup-screen 1)
; don't show the menu bar
(menu-bar-mode 0)
; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode 0)
; don't show the scroll bar
(if window-system (scroll-bar-mode 0))

;; Visualize trailing whitespace, empty lines at the beginning and the end of
;; the file and tabs.
(global-whitespace-mode 1)
(setq whitespace-style '(face trailing tabs tab-mark empty))

;; Display line number on the margin.
(global-linum-mode)
(setq linum-format "%4d \u2502")

;; Display a visual indicator for fill column width.
(require 'fill-column-indicator)
(define-global-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

; Don't blink the cursor.
(blink-cursor-mode 0)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode 1)

;; Only do automatically vertical split.
(setq split-height-threshold nil)
(setq split-width-threshold 90)

;; Highligh TODO etc.
(require-package 'fic-mode)
(require 'fic-mode)
(add-hook 'prog-mode-hook 'fic-mode)

;; Make newly create frames inherit current transparency value.
(add-to-list 'frame-inherited-parameters 'alpha)

(require 'init-powerline)

(provide 'init-appearance)
