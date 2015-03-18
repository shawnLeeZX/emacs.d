(require-package 'header2)
(require 'header2)

;; Auto update header when saving.
(add-hook 'write-file-hooks 'auto-update-file-header)

;; Refine related functions.
(defsubst header-contact ()
  "Insert current my email address."
  (insert header-prefix-string "Contact: lishuai918@gmail.com\n"))

;; Override the default copyright.
(defsubst header-copyright ()
  "Insert a one line copyright statement"
  (insert header-prefix-string
          (concat "Copyright " (substring (current-time-string) -4) "\n")
          )
  )

;; The original section-comment-start will leave a blank line at the section
;; beginning, which breaks the comment continuity that may be important when
;; the header of file is actually extracted into documentation, like python, so
;; I change it to insert comment-start at the empty line.
;;
;; However, the change to inline function seems does not work. So I only list
;; the change here for reference.
;;
;; NOTE: change is actually made in the original header2.el!!
(defsubst section-comment-start ()
  "Comment start of major section headings."
  (if (= (length comment-start) 1)      ; e.g. Lisp: ";; \n;;;"
      (concat header-prefix-string "\n" comment-start header-prefix-string)
    (concat header-prefix-string "\n" comment-start)))       ; e.g. C: "\n/*"

;; Redefine header content here.
(setq make-header-hook '(
                         ;;header-mode-line
                         header-copyright
                         header-blank
                         header-file-name
                         ;; header-description
                         ;;header-status
                         header-author
                         header-contact
                         ;; header-maintainer
                         header-creation-date
                         ;;header-rcs-id
                         ;; header-version
                         header-pkg-requires
                         ;;header-sccs
                         header-modification-date
                         header-modification-author
                         header-update-count
                         ;; header-url
                         ;; header-doc-url
                         ;; header-keywords
                         ;; header-compatibility
                         header-blank
                         header-lib-requires
                         ;; header-end-line
                         header-commentary
                         header-blank
                         header-blank
                         header-blank
                         ;; header-end-line
                         header-code
                         header-eof
                         )
      )
;; (setq make-header-hook '(
;;                          header-commentary
;;                          )
;;       )

(provide 'init-auto-header)
