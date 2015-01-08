;;; package --- Summary
;;; Commentary:
;; Miscellenous configuration for using caffe -- the Deep Learning
;; Framework.

(require 'conf-mode)

;; Just find that conf-mode is well suitable for syntax highlight
;; caffe conf file.
(setq auto-mode-alist (cons '("\\.prototxt\\'" . conf-mode) auto-mode-alist))

(provide 'init-caffe)
