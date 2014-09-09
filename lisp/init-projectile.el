(require-package 'projectile)

(require 'projectile)
;; You can enable Projectile globally like this:

(projectile-global-mode)
;; To enable Projectile only in select modes:

;; (add-hook 'ruby-mode-hook 'projectile-mode)
;; If you're going to use the default ido completion it's extremely
;; highly recommended that you install the optional flx-ido package,
;; which provides a much more powerful alternative to ido's built-in flex
;; matching.

(provide 'init-projectile)
