;;; Package --- summary.
;; General config for EMACS.

;; Miscelleneous
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ignore case when searching
(setq case-fold-search t)

;; require final newlines in files when they are saved
(setq require-final-newline t)

;; Inherit PATH environment variable from user shell.
(add-hook 'after-init-hook 'set-exec-path-from-shell-PATH)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; User information.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-mail-address "lishuai918@gmail.com")
(defun user-full-name ()
  "Override the default user-full-name to provide the real name. Note that the
name now is hard-coded."

  "Shuai"
  )
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General Key Binding
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c -") 'make-divider)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta))


(provide 'init-general)
