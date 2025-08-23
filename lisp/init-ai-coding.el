;; Packages for AI coding.


;; Ghost text shows after physical end of line. Shoing a fill column width
;; indicator would make the ghost text show at the end of fill column. Thus, we
;; disable this extension.

;; Display a visual indicator for fill column width.
;; (require 'fill-column-indicator)
;; (define-global-minor-mode
;;   global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode t)

;; aider
(require-package 'aidermacs)

(require 'aidermacs)

;; Where the `aider` binary is (usually in your venv or user site-packages bin)
(setq aidermacs-aider-command (executable-find "aider"))
;; Optional: default args (Aider will also read ~/.aider.conf.yml)
(setq aidermacs-extra-args '())
;; Auto wrap line when chatting.
(add-hook 'aidermacs-mode-hook #'visual-line-mode)

;; --- minuet-ai.el (ghost-text from LLMs) ---
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'minuet)
(require 'minuet)

(setq minuet-n-completions 1) ; recommended for Local LLM for resource saving
;; I recommend beginning with a small context window size and incrementally
;; expanding it, depending on your local computing power. A context window
;; of 512, serves as an good starting point to estimate your computing
;; power. Once you have a reliable estimate of your local computing power,
;; you should adjust the context window to a larger value.
(setq minuet-context-window 8192)

;; these work everywhere, regardless of minuet mode
(global-set-key (kbd "M-y") #'minuet-complete-with-minibuffer)
(global-set-key (kbd "M-i") #'minuet-show-suggestion)
(global-set-key (kbd "C-c m") #'minuet-configure-provider)

;; these only make sense while a suggestion is active
;; so we bind them in `minuet-active-mode-map`
(with-eval-after-load 'minuet
  (define-key minuet-active-mode-map (kbd "M-p") #'minuet-previous-suggestion)
  (define-key minuet-active-mode-map (kbd "M-n") #'minuet-next-suggestion)
  (define-key minuet-active-mode-map (kbd "M-A") #'minuet-accept-suggestion)
  (define-key minuet-active-mode-map (kbd "M-a") #'minuet-accept-suggestion-line)
  (define-key minuet-active-mode-map (kbd "M-e") #'minuet-dismiss-suggestion))

;; Configuration for specialized code model.
;; (setq minuet-provider 'openai-fim-compatible)
;; (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:1234/v1/completions")
;; ;; an arbitrary non-null environment variable as placeholder.
;; ;; For Windows users, TERM may not be present in environment variables.
;; ;; Consider using APPDATA instead.
;; (plist-put minuet-openai-fim-compatible-options :name "Ollama")
;; (plist-put minuet-openai-fim-compatible-options :api-key "TERM")
;; (plist-put minuet-openai-fim-compatible-options :model "openai/gpt-oss-20b")

;; (minuet-set-optional-options minuet-openai-fim-compatible-options :max_tokens 56)

;; Configuration for chat model.
(setq minuet-provider 'openai-compatible)
(setq minuet-request-timeout 2.5)
(setq minuet-auto-suggestion-throttle-delay 1.5) ;; Increase to reduce costs and avoid rate limits
(setq minuet-auto-suggestion-debounce-delay 0.6) ;; Increase to reduce costs and avoid rate limits

(plist-put minuet-openai-compatible-options :end-point "http://localhost:1234/v1/chat/completions")
(plist-put minuet-openai-compatible-options :api-key "TERM")
(plist-put minuet-openai-compatible-options :model "openai/gpt-oss-20b")


(provide 'init-ai-coding)
