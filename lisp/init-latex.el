(require-package 'auctex)

;; Config for Auctex
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTE: Auctex will override the major modes offered by Emacs, so no config is
;; needed to use the basic functionality of auctex. The following are
;; customization for it.

;;; Auctex configuration for editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you want to make AUCTEX aware of style files and multi-file
;; documents right away, insert the following in your ‘.emacs’ file.
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-engine 'xetex) ; Use xelatex as default.
(setq TeX-engine-alist '((pdftex "pdftex" "pdftex" "pdflatex" "pdftex"))
                        )
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
                            (setq TeX-command-extra-options "-shell-escape")
                            )
          )


;;; Auctex configuration for reference
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you want to make AUCTEX aware of style files and multi-file
;; a comprehensive solution for managing cross references,
;; bibliographies, indices, document navigation and a few other
;; things: RefTex.
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Preview funtionality.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; preview-latex
;; No configuration is needed. Refer to manual for usage.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Math in LaTeX.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Display Math symbol in Unicode directly.
;; Symbol completion.
(require-package 'company-math)
(require 'company-math)
(defun setup-company-math ()
  (setq-local company-backends
              (append '(company-math-symbols-latex company-latex-commands)
                      company-backends)))
(add-hook 'LaTeX-mode-hook 'setup-company-math)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;; General Config
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq evil-shift-width 2)
                             ))

;; Switch focus automatically after backward search.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun raise-client-frame ()
  (let ((wmctrl (executable-find "wmctrl")))
    (if wmctrl
        (start-process "wmctrl" nil wmctrl "-R" (frame-parameter nil 'name)))))
;; This raises the frame when using Evince.
(add-hook 'TeX-source-correlate-mode-hook
      (lambda ()
        (when (TeX-evince-dbus-p "gnome" "evince")
          (dbus-register-signal
           :session nil "/org/gnome/evince/Window/0"
           "org.gnome.evince.Window" "SyncSource"
           (lambda (file linecol &rest ignored)
             (TeX-source-correlate-sync-source file linecol ignored)
             (raise-client-frame)
             )))))
;; This raises the frame when using all other viewers.
(add-hook 'server-switch-hook 'raise-client-frame)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'init-latex)
