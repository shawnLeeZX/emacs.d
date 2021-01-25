;; Disable the warning for packages depends on `cl'. Ideally, these packages
;; should use `cl-lib', cf. https://github.com/kiwanami/emacs-epc/issues/35
(setq byte-compile-warnings '(cl-functions))
