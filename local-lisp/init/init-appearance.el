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
(if (version< emacs-version "29")
    (global-linum-mode)
  (global-display-line-numbers-mode 1)
  )
(setq linum-format "%4d \u2502")

; Don't blink the cursor.
(blink-cursor-mode 0)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode 1)

;; Only do automatically vertical split.
;; (setq split-height-threshold nil)
(setq split-width-threshold nil)

;; Highligh TODO etc.
(require-package 'fic-mode)
(require 'fic-mode)
(add-hook 'prog-mode-hook 'fic-mode)

;; Make newly create frames inherit current transparency value.
(add-to-list 'frame-inherited-parameters 'alpha)


(when (eq system-type 'gnu/linux)
  ;; Set default font
  (add-hook 'after-init-hook
            (lambda ()
              (set-frame-font "-1ASC-Liberation Mono-regular-normal-normal-*-27-*-*-*-m-0-iso10646-1" nil t)))
  )


(require 'init-powerline)

(require-package 'ansi-color)
(require 'ansi-color)

(defun my/apply-ansi-color ()
  (ansi-color-apply-on-region (point-min) (point-max)))

(add-hook 'compilation-filter-hook 'my/apply-ansi-color)

(provide 'init-appearance)
