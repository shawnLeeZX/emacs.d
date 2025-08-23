;; lsp-mode
;;
;; The file sets up lsp for editors and developers, providing autocompletion,
;; diagnostics, and more features.

(require-package 'lsp-mode)

(setq lsp-prompt-project-root t     ;; keep asking on real new projects
      lsp-auto-guess-root t)        ;; good defaults

(with-eval-after-load 'lsp-mode
  ;; Don’t watch these dirs either (faster, less noise)
  (dolist (re '("[/\\\\]\\.venv\\'"
                "[/\\\\]venv\\'"
                "[/\\\\]env\\'"
                "[/\\\\]site-packages\\'"))
    (add-to-list 'lsp-file-watch-ignored-directories re)))

(setq lsp-completion-provider :none)

(provide 'init-lsp)
