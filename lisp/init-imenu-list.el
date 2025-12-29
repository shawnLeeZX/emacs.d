(require-package 'imenu-list)

(setq imenu-list-position 'left)
(imenu-list-minor-mode)

;; Hide noisy categories
(setq imenu-list-hidden-subtrees '("Variables" "Imports"))

(provide 'init-imenu-list)
