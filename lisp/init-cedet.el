
;;; Cedet

;; The major purpose of keeping cedet is to provide a method buffer in ECB.
;; Given that CEDET is convenient for create tags automatically, CEDET is still
;; gotten enabled, but with very limited functions by default, to provide a
;; clearer configure for debug. More functionality will be added at a mode
;; based way.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-default 'semantic-default-submodes '())
;; Do not make it parse files in the same folder and header files for speed
;; reason.
(setq semantic-idle-work-parse-neighboring-files-flag nil)
(setq semantic-idle-work-update-headers-flag nil)

(defun setup-semantic-minor-modes ()
  (semantic-idle-scheduler-mode 1)
  (global-semanticdb-minor-mode 1)
  )

(add-hook 'c-common-mode-hook 'setup-semantic-minor-modes)
(add-hook 'python-mode-hook 'setup-semantic-minor-modes)
(add-hook 'emacs-lisp-mode 'setup-semantic-minor-modes)
(add-hook 'LaTeX-mode 'setup-semantic-minor-modes)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The following is the commented out configuration for using CEDET with C/C++.
;; Cedet is dropped due to its inferiority in speed compared with irony-mode
;; and ggtags
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Start semantic mode.
;; (semantic-mode 1)
;; (global-ede-mode 1)
;; (global-semanticdb-minor-mode 1)
;; Make semantic parse buffers when idle.
;; (global-semantic-idle-scheduler-mode 1)
;; ;; Enable jumping back.
;; (global-semantic-mru-bookmark-mode 1)

;; ;; Display function interface in the minibuffer while emacs is idle..
;; ;; This feature is commented out because it shadows the flymake error in the
;; ;; minibuf.
;; ;; (global-semantic-idle-summary-mode 1)

;; Let Semantic automatically find directory where system include files are
;; stored.
;; (require 'semantic/bovine/gcc)


;; ;; Stick current function interface at the top of the current buffer.
;; ;; One of the problem with current semantic-stickyfunc-mode is that it does not
;; ;; display all parameters that are scattered on multiple lines. This package
;; ;; handles that problem: semantic-stickyfunc-enhance. Extra: stock
;; ;; semantic-stickyfunc-mode does not include assigned values to function
;; ;; parameters of Python. This package also fixed that problem.
;; (require-package 'stickyfunc-enhance)
;; (require 'stickyfunc-enhance)
;; (global-semantic-stickyfunc-mode 1)
;; ;; Added the parsing result to auto-complete list.
;; (defun shawn:enable-c/cpp-semantic ()
;;   (add-to-list 'ac-sources 'ac-source-semantic)
;; )

;; ;; And custom keybindings
;; (defun semantic-config:setup-keys ()
;;   (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
;;   (local-set-key (kbd "M-,") 'semantic-mrub-switch-tags)
;;   (local-set-key (kbd "M-?") 'semantic-ia-show-doc)
;;   ;; (local-set-key (kbd "M-/") 'jedi:get-in-function-call))
;;   )

;; (add-hook 'c-mode-common-hook 'shawn:enable-c/cpp-semantic)
;; (add-hook 'c-mode-common-hook 'semantic-config:setup-keys)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;; Show function prototype
;; ;; function-args is an extension that builds on cedet.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require-package 'function-args)
;; (require 'function-args)
;; (fa-config-default)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'init-cedet)
