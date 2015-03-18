;;; Package --- summary.
;; General config for EMACS.

;; ignore case when searching
(setq case-fold-search t)

;; require final newlines in files when they are saved
(setq require-final-newline t)

;; The user's information.
(setq user-mail-address "lishuai918@gmail.com")
(defun user-full-name ()
  "Override the default user-full-name to provide the real name. Note that the
name now is hard-coded."

  "Shuai"
  )

(provide 'init-general)
