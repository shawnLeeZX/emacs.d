(require-package 'jedi)

(require 'jedi)
(require 'python)

;;; Set up  additional filetype mapping.
;; ===================================================================
(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))

;; TODO: figure out how to refactor python code using ropemacs.
;; ;; Pymacs
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/pymacs/")
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")

;; ;; (setq pymacs-load-path '("~/.emacs.d/site-lisp/ropemacs/"
;; ;;                          "/path/to/rope"))

;; ; ropemacs
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;;; Config for python.el.
;; ===================================================================
(setq
 python-shell-interpreter "ipython"
 ;; python-shell-interpreter-args "--gui=wx --matplotlib=wx --colors=Linux"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


;;; Jedi
;; Config for jedi.
;; ===================================================================
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; The following codes add source file in current project to jedi.
(defvar jedi-config:with-virtualenv nil
  "Set to no-nil to point to a particular virtualenv.")

;; Variables to help find the project root.
(defvar jedi-config:vcs-root-sentinel ".git")
(defvar jedi-config:python-module-sentinel "__init__.py")

(defun get-project-root (buf repo-type init-file)
  (vc-find-root (expand-file-name (buffer-file-name buf)) repo-type)
)

(defvar jedi-config:find-root-function 'get-project-root)

;; And call this on initialization.
;; This is just a functiona wrapper. May unnecessary.
(defun current-buffer-project-root ()
  (funcall jedi-config:find-root-function
           (current-buffer)
           jedi-config:vcs-root-sentinel
           jedi-config:python-module-sentinel))

(defun jedi-config:setup-server-args ()
  ;; helper macro.
  (defmacro add-args (arg-list arg-name arg-value)
    '(setq ,arg-list (append ,arg-list (list ,arg-name ,arg-value))))

  (let ((project-root (current-buffer-project-root)))

    (make-local-variable 'jedi:server-args)

    (when project-root
      (add-args jedi:server-args "--sys-path" project-root))
    (when jedi-config:with-virtualenv
      (add-args jedi:server-args "--virtual-env"
                jedi-config:with-virtualenv))
  )
)
(add-hook 'python-mode-hook 'jedi-config:setup-server-args)

;; Change default key binding.
(defun jedi-config:setup-keys ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "M-?") 'jedi:show-doc)
  (local-set-key (kbd "M-/") 'jedi:get-in-function-call)
  )
(setq jedi:get-in-function-call-delay 10000000)
(add-hook 'python-mode-hook 'jedi-config:setup-keys)

(provide 'init-python-mode)
