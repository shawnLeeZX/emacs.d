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

;; start google-c-style with emacs.
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(provide 'init-cpp)
