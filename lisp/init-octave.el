
;; This line tells how to modify alist. Save it for reference.
;; Clear other filetype mapping of .m files.
;; (setq auto-mode-alist (assq-delete-all "\\.m\\'" auto-mode-alist))

;; (add-auto-mode 'octave-mode "\\.m$")
(setq auto-mode-alist (cons '("\\.m\\'" . octave-mode) auto-mode-alist))

;; General Config.
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1)
            )
          )
)

;; To make octave compatible with MatLab, change the comment style of
;; nerd commentor.

;;; Usage.
;; Tip 2, change comment style

;; For example, use double slashes (//) instead of slash-stars (* … *)
;; in c-mode.

;; Insert below code into your ~/.emacs:

;; (add-hook 'c-mode-common-hook
;;   (lambda ()
;;     ;; Preferred comment style
;;     (setq comment-start "// "
;;           comment-end "")))

(add-hook 'octave-mode-hook
  (lambda ()
    ;; Preferred comment style
    (setq comment-start "%%"
          comment-end ""
    )
  )
)

(provide 'init-octave)
