(require-package 'ggtags)
(require 'ggtags)

;; Setup ggtags for the languages that uses it.
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; Setup keymappings.
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; The Imenu facility offers a way to find the major definitions, such as
;; function definitions, variable definitions in a file by name. But I am not
;; quite sure how it works. Will see it in the future.
(setq-local imenu-create-index-function 'ggtags-build-imenu-index)
(setq ggtags-auto-jump-to-match nil)

(provide 'init-ggtags)