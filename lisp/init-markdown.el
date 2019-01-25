(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\|txt\\|text\\)\\'" . markdown-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook (lambda ()
                                ;; Disable whitespace cleanup since trailing
                                ;; whitespace is important for indentation.
                                (whitespace-cleanup-mode -1)
                              )
)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; Fix tab for autocompletion.
(add-hook 'markdown-mode-hook 'sanityinc/never-indent)

(add-hook 'flyspell-mode-hook
          (lambda ()
            "Use ispell to corrent the word instead of flyspell's."
            (define-key flyspell-mode-map (kbd "C-M-i") 'ispell-complete-word)
          )
)

;; Enable syntax highlighting for math.
(setq markdown-enable-math t)
;; Use smartparens for latex to deal with the math in markdown.
;; smartparens-latex.el is tweaked to make this work:
;; (sp-with-modes '(
;;                  tex-mode
;;                  plain-tex-mode
;;                  latex-mode
;;                  markdown-mode
;; The last line is added to make it work with markdown-mode.
(require 'smartparens-latex)


;; Preview on the fly
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'flymd)
(require 'flymd)
;; Use firefox for preview.
(defun my-flymd-browser-function (url)
   (let ((browse-url-browser-function 'browse-url-firefox))
     (browse-url url)))
(setq flymd-browser-open-function 'my-flymd-browser-function)


(provide 'init-markdown)
