(require-package 'protobuf-mode)
(require 'protobuf-mode)

;; Make .prototxt be recognized as protobuf file as well, which is the
;; file defining network structure for caffe.
(setq auto-mode-alist (cons '("\\.prototxt\\'" . protobuf-mode) auto-mode-alist))

(provide 'init-protobuf)
