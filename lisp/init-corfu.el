(require-package 'corfu)
(global-corfu-mode)

(setq corfu-auto t)           ;; enable auto completion
(setq corfu-auto-delay 0.0)   ;; no delay
(setq corfu-auto-prefix 1)    ;; start after 1 character
(setq corfu-preselect 'prompt) ;; don’t preselect first candidate
(setq corfu-quit-no-match 'separator) ;; quit if no match

(add-hook 'corfu-mode-hook 'corfu-popupinfo-mode)
(setq corfu-popupinfo-delay 0.2)

(provide 'init-corfu)
