;;; -----------------------------------------------------------------------------
;;; フレーム設定
;;; -----------------------------------------------------------------------------
(setq default-frame-alist
	  (append
	   '((width  . 144)
		 (height .  64)
		 (left   .   0)
		 (top    .   0)
		 (alpha  .  90)
		 (cursor-type . box)
		 ;;(menu-bar-lines . 1)
		 ;;(tool-bar-lines . 0)
		 ;;(left-fringe  . 8)
		 ;;(right-fringe . 8)
		 ;;(line-spacing . 0)
		 )
	   default-frame-alist))

;;; -----------------------------------------------------------------------------
;;; テーマ設定
;;; -----------------------------------------------------------------------------
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
  ;;(load-theme 'deeper-blue t)
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
  (load-theme 'ryerson-tango-dark t)

  ;; テーマ切り替え
  (when my:user-emacs-editing-p
	(require 'theme-looper)
	(bind-key "<f12>" 'theme-looper-enable-next-theme)))

;;; -----------------------------------------------------------------------------
;;; nyan-mode
;;; -----------------------------------------------------------------------------
(require 'nyan-mode)
(nyan-mode)
(nyan-start-animation)
(custom-set-variables '(nyan-wavy-trail t))

;;; -----------------------------------------------------------------------------
;;; フォント設定
;;; -----------------------------------------------------------------------------
(when window-system
  (cond
   (windows-p
    (set-face-attribute 'default nil :family "Consolas" :height 110)
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))
    ;;(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "HGMaruGothicMPRO")))
   (darwin-p
    (set-default-font "-*-Dejavu-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1"))
   (linux-p
	;;(set-default-font "DejaVu Sans Mono-12")
	(set-default-font "Ubuntu Mono-12")
	;;(setq face-font-rescale-alist '((".*Migu 1C.*" . 0.79)))
	(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Migu 1C")))))

(add-to-list 'face-font-rescale-alist '(".*Meiryo UI.*" . 1.1))
;;(encode-coding-string "メイリオ" 'raw-text)
(add-to-list 'face-font-rescale-alist '(".*\203.*" . 1.1));メイリオ
(add-to-list 'face-font-rescale-alist '(".*HG.*M-PRO.*" . 1.1));HG丸ｺﾞｼｯｸM-PRO

;;;
;;; http://www.nobu417.jp/weblog/blogging/using-emacs-with-little-customizing.html
;;;

;;;
;;; http://d.hatena.ne.jp/eggtoothcroc/20130102/p1
;;;
;;; フォント
;;; abcdefghijklmnopqrstuvwxyz
;;; ABCDEFGHIJKLMNOPQRSTUVWXYZ
;;; `1234567890-=\[];',./
;;; ~!@#$%^&*()_+|{}:"<>?
;;;
;;; 壱弐参四五壱弐参四五壱弐参四五壱弐参四五壱弐参四五壱弐参四五
;;; 123456789012345678901234567890123456789012345678901234567890
;;; ABCdeＡＢＣｄｅ
;;;
;;; ┌─────────────────────────────┐
;;; │　　　　　　　　　　　　　罫線                            │
;;; └─────────────────────────────┘
;;;

;;;
;;;  !"#$%&'()*+,-./
;;; 0123456789:;<=>?
;;; @ABCDEFGHIJKLMNO
;;; PQRSTUVWXYZ[\]^_
;;; `abcdefghijklmno
;;; pqrstuvwxyz{|}~
;;;  ｡｢｣､･ｦｧｨｩｪｫｬｭｮｯ
;;; ｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿ
;;; ﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏ
;;; ﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝﾞﾟ
;;;
;;; 一二三四五六七八九十
;;; 壱弐参肆伍陸柒捌玖拾
;;; 12345678901234567890
;;;

;; フォント一覧を表示する
(defun my:font-family-list ()
  (interactive)
  ;;(setq eval-expression-print-length nil)
  (dolist (font-family (font-family-list))
	(message font-family)))
