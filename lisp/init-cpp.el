;;; init-cpp.el -- Config for c/cpp mode.

;;; Commentary:

;;; Syntax checker.
;; ============================================================================
;; It is quite confusing to have more than one syntax checker in the
;; configuration file.  For overall syntax checking, this repo uses flycheck.
;; However, since the package flymake-google-cpplint uses flymake, So flymake
;; is also included here.  Note that syntax checker does conflict with each
;; other.

(require-package 'flymake-google-cpplint)
(require-package 'flymake-cursor)
(require-package 'google-c-style)

(require 'semantic/bovine/gcc)

;; Autocomplete for c headers.
(require 'init-auto-complete-c-headers)

;; make c++ code comply to google c++ coding style.  This package plays a role
;; as the glue between the cpplint.py, which is a python program to check the
;; code conforming to the code guide written by google, and Emacs.  It calls
;; cpplint.py and display the result in Emacs.
(defun shawn:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
  )
  (flymake-google-cpplint-load)
  )

(add-hook 'c-mode-hook 'shawn:flymake-google-init)
(add-hook 'c++-mode-hook 'shawn:flymake-google-init)

;; The author of flymake-google-cpplint says that flymake-google-cpplint does
;; not support c source files.  However, after some simple check, I found
;; flymake-google-cpplint works for c-mode as well.  But anyway, we install
;; google-c-style to deal with the c source files.  The following lines
;; activate the mode.
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; ============================================================================

;;; Cedet
;; ============================================================================
;; Start semantic mode.
(semantic-mode 1)
;; TODO(Shuai) semantic model also works for a number of other languages,
;; including python, try them out sometime. Then abstract the semantic related
;; code to a separate file.
;; Enable the Project management system
;; TODO(Shuai) get more functionality from http://tuhdo.github.io/c-ide.html
(global-ede-mode 1)
(global-semanticdb-minor-mode 1)
;; Make semantic parse buffers when idle.
(global-semantic-idle-scheduler-mode 1)
;; Enable jumping back.
(global-semantic-mru-bookmark-mode 1)
;; Added the parsing result to auto-complete list.
(defun shawn:enable-c/cpp-semantic ()
  (add-to-list 'ac-sources 'ac-source-semantic)
)

;; And custom keybindings
(defun semantic-config:setup-keys ()
  (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
  (local-set-key (kbd "M-,") 'semantic-mrub-switch-tags)
  (local-set-key (kbd "M-?") 'semantic-ia-show-doc)
  ;; TODO(Shuai) figure similar with semantic.
  ;; (local-set-key (kbd "M-/") 'jedi:get-in-function-call))
  )

(add-hook 'c-mode-common-hook 'shawn:enable-c/cpp-semantic)
(add-hook 'c-mode-common-hook 'semantic-config:setup-keys)
;; ============================================================================

;;; Doxymacs to insert doxygen comment.
;; ============================================================================
(add-hook 'c-mode-common-hook
  (lambda ()
    (require 'doxymacs)
    (doxymacs-mode t)
    (doxymacs-font-lock)
    ;; C++ style is ugly. Do not use it.
    ;; (if (eq major-mode 'java-mode)
    ;;     (setq doxymacs-doxygen-style "JavaDoc")
    ;;   (setq doxymacs-doxygen-style "C++")
    ;; )
    )
  )

;;; General config.
;; ============================================================================
(add-hook 'c-mode-common-hook 'comment-auto-fill)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)

(provide 'init-cpp)
