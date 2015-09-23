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
                         header-copyright
                         header-blank
                         header-file-name
                         header-author
                         header-contact
                         header-creation-date
                         header-pkg-requires
                         header-blank
                         header-lib-requires
                         header-commentary
                         header-code
                         header-eof
                         )
      )

;; This is a modified version of make-divider in the auto-header package. Since
;; if the comment-start is one character, it is common, as I have done, to add
;; one extra space after the character. In this case, original function uses
;; the second character to padding the dividor, which has no effect if it is
;; space. This I change it to use the first symbol of comment-start all the
;; time.
(defun make-divider (&optional end-col)
  "Insert a comment divider line: the comment start, filler, and end.
END-COL is the last column of the divider line."
  (interactive)
  (insert comment-start)
  (when (= 1 (length comment-start)) (insert comment-start))
  (insert (make-string (max 2 (- (or end-col (- fill-column 2))
                                 (length comment-end) 2 (current-column)))
                       (aref comment-start 0)))
  (insert (concat comment-end "\n")))

;; Since each mode would have its own header, such variable should be local.
(make-variable-buffer-local 'make-header-hook)

(provide 'init-auto-header)
