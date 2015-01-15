(require-package 'header2)
(require 'header2)

;; Auto update header when saving.
(add-hook 'write-file-hooks 'auto-update-file-header)

;; Since I am not writing free software yet, remove it from header.
(remove-hook 'make-header-hook 'header-free-software)

;; Funtion to insert my contact. Notice that source code of header2.el should be
;; changed to invoke this function.
(defsubst header-contact ()
  "Insert current my email address."
  (insert header-prefix-string "Contact: lishuai918@gmail.com\n"))

(provide 'init-auto-header)
