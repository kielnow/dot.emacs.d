;; 初期フレーム設定
(when linux-p
  (setq default-frame-alist
    (append (list
      '(width  . 144)
      '(height . 64)
      '(top    . 0)
      '(left   . 0)
      '(alpha  . 75)
      )
    default-frame-alist)))
(when darwin-p
  (setq default-frame-alist
    (append (list
      '(width  . 144)
      '(height . 64)
      '(top    . 0)
      '(left   . 0)
      '(alpha  . 90)
      )
    default-frame-alist)))
(when nt-p
  (setq default-frame-alist
    (append (list
      '(width  . 144)
      '(height . 56)
      '(top    . 0)
      '(left   . 0)
      '(alpha  . 90)
      )
    default-frame-alist)))

;;-----------------------------------------------------------------------------
;; テーマ設定
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'wombat t)
;(load-theme 'misterioso t)
;(load-theme 'molokai t)
;(load-theme 'manoj-dark t)
(load-theme 'tango-dark t)
;(load-theme 'tsdh-dark t)
(load-theme 'ryerson t)

;;-----------------------------------------------------------------------------
;; フォント設定
(cond (window-system
  (when linux-p
    ;(set-default-font "DejaVu Sans Mono-12")
    (set-default-font "Ubuntu Mono-12")
    ;(setq face-font-rescale-alist '((".*Migu 1C.*" . 0.79)))
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Migu 1C")))
  (when darwin-p
    (set-default-font "-*-Dejavu-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1"))
  (when nt-p
    (set-face-attribute 'default nil :family "Consolas" :height 110)
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))))

;;-----------------------------------------------------------------------------
;; 行番号を表示
(global-linum-mode t)
;; 行番号の色とフォーマットの設定
(set-face-attribute 'linum nil :foreground "cyan" :height 0.8)
(setq linum-format "%4d")

;; 編集行をハイライト
(global-hl-line-mode)
;; 桁をハイライト
;(require 'col-highlight)
;(column-highlight-mode 1)              ; 常にハイライト
;(toggle-highlight-column-when-idle 1)  ; 動作がないときにハイライト
;(col-highlight-set-interval 1)         ; （秒数を指定）
;; hl-line, col-highlight の色の設定
(custom-set-faces '(hl-line ((t (:background "RoyalBlue4")))))
;(custom-set-faces '(col-highlight ((t (:background "RoyalBlue4")))))

