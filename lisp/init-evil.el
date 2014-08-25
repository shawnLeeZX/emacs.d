;;; Init related evil extensions.
(require-package 'evil)
(require-package 'evil-surround)
(require-package 'evil-leader)
(require-package 'evil-nerd-commenter)
(require-package 'evil-matchit)
(require-package 'evil-visualstar)


;; Make a visual selection with v or V, and then hit * to search that
;; selection forward, or # to search that selection backward.
(require 'evil-visualstar)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

(require 'evil-surround)
(global-evil-surround-mode)

(require 'evil-nerd-commenter)
;; Tip 2, change comment style

;; For example, use double slashes (//) instead of slash-stars (* … *)
;; in c-mode.

;; Insert below code into your ~/.emacs:

;; (add-hook 'c-mode-common-hook
;;   (lambda ()
;;     ;; Preferred comment style
;;     (setq comment-start "// "
;;           comment-end "")))
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)

(require 'evil-leader)
;; You can also bind several keys at once:

;; (evil-leader/set-key
;;   "e" 'find-file
;;   "b" 'switch-to-buffer
;;   "k" 'kill-buffer)
;; The key map can of course be filled in several places.

;; After you set up the key map you can access the bindings by pressing <leader> (default: \) and the key(s). E.g. \ e would call find-file to open a file.

;; If you wish to change so you can customize evil-leader/leader or call evil-leader/set-leader, e.g. (evil-leader/set-leader ",") to change it to “,”. The leader has to be readable by read-kbd-macro, so using Space as a prefix key would be (evil-leader/set-leader "<SPC>").

;; Beginning with version 0.3 evil-leader has support for mode-local bindings:

;; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
;; Again, you can bind several keys at once.

;; A mode-local binding shadows a normal mode-independent binding.
(global-evil-leader-mode)
(evil-leader/set-key
  "c SPC" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "w"  'save-buffer
  )

;; Begin evil mode.
(require 'evil)
(evil-mode 1)


(provide 'init-evil)
