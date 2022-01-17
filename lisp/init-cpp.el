;;; init-cpp.el -- Config for c/cpp mode.

;;; Commentary:
;; See individual section.

;;; Code:

;; Add cuda file to c++ mode.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      ;; Emacs will evaluate things like \t when it converts string literal, so
      ;; if we want to build regex with \, we need to double escape.
      (append '(("\\.cu\\'" . c++-mode))
              auto-mode-alist))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; irony -- for the comple completion.
;; Given that irony-mode is not confined only with c++, its main configuration
;; is factored out to its own repository.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'company-c-headers)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-c-headers))

;; Setup keymapping for company-c-headers.
(add-hook 'irony-mode-hook (lambda ()
                             (local-set-key (kbd "C-c C-h") 'company-c-headers)
                             ))

;; Autocomplete for c headers.
;; Do not use autocomplete for c++ anymore. So it is commented.
;; (require 'init-auto-complete-c-headers)

;; configuration file.  For overall syntax checking, this repo uses flycheck.
;; However, since the package flymake-google-cpplint uses flymake, So flymake
;; is also included here.  Note that syntax checker does conflict with each
;; other.

(require-package 'flymake-cursor)
(require-package 'google-c-style)


;; ;; flymake is advised against, and flycheck-google-cpplint is
;; ;; suggested; thus the following configuration is commented out.
;; (require-package 'flymake-google-cpplint)

;; ;; make c++ code comply to google c++ coding style.  This package plays a role
;; ;; as the glue between the cpplint.py, which is a python program to check the
;; ;; code conforming to the code guide written by google, and Emacs.  It calls
;; ;; cpplint.py and display the result in Emacs.
;; (defun shawn:flymake-google-init ()
;;   (require 'flymake-google-cpplint)
;;   (custom-set-variables
;;    '(flymake-google-cpplint-command "/usr/bin/cpplint")
;;   )
;;   (flymake-google-cpplint-load)
;;   )

;; (add-hook 'c-mode-hook 'shawn:flymake-google-init)
;; (add-hook 'c++-mode-hook 'shawn:flymake-google-init)

;; The author of flymake-google-cpplint says that flymake-google-cpplint does
;; not support c source files.  However, after some simple check, I found
;; flymake-google-cpplint works for c-mode as well.  But anyway, we install
;; google-c-style to deal with the c source files.  The following lines
;; activate the mode.
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Comment related.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doxymacs to insert doxygen comment.
(add-hook 'c-mode-common-hook
  (lambda ()
    (require 'doxymacs)
    (doxymacs-mode t)
    (doxymacs-font-lock)
    ;; C++ style is ugly. Do not use it.
    ;; (if (eq major-mode 'java-mode)
    ;;     (setq doxymacs-doxygen-style "JavaDoc")
    ;;   (setq doxymacs-doxygen-style "C++")
    ;; )
    )
  )
;; Change default comment symbol to "// ".
(add-hook 'c-common-mode-hook
  (lambda ()
    ;; Preferred comment style
    (setq comment-start "// "
          comment-end ""
    )
  )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Documentation lookup.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(evil-leader/set-key "K" 'helm-man-woman)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Debugging.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable many windows gdb.
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 ;; If non-nil change the face of out of scope variables and changed values.
 ;; Out of scope variables are suppressed with `shadow' face.  Changed values
 ;; are highlighted with the face `font-lock-warning-face'.
 gdb-show-changed-values t
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; General config.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c-mode-common-hook (lambda ()
                                (comment-auto-fill)
                                (flyspell-prog-mode)
                                (setq evil-shift-width 2)
                                       ))
;; Config for smartparens.
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET")))
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'init-cpp)
