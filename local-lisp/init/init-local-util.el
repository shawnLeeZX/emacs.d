;;;; Common utilities for emacs.

;;; Setup between-applications copy and paste.
;;; ========================================================================
;; http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
(setq x-select-enable-clipboard t)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; I prefer using the "clipboard" selection (the one the
        ;; typically is used by c-c/c-v) before the primary selection
        ;; (that uses mouse-select/middle-button-click)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")
      )
    )
    ;; Call back for when user pastes
    (defun xsel-paste-function ()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output
        )
      )
    )
    ;; Attach callbacks to hooks

    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
  )
)

;;; 
;;; ========================================================================
;; Only turn on aut-fill-mode in comments.
(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1)
)

;;; Kill buffers.
;;; ========================================================================
;; Kill all other buffers.
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
)

;; Kill all dired buffers.
(defun kill-dired-buffers ()
	 (interactive)
	 (mapc (lambda (buffer)
           (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
             (kill-buffer buffer)))
         (buffer-list)
         )
)

;; Turn off indentation binded with tab.
;; ===============
;; Function to indent the current line.  This function will be called
;; with no arguments.  If it is called somewhere where
;; auto-indentation cannot be done (e.g. inside a string), the
;; function should simply return `noindent'.  Setting this function is
;; all you need to make TAB indent appropriately.  Don't rebind TAB
;; unless you really need to.
;;
;; The function defined here use anomynous function to return the
;; 'noindent to disable the indentation functionality of tab.
(defun sanityinc/never-indent ()
  (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

;;; Set the transparence of emacs.
;; ===================================================================
(defun transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nTransparency Value 0 - 100 opaque:")
   (set-frame-parameter (selected-frame) 'alpha value)
)

;;; Add command to open file using system programs.
;; ===================================================================
(defun open-in-external-app (&optional file)
  "Open the current file or dired marked files in external app. The app
is chosen from your OS's preference."
  (interactive)

  (let ( confirm
         (file-list
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           ((not file) (list (buffer-file-name)))
           (file (list file))
           )
          )
         )
    
    (setq confirm (if (<= (length file-list) 5)
                   t
                 (y-or-n-p "Open more than 5 files? ")
                 )
          )
    
    (when confirm
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (file-path)
           (w32-shell-execute "open"
                              (replace-regexp-in-string "/" "\\" file-path t t)
                              )
           )
         file-list)
        )
       ((string-equal system-type "darwin")
        (mapc
         (lambda (file-path)
           (shell-command (format "open \"%s\"" file-path))
           )
         file-list)
        )
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (file-path)
           (let ((process-connection-type nil))
             (start-process "" nil "xdg-open" file-path)
             )
           )
         file-list)
        )
       )
      )
    )
  )

;;; Create customized occur to make it only search buffers that has
;; the same mode of current buffer.
;; ===================================================================
(eval-when-compile
  (require 'cl))

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

;;; Utility to insert a seperator line.
;; ===================================================================
(defun insert-separator ()
  "Insert equal sign till reaching the fill width."
  (interactive)

  ;; Note on ?= :
  ;; A character is a Lisp object which represents a single character of
  ;; text. In Emacs Lisp, characters are simply integers; whether an integer is
  ;; a character or not is determined only by how it is used.
  ;; Append a question mark before a char is to indicate this is a char.
  (insert (make-string (- fill-column (current-column)) ?=))
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


;; On Environment Variables.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Small helper to scrape text from shell output
(defun get-shell-output (cmd)
  (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string cmd))
  )

;; Ensure that PATH is taken from shell
;; Taken from: http://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell."
  (interactive)
  (let ((path-from-shell (get-shell-output "$SHELL --login -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))
    )
  )

(provide `init-local-util)
