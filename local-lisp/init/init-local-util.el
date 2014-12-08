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

(provide `init-local-util)
