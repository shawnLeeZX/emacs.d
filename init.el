
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Disable since Emacs 27, given it is obsolete.
;; (package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

;; Extra packages which don't require any configuration
(require-package 'wgrep)
(require-package 'diminish)
(require-package 'scratch)

(require-package 'gnuplot)
(require-package 'htmlize)
(require-package 'dsvn)
(require-package 'regex-tool)
(when *is-a-mac*
  (require-package 'osx-location))

(require-package 'lua-mode)
(require-package 'djvu)


;; Packages need configuring.
(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-proxies)
(require 'init-dired)
(require 'init-isearch)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)
(require 'init-highlight-indentation)
(require 'init-code-browser-utils)
(require 'init-projectile)

(require 'init-recentf)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-yasnippet)
(require 'init-iedit)
(require 'init-smartparens)
(require 'init-auto-complete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-mmm)
; (require 'init-auto-header)

(require 'init-editing-utils)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

(require 'init-imenu-list)
(require 'init-misc)

(require 'init-dash)
(require 'init-ledger)

(require 'init-evil)
(require 'init-irony)
(require 'init-ggtags)
(require 'init-company)
(require 'init-cedet)

;; Language specific packages.
(require 'init-bash)
(require 'init-term)
(require 'init-cpp)
(require 'init-makefile-mode)
(require 'init-r-mode)
(require 'init-textile)
(require 'init-markdown)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(require 'init-haskell)
;; (require 'init-web-mode)
(require 'init-ruby-mode)
(require 'init-rails)
(require 'init-sql)
(require 'init-octave)
(require 'init-latex)
(require 'init-protobuf)
(require 'init-caffe)
(require 'init-dockerfile-mode)

(require 'init-lisp)
(require 'init-slime)
(require 'init-clojure)
(require 'init-clojure-cider)
(require 'init-common-lisp)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
  (error "Please move init-local.el to ~/.emacs.d/lisp"))
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(add-hook 'after-init-hook
          (lambda ()
            (message "init completed in %.2fms"
                     (sanityinc/time-subtract-millis after-init-time before-init-time))))


(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
