
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
            ;; This line does not behave as expected. The comment will
            ;; not be auto-filled and the code will be. I guess some
            ;; config in the extensions makes it this way. TODO Try
            ;; figure it out in the future.
            (comment-auto-fill)
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
    (setq comment-start "%% "
          comment-end ""
    )
  )
)

;; Enable auto-complete for octave.
(add-to-list 'ac-modes 'octave-mode)
;; Make real autocomplete work with octave.
;; Note that since I use ac-octave from elpa and code of ac-otave is
;; not included in the git repo, you need to change source in
;; elpa/ac-octave to make sure the repo works. More specifically,
;; ac-octave will check your version number and if it is less than
;; 24.4, it will try to include octave-inf.el. Disable the version
;; check and always try to load the new octave.el.
(require-package 'ac-octave)
(require 'ac-octave)
(add-hook 'octave-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-octave)
          )
)

(provide 'init-octave)
