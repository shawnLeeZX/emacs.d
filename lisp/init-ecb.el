(require-package 'ecb)

;; Change ecb layout.
;; Since I did not find out how the new layout is stored by ecb yet and did not
;; figure out how to write it using macro, it is possible one has to create the
;; new layout each time setting up emacs on a new machine.
(setq ecb-layout-name "shawn-layout")

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

;; Run ECB after Emacs starts.
(setq ecb-auto-activate t)

(defun ecb-activated-in-selected-frame ()
  "A hack to use ECB in multiple frames. It first deactivates ECB, then
activate it in current frame."
  (interactive)
  (let ((current-frame (selected-frame)))
    ; The frame foucs change when activating or deactivating ECB is weird, so
    ; activate current selected frame explicitly.
    (if (and (boundp 'ecb-minor-mode) (ecb-minor-mode))
        (ecb-deactivate)
      )
    (select-frame current-frame)
    (ecb-activate)
    )
  )

;; Display speedbar in the same frame. The speedbar of ECB is weird. Each time
;; I want to enter a directory, it always enters in that directory for less one
;; second and goes back. So I have use `sr-speedbar` to do this.
(require-package 'sr-speedbar)
(require 'sr-speedbar)

(provide 'init-ecb)
