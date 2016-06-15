(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; フォント設定
;;;-----------------------------------------------------------------------------
(defun my/set-fontset-font-japanese (font)
  (dolist (charset
		   '(katakana-jisx0201;半角カナ
			 japanese-jisx0208;JIS基本漢字(第1-2水準漢字)
			 japanese-jisx0212;JIS補助漢字 
			 japanese-jisx0213-1;JIS拡張漢字(第3-4水準漢字)
			 japanese-jisx0213-2
			 japanese-jisx0213-a
			 japanese-jisx0213.2004-1
			 ))
		   (set-fontset-font nil charset font)))

(defun my/set-fontset-font-symbol (font)
  (dolist (charset
		   '((#x2000 . #x2BFF);数学記号など
			 ))
		   (set-fontset-font nil charset font)))

(when window-system
  (cond
   (windows-p
    (set-face-attribute 'default nil :family "Consolas" :height 110)
    ;;(my/set-fontset-font-japanese (font-spec :family "Migu 1M"))
	;;(my/set-fontset-font-japanese (font-spec :family "Meiryo"))
    (my/set-fontset-font-japanese (font-spec :family "HGMaruGothicMPRO"))
    ;;(my/set-fontset-font-symbol (font-spec :family "Migu 1M"))
	;;(my/set-fontset-font-symbol (font-spec :family "Meiryo UI"))
	(my/set-fontset-font-symbol (font-spec :family "\202l\202r \203S\203V\203b\203N"));MS ゴシック
	)
   (darwin-p
    (set-default-font "-*-Dejavu-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1"))
   (linux-p
	;;(set-default-font "DejaVu Sans Mono-12")
	(set-default-font "Ubuntu Mono-12")
	;;(setq face-font-rescale-alist '((".*Migu 1C.*" . 0.79)))
	(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Migu 1C")))))

(add-to-list 'face-font-rescale-alist '(".*Migu 1M.*" . 1.1))
(add-to-list 'face-font-rescale-alist '(".*Meiryo UI.*" . 1.1))
(add-to-list 'face-font-rescale-alist '(".*\300\203\300\201\300\203C\300\203\300\212\300\203I.*" . 1.1));メイリオ
(add-to-list 'face-font-rescale-alist '(".*HG\300\212\333\272\336\274\300\257\300\270M-PRO.*" . 1.1));HG丸ｺﾞｼｯｸM-PRO
(add-to-list 'face-font-rescale-alist '(".*\300\202l\300\202r \300\203S\300\203V\300\203b\300\203N.*" . 1.1));MS ゴシック

;;;
;;; 現在のフレームのフォントを調べる
;;; describe-fontset
;;;
;;; カーソル位置の文字のフォントを調べる
;;; C-u C-x =
;;;
;;; フォント名を調べる
;;; x-select-font
;;;
;;; フォント一覧
;;; font-family-list
;;; x-list-fonts
;;;
;;; 文字セット一覧
;;; charset-list
;;;
;;; 文字セットの文字一覧
;;; M-x list-charset-chars RET japanese-jisx208
;;;

;;; フォント一覧
(defun my/font-family-list ()
  (interactive)
  (dolist (x (font-family-list)) (princ (format "%s\n" x))))
(defun my/list-fonts ()
  (interactive)
  (dolist (x (x-list-fonts "*")) (princ (format "%s\n" x))))

;;; 文字セット一覧
(defun my/charset-list ()
  (interactive)
  (dolist (x (charset-list)) (princ (format "%s\n" x))))

;;;
;;; (encode-coding-string (encode-coding-string "メイリオ" 'sjis) 'raw-text)
;;;

;;;
;;; Unicode Table
;;; http://homepage2.nifty.com/k_maeda/code/uni/index.html
;;;

;;;
;;; http://macemacsjp.osdn.jp/matsuan/FontSettingJp.html
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

(require 'el-init)
(el-init-provide)