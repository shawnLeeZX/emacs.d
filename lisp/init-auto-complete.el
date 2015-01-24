(require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; Controls the operation of the TAB key.  If t, hitting TAB always just indents
;; the current line.  If nil, hitting TAB indents the current line if point is
;; at the left margin or in the line's indentation, otherwise it inserts a
;; "real" TAB character.  If `complete', TAB first tries to indent the current
;; line, and if the line was already indented, then try to complete the thing at
;; point.
(setq tab-always-indent 'complete)

;; This is a style added by sanityinc, did not try to figure out its meaning yet.
(add-to-list 'completion-styles 'initials t)
;; Stop completion-at-point from popping up completion buffers so eagerly
(setq completion-cycle-threshold 5)

;; c-tab-always-indent:
;; If t, hitting TAB always just indents the current line.  If nil, hitting TAB
;; indents the current line if point is at the left margin or in the line's
;; indentation, otherwise it calls `c-insert-tab-function' to insert a `real'
;; tab character.
;; indent-for-tab-command:
;; Indent the current line or region, or insert a tab, as appropriate.
(setq c-tab-always-indent nil
      c-insert-tab-function 'indent-for-tab-command)

;; Auto start auto completion after typing three characters.
(setq ac-auto-start 3)
;; Do not ignore case.
(setq ac-ignore-case nil)

;; This is a smart mechanism provided by auto-complete to use tab -- only when
;; user has typed characters, pressing TAB is viewed as trying get
;; completion. Otherwise, TAB is in its normal meaning, for instance, inserting
;; tab character.
;; <tab> is bound to the even you are pressing tab key while "TAB" is one acsii
;; number that corresponding to tab. When the tab key is pressed, it is the
;; software to determine whether "TAB" is sent out or not. And yasnippet does
;; some trick, if we want autocomplete to work in whatever situation, it is
;; bettern we bind it to the actual key pressing event.
(ac-set-trigger-key "<tab>")

;; Add modes that would use autocompletion.
(set-default 'ac-sources
             '(ac-source-imenu
               ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer
               ac-source-filename))

(dolist (mode '(magit-log-edit-mode
                log-edit-mode org-mode text-mode haml-mode
                git-commit-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode
                js3-mode css-mode less-css-mode sql-mode
                sql-interactive-mode
                inferior-emacs-lisp-mode
                web-mode
                inferior-python-mode))
  (add-to-list 'ac-modes mode))

;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)


(provide 'init-auto-complete)
