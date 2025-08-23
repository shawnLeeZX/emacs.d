;; (require-package 'jedi)

;; (require 'jedi)
(require 'python)

;;; Set up  additional filetype mapping.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Config for python.el.
;;
;; NOTE: the following command has trouble parsing ipython 5+. Turns out elpy
;; works well without the following code. Consider purge.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq
;;  python-shell-interpreter "ipython --simple-prompt"
;;  ;; python-shell-interpreter-args "--gui=wx --matplotlib=wx --colors=Linux"
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 ;; python-shell-completion-setup-code
 ;;   "from IPython.core.completerlib import module_completion"
 ;; python-shell-completion-module-string-code
 ;;   "';'.join(module_completion('''%s'''))\n"
 ;; python-shell-completion-string-code
 ;;   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; elpy
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Now I am using elpy to provide IDE functionality for python. For the reason
;; I made such a choice, refer to
;; http://shawnleezx.github.io/blog/2015/08/05/on-ides-of-python-in-emacs/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require-package 'elpy)
;; ;; Using pyflakes for syntax checking, since from time to time, PEP8 needs to
;; ;; be violated. The varaible setting has to be before `elpy-enable' because it
;; ;; set up a syntax checker in it using the variable.
;; (if (eq system-type 'darwin)
;;     (setq elpy-syntax-check-command "flake8")
;;   (setq elpy-syntax-check-command "pyflakes")
;;   )
;; (elpy-enable)

;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'lsp-pyright)
(setq lsp-pyright-langserver-command "basedpyright")
(add-hook 'python-mode-hook '(lambda ()
                               (require 'lsp-pyright)
                               (lsp-deferred)))


;;; General settings.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The general setting is put last is because that the function that
;; adds to the hook lastly is called lastly. So it will be
;; effective. Otherwise, if it is added at the beginning of this file,
;; auto-fill-mode will not be enabled.
(add-hook 'python-mode-hook 'comment-auto-fill)
;; Add environment header to script.
;; TODO(Shuai) figure out how to call extern program and parse it output.
(defsubst python-header-shell ()
  "Insert #!/usr/bin/env python"
  (insert "#!/usr/bin/env python\n"))

(add-hook 'python-mode-hook (lambda ()
    (add-hook 'make-header-hook 'python-header-shell)
    (remove-hook 'make-header-hook 'header-commentary)
    (flyspell-prog-mode)
    )
          )
;; Smartparens has some support for python. Add it.
(require 'smartparens-python)

;; Refactoring
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'traad)
(require 'traad)
;; NOTE: traad will not give confirmation page about potential changes but
;; refactor the project directly. Use with cautions. Undo is possible though.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTE: Old code saved for reference in case I need them in the future.
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
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Anaconda(Not Used, alternative to elpy)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require-package 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'eldoc-mode)

;; ;; company backend to anaconda
;; (require-package 'company-anaconda)
;; (eval-after-load "company"
;;  '(progn
;;    (add-to-list 'company-backends 'company-anaconda)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;; Jedi(Not Used, alternative to elpy)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; The code here comes from
;; ;; https://github.com/wernerandrew/jedi-starter/blob/master/jedi-starter.el
;; ;; with minor tweak. A explanation about the code could be found
;; ;; [here](https://s3-us-west-2.amazonaws.com/emacsnyc/documents/using-emacs-as-a-python-ide.pdf).
;; ;; Type `M-x jedi:install-server` to initialize when using jedi for the
;; ;; first time.
;; ;; ===================================================================

;; ;; Global Jedi config vars

;; (defvar jedi-config:use-system-python nil
;;   "Will use system python and active environment for Jedi server.
;; May be necessary for some GUI environments (e.g., Mac OS X)")

;; (defvar jedi-config:with-virtualenv nil
;;   "Set to non-nil to point to a particular virtualenv.")

;; (defvar jedi-config:vcs-root-sentinel ".git")

;; (defvar jedi-config:python-module-sentinel "__init__.py")

;; ;; Helper functions

;; ;; Jedi
;; (require 'jedi)

;; ;; (Many) config helpers follow

;; ;; Alternative methods of finding the current project root
;; ;; Method 1: basic
;; (defun get-project-root (buf repo-file &optional init-file)
;;   "Just uses the vc-find-root function to figure out the project root.
;;    Won't always work for some directory layouts."
;;   (let* ((buf-dir (expand-file-name (file-name-directory (buffer-file-name buf))))
;;          (project-root (vc-find-root buf-dir repo-file)))
;;     (if project-root
;;         (expand-file-name project-root)
;;       nil)
;;     )
;;   )

;; ;; Method 2: slightly more robust
;; (defun get-project-root-with-file (buf repo-file &optional init-file)
;;   "Guesses that the python root is the less 'deep' of either:
;;      -- the root directory of the repository, or
;;      -- the directory before the first directory after the root
;;         having the init-file file (e.g., '__init__.py'."

;;   ;; make list of directories from root, removing empty
;;   (defun make-dir-list (path)
;;     (delq nil (mapcar (lambda (x) (and (not (string= x "")) x))
;;                       (split-string path "/"))))
;;   ;; convert a list of directories to a path starting at "/"
;;   (defun dir-list-to-path (dirs)
;;     (mapconcat 'identity (cons "" dirs) "/"))
;;   ;; a little something to try to find the "best" root directory
;;   (defun try-find-best-root (base-dir buffer-dir current)
;;     (cond
;;      (base-dir ;; traverse until we reach the base
;;       (try-find-best-root (cdr base-dir) (cdr buffer-dir)
;;                           (append current (list (car buffer-dir)))))

;;      (buffer-dir ;; try until we hit the current directory
;;       (let* ((next-dir (append current (list (car buffer-dir))))
;;              (file-file (concat (dir-list-to-path next-dir) "/" init-file)))
;;         (if (file-exists-p file-file)
;;             (dir-list-to-path current)
;;           (try-find-best-root nil (cdr buffer-dir) next-dir))))

;;      (t nil)))

;;   (let* ((buffer-dir (expand-file-name (file-name-directory (buffer-file-name buf))))
;;          (vc-root-dir (vc-find-root buffer-dir repo-file)))
;;     (if (and init-file vc-root-dir)
;;         (try-find-best-root
;;          (make-dir-list (expand-file-name vc-root-dir))
;;          (make-dir-list buffer-dir)
;;          '())
;;       vc-root-dir))
;;   ) ;; default to vc root if init file not given

;; ;; Set this variable to find project root
;; (defvar jedi-config:find-root-function 'get-project-root-with-file)

;; (defun current-buffer-project-root ()
;;   (funcall jedi-config:find-root-function
;;            (current-buffer)
;;            jedi-config:vcs-root-sentinel
;;            jedi-config:python-module-sentinel)
;;   )

;; (defun jedi-config:setup-server-args ()
;;   ;; little helper macro for building the arglist
;;   (defmacro add-args (arg-list arg-name arg-value)
;;     `(setq ,arg-list (append ,arg-list (list ,arg-name ,arg-value))))
;;   ;; and now define the args
;;   (let ((project-root (current-buffer-project-root)))

;;     (make-local-variable 'jedi:server-args)

;;     (when project-root
;;       (message (format "Adding system path: %s" project-root))
;;       (add-args jedi:server-args "--sys-path" project-root))

;;     (when jedi-config:with-virtualenv
;;       (message (format "Adding virtualenv: %s" jedi-config:with-virtualenv))
;;       (add-args jedi:server-args "--virtual-env" jedi-config:with-virtualenv)))
;;   )

;; ;; Use system python
;; (defun jedi-config:set-python-executable ()
;;   (set-exec-path-from-shell-PATH)
;;   (make-local-variable 'jedi:server-command)
;;   (set 'jedi:server-command
;;        (list (executable-find "ipython") ;; may need help if running from GUI
;;              (cadr default-jedi-server-command))))

;; ;; Now hook everything up
;; ;; Hook up to autocomplete
;; (add-to-list 'ac-sources 'ac-source-jedi-direct)

;; ;; Enable Jedi setup on mode start
;; (add-hook 'python-mode-hook 'jedi:setup)

;; ;; Buffer-specific server options
;; (add-hook 'python-mode-hook
;;           'jedi-config:setup-server-args)
;; (when jedi-config:use-system-python
;;   (add-hook 'python-mode-hook
;;             'jedi-config:set-python-executable))

;; ;; And custom keybindings
;; (defun jedi-config:setup-keys ()
;;   (local-set-key (kbd "M-.") 'jedi:goto-definition)
;;   (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
;;   (local-set-key (kbd "M-?") 'jedi:show-doc)
;;   (local-set-key (kbd "M-/") 'jedi:get-in-function-call))

;; ;; Don't let tooltip show up automatically
;; (setq jedi:get-in-function-call-delay 10000000)
;; ;; Start completion at method dot
;; (setq jedi:complete-on-dot t)
;; ;; Use custom keybinds
;; (add-hook 'python-mode-hook 'jedi-config:setup-keys)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(provide 'init-python-mode)
