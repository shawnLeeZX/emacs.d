;;; Config for c/cpp mode.
(require-package 'flymake-google-cpplint)
(require-package 'flymake-cursor)
(require-package 'google-c-style)

;; Autocomplete for c headers.
(require 'init-auto-complete-c-headers)

;; flymake for google: make c code comply to google c coding style.
(defun shawn:flymake-google-init ()
  (require 'flycheck-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
  )
  (flymake-google-cpplint-load)
  )

(add-hook 'c-mode-hook 'shawn:flymake-google-init)
(add-hook 'c++-mode-hook 'shawn:flymake-google-init)

;; Start semantic mode.
(semantic-mode 1)
;; Make semantic parse buffers when idle.
(global-semantic-idle-scheduler-mode 1)
;; Enable semantic parsing for c/cpp.
(defun shawn:enable-c/cpp-semantic ()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'shawn:enable-c/cpp-semantic)
(add-hook 'c-mode-common-hook 'comment-auto-fill)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)

(provide 'init-cpp)
