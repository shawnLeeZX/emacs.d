;;; Init related evil extensions.

(require 'evil-nerd-commenter)
(require 'evil-visualstar)

;; Begin evil mode.
(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode)

(provide 'init-evil)
