(require-package 'ecb)

;; Change ecb layout.
(setq ecb-layout-name "leftright1")

;; How to change ecb windows width.
;;
;; ECB offers to re-adjust the width and height of the ECB-windows (e.g. by
;; dragging the windows-borders via the mouse) and then saving exactly these
;; current window-sizes for the current layout so after activating this layout
;; all windows have autom. the stored sizes.
;;
;; This is done via the option ecb-layout-window-sizes and the commands
;; ecb-store-window-sizes, ecb-restore-window-sizes and
;; ecb-restore-default-window-sizes.
;;
;; Here is an example how to resize and store the sizes of the ECB-windows of
;; layout “left1”:
;;
;; Switch to layout “left1” via ecb-change-layout (C-c . lc) Resize the
;; ECB-windows by dragging the window-borders with the mouse Call
;; ecb-store-window-sizes After this layout “left1” will be always drawn with
;; the new sizes until you call ecb-restore-default-window-sizes during layout
;; “left1” is active.
;;
;; See more at http://ecb.sourceforge.net/docs/Changing-window-sizes.html

(provide 'init-ecb)
