(require-package 'js2-mode)
(require-package 'ac-js2)
(require-package 'coffee-mode)
;; ---------------------------------------------------------------------------
;; skewer-mode
;; Provides live interaction with JavaScript, CSS, and HTML in a web
;; browser. Expressions are sent on-the-fly from an editing buffer to be
;; evaluated in the browser, just like Emacs does with an inferior Lisp
;; process in Lisp modes.
;; ---------------------------------------------------------------------------
(require-package 'skewer-mode)

;; setup files ending in “.js” to open in js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defvar preferred-javascript-indent-level 2)

;; js2-mode

(after-load 'js2-mode
  (add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS2")))
)

(setq-default
 js2-basic-offset preferred-javascript-indent-level
 js2-bounce-indent-p nil)

(after-load 'js2-mode
  (js2-imenu-extras-setup))

;; ac-js2-mode
(defun enable-ac-js2-mode ()
    ;; The snippet below if you want to evaluate your Javascript code
    ;; for candidates. Not setting this value will still provide you
    ;; with basic completion.
    (setq ac-js2-evaluate-calls t)

    ;; Add any external Javascript files to the variable below. Make sure you
    ;; have initialised ac-js2-evaluate-calls to t if you add any libraries.

    ;; (setq ac-js2-external-libraries '("full/path/to/a-library.js"))
)

(after-load 'js2-mode
  (add-hook 'js2-mode-hook 'ac-js2-mode)
  ;; Since skewer-setup does not work, use skewer-mode directly.
  ;; Here is how for all support modes.
  (add-hook 'css-mode-hook 'skewer-css-mode)
  (add-hook 'html-mode-hook 'skewer-html-mode)
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'js2-mode-hook 'enable-ac-js2-mode)
)

;; Javascript nests {} and () a lot, so I find this helpful

(require-package 'rainbow-delimiters)
(dolist (hook '(js2-mode-hook js-mode-hook json-mode-hook))
  (add-hook hook 'rainbow-delimiters-mode))



;;; Coffeescript

(after-load 'coffee-mode
  (setq coffee-js-mode js2-mode
        coffee-tab-width preferred-javascript-indent-level))

(when (fboundp 'coffee-mode)
  (add-to-list 'auto-mode-alist '("\\.coffee\\.erb\\'" . coffee-mode)))



(provide 'init-javascript)
