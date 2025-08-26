;;; Package -- summary
;; Config for appearance of EMACS.

;;; Commentary:

; don't show the startup screen
(setq inhibit-startup-screen 1)
; don't show the menu bar
(menu-bar-mode 0)
; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode 0)
; don't show the scroll bar
(if window-system (scroll-bar-mode 0))

;; Visualize trailing whitespace, empty lines at the beginning and the end of
;; the file and tabs.
(global-whitespace-mode 1)
(setq whitespace-style '(face trailing tabs tab-mark empty))

;; Display line number on the margin.
(if (version< emacs-version "29")
    (global-linum-mode)
  (global-display-line-numbers-mode 1)
  )
(setq linum-format "%4d \u2502")

; Don't blink the cursor.
(blink-cursor-mode 0)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode 1)

;; Only do automatically vertical split.
;; (setq split-height-threshold nil)
(setq split-width-threshold nil)

;; Highligh TODO etc.
(require-package 'fic-mode)
(require 'fic-mode)
(add-hook 'prog-mode-hook 'fic-mode)

;; Make newly create frames inherit current transparency value.
(add-to-list 'frame-inherited-parameters 'alpha)


(when (eq system-type 'gnu/linux)
  ;; Set default font
  (add-hook 'after-init-hook
            (lambda ()
              (set-frame-font "-1ASC-Liberation Mono-regular-normal-normal-*-27-*-*-*-m-0-iso10646-1" nil t)))
  )


(require 'init-powerline)

(require-package 'ansi-color)
(require 'ansi-color)

(defun my/apply-ansi-color ()
  (ansi-color-apply-on-region (point-min) (point-max)))

(add-hook 'compilation-filter-hook 'my/apply-ansi-color)

;; Choose font size based on PHYSICAL panel width (pixels).

(defun my/apply-font-based-on-monitor (&optional frame)
  "Set font size per FRAME based on the monitor's PHYSICAL width (in pixels)."
  (let* ((f (or frame (selected-frame))))
    (when (display-graphic-p f)
      (let* ((attrs   (frame-monitor-attributes f))   ;; Emacs ≥24.4
             (geom    (alist-get 'geometry attrs))    ;; (x y w h) logical px
             (px-w    (and geom (nth 2 geom)))        ;; logical width
             (px-h    (and geom (nth 3 geom)))        ;; logical height
             ;; Scale factor (2.0 on most Mac Retina). Fallback to 1.0 if unknown.
             (scale   (or (alist-get 'backing-scale-factor attrs)
                          (and (fboundp 'frame-scale-factor) (frame-scale-factor))
                          1.0))
             (phys-w  (when px-w (truncate (* scale px-w))))  ;; PHYSICAL width (px)
             (phys-h  (when px-h (truncate (* scale px-h))))
             ;; Optional: physical size in mm (if the OS reports it)
             (mm-size (alist-get 'mm-size attrs))             ;; (mm-w mm-h) or nil
             ;; Choose font height by PHYSICAL width thresholds (tweak to taste):
             (height
              (cond
               ((and phys-w (>= phys-w 5000)) 275)   ;; super-wide 5K/6K
               ((and phys-w (>= phys-w 3800)) 260)   ;; ~4K / 3.5K+
               ((and phys-w (>= phys-w 3000)) 245)   ;; 3K class
               ((and phys-w (>= phys-w 2560)) 230)   ;; WQHD/2560-wide
               ((and phys-w (>= phys-w 1920)) 215)   ;; 1080p/1920-wide
               (t                                125))))        ;; smaller panels
        ;; Log what happened so you can verify
        (message "Frame %S | Logical %dx%d | Physical %dx%d (scale %.1fx)%s | font height=%d"
                 f (or px-w 0) (or px-h 0)
                 (or phys-w 0) (or phys-h 0) scale
                 (if (and mm-size (car mm-size))
                     (format " | mm-width=%d" (car mm-size))
                   "")
                 height)
        ;; Apply to THIS frame only (so different monitors/frames can differ)
        (set-face-attribute 'default f :height height)))))

;; Apply on startup (for the first frame) and for all new frames (GUI/daemon):
(my/apply-font-based-on-monitor)
(add-hook 'after-make-frame-functions #'my/apply-font-based-on-monitor)

;; Optional: re-evaluate when focus changes (useful if you drag between monitors)
(add-hook 'focus-in-hook #'my/apply-font-based-on-monitor)

(defun my/show-resolution (&optional frame)
  "Show logical and physical resolution for FRAME (macOS/HiDPI aware)."
  (interactive)
  (let* ((f (or frame (selected-frame)))
         (attrs   (frame-monitor-attributes f))
         (geom    (alist-get 'geometry attrs))          ; (x y w h) in logical px
         (px-w    (nth 2 geom))
         (px-h    (nth 3 geom))
         (mm-size (alist-get 'mm-size attrs))           ; (mm-w mm-h) if available
         ;; Try to get Retina scale factor (2.0 on most MacBook Retinas)
         (scale (or (alist-get 'backing-scale-factor attrs)
                    (and (fboundp 'frame-scale-factor) (frame-scale-factor))
                    1.0))
         (logical-ppi (when (and mm-size (> (car mm-size) 0))
                        (/ (float px-w) (/ (car mm-size) 25.4))))
         (physical-w (* scale (float px-w)))
         (physical-h (* scale (float px-h)))
         (physical-ppi (and logical-ppi (* scale logical-ppi))))
    (message "Logical: %dx%d | Physical: %dx%d | Scale: %.1fx | PPI: logical %s, physical %s"
             px-w px-h
             (truncate physical-w) (truncate physical-h)
             scale
             (if logical-ppi (format "%.1f" logical-ppi) "unknown")
             (if physical-ppi (format "%.1f" physical-ppi) "unknown"))))

(provide 'init-appearance)
