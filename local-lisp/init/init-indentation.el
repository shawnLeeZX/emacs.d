;;; Package -- summary
;; Config for indentation of EMACS.

;;; Commentary:

;; always use spaces, not tabs, when indenting
(setq indent-tabs-mode nil)
; number of characters until the fill column
(setq-default fill-column 79)

;; Advanced return for programming.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun advanced-return ()
  "Advanced `newline' command for comment.  This function redefine <Enter> to
provide a corrent comment symbol at each newline plus a space when you press
<Enter> in the comment.  It also support JavaDoc style comment -- insert a `*'
at the beggining of the new line if inside of a comment."
  (interactive "*")
  (let* ((last (point))
         (line-beginning (progn (beginning-of-line) (point)))
         (is-inside-java-doc
          (progn
            (goto-char last)
            (if (search-backward "*/" nil t)
                ;; there are some comment endings - search forward
                (search-forward "/*" last t)
              ;; it's the only comment - search backward
              (goto-char last)
              (search-backward "/*" nil t)
              )
            )
          )
         (is-inside-oneline-comment
          (progn
            (goto-char last)
            (search-backward comment-start line-beginning t)
            )
          )
         )

    ;; go to last char position
    (goto-char last)

    ;; the point is inside one line comment, insert the comment-start.
    (if is-inside-oneline-comment
        (progn
          (newline-and-indent)
          (insert comment-start)
          )
      ;; else we check if it is java-doc style comment.
      (if is-inside-java-doc
          (progn
            (newline-and-indent)
            (insert "* ")
            )
        ;; else insert only new-line
        (newline-and-indent)
        )
      )
      )
  )

;; TODO(Shuai) I have no idea why the hook does not work for lisp-mode, even if
;; advanced-return is added to the lisp-mode-hook directly.  However, I will
;; just settle for the moment since it works fine for almost all the remaining
;; prog modes.  What's more, it does not conflict with the autopair-newline
;; command that is binded to <RET>.  Though I am not sure why, maybe (newline)
;; is rebinded.
(add-hook 'prog-mode-hook
          (lambda ()
            (local-set-key (kbd "<RET>") 'advanced-return)))

(provide 'init-indentation)
