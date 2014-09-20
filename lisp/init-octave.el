
;; This line tells how to modify alist. Save it for reference.
;; Clear other filetype mapping of .m files.
;; (setq auto-mode-alist (assq-delete-all "\\.m\\'" auto-mode-alist))

;; (add-auto-mode 'octave-mode "\\.m$")
(setq auto-mode-alist (cons '("\\.m\\'" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1)
            )
          )
)

(provide 'init-octave)
