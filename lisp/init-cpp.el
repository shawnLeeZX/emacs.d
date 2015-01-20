;;; Config for c/cpp mode.
(require-package 'flymake-google-cpplint)
(require-package 'flymake-cursor)
(require-package 'google-c-style)

(require 'semantic/bovine/gcc)

;; Autocomplete for c headers.
(require 'init-auto-complete-c-headers)

;; flymake for google: make c code comply to google c coding style.
(defun shawn:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
  )
  (flymake-google-cpplint-load)
  )

(add-hook 'c-mode-hook 'shawn:flymake-google-init)
(add-hook 'c++-mode-hook 'shawn:flymake-google-init)

;;; Cedet
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
(add-hook 'c-mode-common-hook 'comment-auto-fill)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)

(provide 'init-cpp)
