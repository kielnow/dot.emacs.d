;;; -----------------------------------------------------------------------------
;;; c++-mode
;;; -----------------------------------------------------------------------------
(setq c-basic-offset 4)

;;; -----------------------------------------------------------------------------
;;; web-mode
;;; -----------------------------------------------------------------------------
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\(\\.php\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(defun my:web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset    2)
  (setq web-mode-code-indent-offset   2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'web-mode-hook 'my:web-mode-hook)
;; C-c C-n   (web-mode-navigate)
;; C-c C-e / (web-mode-element-close)
;; C-c C-e s (web-mode-block-select)

;;; -----------------------------------------------------------------------------
;;; js-mode
;;; -----------------------------------------------------------------------------
(setq js-indent-level 2)
(defun my:js-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'js-mode-hook 'my:js-mode-hook)

;;; -----------------------------------------------------------------------------
;;; php-mode
;;; -----------------------------------------------------------------------------
(defun my:php-mode-hook ()
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'php-mode-hook 'my:php-mode-hook)

;;; -----------------------------------------------------------------------------
;;; e2wm
;;; -----------------------------------------------------------------------------
(require 'e2wm)
;;(setq e2wm:prefix-key "C-c ;")
;; 終了する場合は C-c ; Q
(bind-key "M-+" 'e2wm:start-management)
(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(("<M-left>"  . e2wm:dp-code)
   ("<M-right>" . e2wm:dp-two)
   ("<M-up>"    . e2wm:dp-doc)
   ("<M-down>"  . e2wm:dp-dashboard)
   ("C-."       . e2wm:pst-history-forward-command)
   ("C-,"       . e2wm:pst-history-back-command)
   ("prefix L"  . ielm)  ; C-c ; L
   ("M-m"       . e2wm:pst-window-select-main-command)
   ) e2wm:prefix-key)

;;; -----------------------------------------------------------------------------
;;; persp-mode
;;; -----------------------------------------------------------------------------
(require 'persp-mode)
(setq persp-keymap-prefix (kbd "C-c p"))
(setq persp-add-on-switch-or-display t)
(persp-mode 1)
;; C-c p s (persp-switch)
;; C-c p k (persp-kill)

;;; -----------------------------------------------------------------------------
;;; minimap
;;; -----------------------------------------------------------------------------
(require 'minimap)
(setq minimap-window-location 'right)
(setq minimap-recenter-type 'relative)
(setq minimap-update-delay 0.1)
(setq minimap-width-fraction 0.1)
(scroll-bar-mode 0)
(set-face-background 'minimap-active-region-background "RoyalBlue4")
(set-face-attribute 'minimap-font-face nil :height 20)
(defun my:minimap-mode-hook ()
  (setq mode-line-format '("%e" mode-line-front-space mode-line-buffer-identification mode-line-end-spaces)))
(add-hook 'minimap-mode-hook 'my:minimap-mode-hook)
(bind-key "<f9>" 'minimap-toggle)

;;; -----------------------------------------------------------------------------
;;; sublimity
;;; -----------------------------------------------------------------------------
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

;;; -----------------------------------------------------------------------------
;;; hiwin
;;; -----------------------------------------------------------------------------
(require 'hiwin)
;;(hiwin-mode)
