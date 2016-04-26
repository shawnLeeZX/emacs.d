(require-package 'auctex)

;; Make focus switch automatically after backward search.
;; As for the forward search, did not find a solution yet.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun raise-client-frame ()
  (let ((wmctrl (executable-find "wmctrl")))
    (if wmctrl
    (start-process "wmctrl" nil wmctrl "-R" (frame-parameter nil 'name)))))
;; This raises the frame when using Evince.
(add-hook 'TeX-source-correlate-mode-hook
      (lambda ()
        (when (TeX-evince-dbus-p)
          (dbus-register-signal
           :session nil "/org/gnome/evince/Window/0"
           "org.gnome.evince.Window" "SyncSource"
           (lambda (file linecol &rest ignored)
             (TeX-source-correlate-sync-source file linecol ignored)
             (raise-client-frame)
             )))))
;; This raises the frame when using all other viewers.
(add-hook 'server-switch-hook 'raise-client-frame)

;;; Auctex configuration for editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you want to make AUCTEX aware of style files and multi-file
;; documents right away, insert the following in your ‘.emacs’ file.
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-engine 'xetex) ; Use xelatex as default.
; (setq TeX-show-compilation t) ; Show compilation information aside.
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
                            ;; Output pdf by default.
                            (TeX-global-PDF-mode t)
                            ;; Something may close autocomplete mode,
                            ;; enable it;
                            (auto-complete-mode 1)
                            ;; Turn on outline minor mode.
                            (outline-minor-mode 1)
                            ;; Turn on auto fill.
                            (turn-on-auto-fill)
                            ;; Change preferred comment style of nerdcommenter.
                            (setq comment-start "%% "
                                  comment-end ""
                            )
                            (TeX-source-correlate-mode 1)
                            ;; Automatically compile when saving.
                            (add-hook 'after-save-hook
                                      (lambda ()
                                        (TeX-command-menu "LaTeX")
                                        )
                                      nil 1)
                            )
          )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Auctex configuration for reference
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you want to make AUCTEX aware of style files and multi-file
;; a comprehensive solution for managing cross references,
;; bibliographies, indices, document navigation and a few other
;; things: RefTex.
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; preview funtionality: preview-latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; No configuration is needed. Refer to manual for usage.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Math in LaTeX.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Display Math symbol in Unicode directly.
(require-package 'latex-pretty-symbols)
(require 'latex-pretty-symbols)
;; Symbol completion.
(defun setup-company-math ()
  (setq-local company-backends
              (append '(company-math-symbols-latex company-latex-commands)
                      company-backends)))
(add-hook 'LaTeX-mode-hook 'setup-company-math)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Side by side Latex preview.
;; It conflicts with xltxtra. Do not know why yet.
;; Call `latex-preview-pane-mode` to use it manually when writing latex.
;; Package dropped; use compile on saving written myself.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require-package 'latex-preview-pane)
;; (setq-default pdf-latex-command "xelatex")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; General Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Added builtin support of smartparens to latex.
;; TODO(Shuai) The following suggestion is not realized yet.
;; It is advised that you add `latex-mode' to the list
;; `sp-navigate-consider-stringlike-sexp'.  This will tell
;; smartparens to treat the $$ math blocks as sexps, and enable you
;; to use all the sexp-based commands on them (such as
;; `sp-down-sexp', `sp-up-sexp' etc.)
(require 'smartparens-latex)

;; (sp-local-pair 'LaTeX-mode "$" "$")
;; Sometimes Emacs cannnot set PATH env variable right. Set it
;; manually. Here is how to:
;; (setenv "PATH"
;;         (concat "/usr/local/bin:/usr/texbin:" (getenv "PATH")))

(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq evil-shift-width 2)
                             ))
;; Use LaTeX-mode instead of latex-mode. The latter should be the one from
;; emacs, but maybe due to some bugs, it is referred to the one in octave.el,
;; which is non-sense.
;; But I am still not sure how things work between latex-mode and LaTeX-mode.
(setq auto-mode-alist (cons '("\\.tex\\'" . LaTeX-mode) auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'init-latex)
