(require-package 'header2)
(require 'header2)

;; Auto update header when saving.
(add-hook 'write-file-hooks 'auto-update-file-header)

;; Refine related functions.
(defsubst header-contact ()
  "Insert current my email address."
  (insert header-prefix-string "Contact: lishuai918@gmail.com\n"))

(defsubst header-author (author)
  "Insert the author name given in the argument"
  (insert header-prefix-string "Author: " author "\n"))

;; TODO(Shuai) fix the empty line comment.
;; Redefine header content here.
(setq make-header-hook '(
                         ;;header-mode-line
                         header-title
                         header-blank
                         header-file-name
                         header-description
                         ;;header-status
                         (lambda ()
                           (header-author "Shuai")
                           )
                         header-contact
                         header-maintainer
                         header-copyright
                         header-creation-date
                         ;;header-rcs-id
                         header-version
                         header-pkg-requires
                         ;;header-sccs
                         header-modification-date
                         header-modification-author
                         header-update-count
                         header-url
                         header-doc-url
                         header-keywords
                         header-compatibility
                         header-blank
                         header-lib-requires
                         header-end-line
                         header-commentary
                         header-blank
                         header-blank
                         header-blank
                         header-end-line
                         header-code
                         header-eof
                         )
      )

(provide 'init-auto-header)
