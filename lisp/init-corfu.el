(require-package 'corfu)
(global-corfu-mode)

(setq corfu-auto t)           ;; enable auto completion
(setq corfu-auto-delay 0.0)   ;; no delay
(setq corfu-auto-prefix 1)    ;; start after 1 character
(setq corfu-preselect 'prompt) ;; don’t preselect first candidate
(setq corfu-quit-no-match 'separator) ;; quit if no match

(require-package 'cape)
(require 'cape)
(with-eval-after-load 'cape
  (dolist (backend
           '(
             ;; 🔹 Common & very useful
             ;; Complete word from current buffers. See also dabbrev-capf on Emacs 29.
             cape-dabbrev

             ;; ;; 🔹 Programming / coding
             ;; ;; Complete programming language keyword.
             ;; cape-keyword
             ;; ;; Complete Elisp symbol.
             ;; cape-elisp-symbol
             ;; ;; Complete Elisp in Org or Markdown code block.
             ;; cape-elisp-block

             ;; 🔹 Text & writing helpers
             ;; Complete abbreviation (add-global-abbrev, add-mode-abbrev).
             cape-abbrev
             ;; Complete word from dictionary file.
             cape-dict
             ;; Complete entire line from current buffer.
             ;; cape-line

             ;; ;; 🔹 Special character completion
             ;; ;; Complete Unicode char from TeX command, e.g. \hbar.
             ;; cape-tex
             ;; ;; Complete Unicode char from SGML entity, e.g., &alpha.
             ;; cape-sgml
             ;; ;; Complete Unicode char using RFC 1345 mnemonics.
             ;; cape-rfc1345
             ;; ;; Complete Emoji. Available on Emacs 29 and newer.
             ;; cape-emoji

             ;; 🔹 History-based
             ;; Complete from Eshell, Comint or minibuffer history.
             cape-history))
    (add-to-list 'completion-at-point-functions backend))

  (defun my/cape-file-here ()
    "Complete file at point; be quiet if there are no completions."
    (interactive)
    (condition-case _
        (call-interactively (cape-interactive #'cape-file))
      (user-error (message "No file completions at point"))))
  (global-set-key (kbd "C-c f") #'my/cape-file-here)
  )

(add-hook 'corfu-mode-hook 'corfu-popupinfo-mode)
(setq corfu-popupinfo-delay 0.2)

(provide 'init-corfu)
