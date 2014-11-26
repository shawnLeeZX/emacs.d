
;; Octave integration before 24.4 won't work. Extension of octave of
;; emacs 24.4 is extracted into /site-lisp. If the version of emacs is
;; not modern enough, use that.
(when (< (string-to-number emacs-version) 24.4)
  (require 'octave)
)


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

;; Enable auto-complete for octave.
(add-to-list 'ac-modes 'octave-mode)

(provide 'init-octave)
