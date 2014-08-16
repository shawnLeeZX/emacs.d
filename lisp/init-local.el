;;; init-local
;; Personal configuration for emacs.
;; Author: Shuai Li

(require-package 'ecb)
(require-package 'evil)
(require-package 'evil-surround)
(require-package 'evil-leader)
(require-package 'evil-nerd-commenter)
(require-package 'evil-visualstar)

(require 'init-local-util)

(require 'init-evil)
(require 'init-powerline)


(provide 'init-local)
