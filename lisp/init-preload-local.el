;;; Customized pre-init file.

(sanityinc/add-subdirs-to-load-path
 (expand-file-name "local-lisp/" user-emacs-directory)
)

(provide 'init-preload-local)
