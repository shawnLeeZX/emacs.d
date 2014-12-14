(require-package 'auctex)

;;; Auctex configuration for editing
;;; ==================================================================
;; If you want to make AUCTEX aware of style files and multi-file
;; documents right away, insert the following in your ‘.emacs’ file.
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-engine 'xetex) ; Use xelatex as default.
(setq TeX-show-compilation t) ; Show compilation information aside.
(setq TeX-save-query nil) ; Save file by default when compiling.

;; Enable math-mode at startup.
;; Use ` to insert Math Symbol.
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; Enable auto-complete for octave.
(add-to-list 'ac-modes 'LaTeX-mode)
;; Enable spell checking.
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; Customize outline minor mode.
(setq outline-minor-mode-prefix (kbd "C-c C-o"))

;; Some function will not be available before LaTeX-mode is fully
;; loaded or is overrided. Add them in the after load hook.
(add-hook 'LaTeX-mode-hook (lambda ()
                            ; Output pdf by default.
                            (TeX-global-PDF-mode t)
                            ; Something may close autocomplete mode,
                            ; enable it;
                            (auto-complete-mode 1)
                            ; Turn on outline minor mode.
                            (outline-minor-mode 1)
                            )
          )


;;; Auctex configuration for reference
;;; ==================================================================
;; If you want to make AUCTEX aware of style files and multi-file
;; a comprehensive solution for managing cross references,
;; bibliographies, indices, document navigation and a few other
;; things: RefTex.
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;;; preview funtionality: preview-latex
;;; ================================================================
;; No configuration is needed. Refer to manual for usage.

;; Display Math symbol in Unicode directly.
(require-package 'latex-pretty-symbols)
(require 'latex-pretty-symbols)


(provide 'init-latex)
