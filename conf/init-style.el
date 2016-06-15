(require 'init-prelude)
(require 'init-font)

;;;-----------------------------------------------------------------------------
;;; テーマ設定
;;;-----------------------------------------------------------------------------
(when emacs24-p
  (add-to-list 'custom-theme-load-path (locate-user-emacs-file "themes/"))

  ;; light
  ;;(load-theme 'adwaita t)
  ;;(load-theme 'dichromacy t)
  ;;(load-theme 'leuven t)
  ;;(load-theme 'light-blue t)
  ;;(load-theme 'tango t)
  ;;(load-theme 'tsdh-light t)
  ;;(load-theme 'whiteboard t)

  ;; dark
  (load-theme 'deeper-blue t)
  ;;(load-theme 'misterioso t)
  ;;(load-theme 'tango-dark t)
  ;;(load-theme 'tsdh-dark t)
  ;;(load-theme 'wombat t)

  ;; black
  ;;(load-theme 'manoj-dark t)
  ;;(load-theme 'wheatgrass t)
  ;;(load-theme 'molokai t)

  ;; blue
  ;;(load-theme 'ryerson t)
  ;;(load-theme 'ryerson-tango-dark t)

  ;; テーマ切り替え
  (use-package theme-looper
	:config
	(bind-key "<f12>" 'theme-looper-enable-next-theme)))

;;;-----------------------------------------------------------------------------
;;; nyan-mode
;;;-----------------------------------------------------------------------------
(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation)
  (set-variable 'nyan-wavy-trail t))

;;;-----------------------------------------------------------------------------
;;; フレーム設定
;;;-----------------------------------------------------------------------------
(let* ((workarea (assoc 'workarea (car (display-monitor-attributes-list))))
	   (left   (nth 1 workarea))
	   (top    (nth 2 workarea))
	   (width  (/ (nth 3 workarea) 2 (frame-char-width)))
	   (height (/ (- (nth 4 workarea) 32 32) (frame-char-height))))
  (setq default-frame-alist
		(append
		 `((width  . ,width);(width  . 144)
		   (height . ,height);(height .  62)
		   (left   . ,left)
		   (top    . ,top)
		   (alpha  . 90)
		   (cursor-type . box)
		   ;;(menu-bar-lines . 1)
		   ;;(tool-bar-lines . 0)
		   ;;(left-fringe  . 8)
		   ;;(right-fringe . 8)
		   ;;(line-spacing . 0)
		   )
		 default-frame-alist)))

;;;-----------------------------------------------------------------------------
;;; highlight-symbol
;;;-----------------------------------------------------------------------------
(use-package auto-highlight-symbol
  :config
  (set-variable 'ahs-idle-interval 0.2)
  ;;(global-auto-highlight-symbol-mode 1)
  )
(use-package highlight-symbol
  :bind
  (("C-c h" . highlight-symbol)))

;;;-----------------------------------------------------------------------------
;;; powerline
;;;-----------------------------------------------------------------------------
;;(use-package powerline
;;  :config
;;  (powerline-default-theme))

;;;-----------------------------------------------------------------------------
;;; minimap
;;;-----------------------------------------------------------------------------
;;(use-package minimap
;;  :config
;;  (setq minimap-window-location 'right)
;;  (setq minimap-recenter-type 'relative)
;;  (setq minimap-update-delay 0.1)
;;  (setq minimap-width-fraction 0.05)
;;  (setq minimap-minimum-width 24)
;;  (scroll-bar-mode 0)
;;  (set-face-background 'minimap-active-region-background "RoyalBlue4")
;;  (set-face-attribute 'minimap-font-face nil :height 20)
;;  (defun my/minimap-mode-hook ()
;;	(setq mode-line-format '("%e" mode-line-front-space mode-line-buffer-identification mode-line-end-spaces)))
;;  (add-hook 'minimap-mode-hook 'my/minimap-mode-hook)
;;  (bind-key "<f9>" 'minimap-mode))

;;;-----------------------------------------------------------------------------
;;; sublimity
;;;-----------------------------------------------------------------------------
;; (require 'sublimity)
;; (sublimity-mode)
;;
;; ;; sublimity-map
;; (require 'sublimity-map)
;; (sublimity-map-set-delay 0.1)
;; (setq sublimity-map-size 20)
;; (setq sublimity-map-active-region 'hl-line)
;; (scroll-bar-mode 0)
;;
;; ;; sublimity-attractive
;; (require 'sublimity-attractive)
;; (setq sublimity-attractive-centering-width nil)
;; (sublimity-attractive-hide-bars)
;; (sublimity-attractive-hide-vertical-border)
;; (sublimity-attractive-hide-fringes)
;; (sublimity-attractive-window-change)
;;
;; ;; sublimity-scroll
;; (require 'sublimity-scroll)
;; (setq sublimity-scroll-weight 1)
;; (setq sublimity-scroll-drift-length 4)

;;;-----------------------------------------------------------------------------
;;; hiwin
;;;-----------------------------------------------------------------------------
(use-package hiwin
  :config
  ;;(hiwin-mode)
  )

(require 'el-init)
(el-init-provide)