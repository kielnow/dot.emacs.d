;;; -----------------------------------------------------------------------------
;;; キー設定
;;; -----------------------------------------------------------------------------
;; キーバインドを通知
(setq suggest-key-bindings t)

;; 画面分割時に Shift + 矢印キー でウィンドウを移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;;; -----------------------------------------------------------------------------
;;; Mac OS X
;;; -----------------------------------------------------------------------------
(when darwin-p
  ;; Command キーを meta に
  (setq ns-command-modifier 'meta)
  ;; Option キーを control に
  (setq ns-alternate-modifier 'super)
  ;; システムの装飾キーを無効に
  (setq mac-pass-control-to-system t)
  (setq mac-pass-command-to-system t)
  (setq mac-pass-option-to-system t)
  (global-set-key [ns-drag-file] 'ns-find-file))

;;; -----------------------------------------------------------------------------
;;; bind-key
;;; -----------------------------------------------------------------------------
(require 'bind-key)

;; ヘルプ
;;(bind-key "C-x h"	'help-command)
(bind-key "M-h"		'help-command)
(bind-key "<f1>"	'help-command)

;; 再読み込み
(bind-key "<f5>" 'revert-buffer)

;; 日付
(defun date (&optional p)
  (interactive "P")
  (insert (format-time-string (if p "%Y/%m/%d %H:%M:%S" "%Y%m%d%H%M"))))
(bind-key "<f6>" 'date)

;; 実行
(bind-key "<f7>"	'eval-last-sexp)
(bind-key "<C-f7>"	'eval-buffer)

;; 行末の空白を削除
(bind-key "<M-f8>" 'delete-trailing-whitespace)

;; カーソルを移動せずにスクロール
;;(bind-key "M-n" (lambda () (interactive) (scroll-up 1)))
;;(bind-key "M-p" (lambda () (interactive) (scroll-down 1)))

;;; -----------------------------------------------------------------------------
;;; フォントサイズを変更
;;; -----------------------------------------------------------------------------
(defun my:text-scale-0 () (interactive) (text-scale-set 0))
(defun my:text-scale-1 () (interactive) (text-scale-set 1))
(defun my:text-scale-2 () (interactive) (text-scale-set 2))
(defun my:text-scale-3 () (interactive) (text-scale-set 3))
(defun my:text-scale-4 () (interactive) (text-scale-set 4))
(defun my:text-scale-5 () (interactive) (text-scale-set 5))
(defun my:text-scale-6 () (interactive) (text-scale-set 6))
(defun my:text-scale-7 () (interactive) (text-scale-set 7))
(defun my:text-scale-8 () (interactive) (text-scale-set 8))
(defun my:text-scale-9 () (interactive) (text-scale-set 9))

(bind-keys
 ("C-+" . text-scale-increase)
 ("C--" . text-scale-decrease)
 ("<C-f1>" . my:text-scale-0)
 ("<C-f2>" . my:text-scale-1)
 ("<C-f3>" . my:text-scale-2)
 ("<C-f4>" . my:text-scale-3)
 ("<C-f5>" . my:text-scale-4)
 ("<C-f6>" . my:text-scale-5)
 ("<C-f7>" . my:text-scale-6)
 ("<C-f8>" . my:text-scale-7)
 ("<C-f9>" . my:text-scale-8)
 ("<C-kp-add>"   . text-scale-increase)
 ("<C-subtract>" . text-scale-decrease)
 ("<C-kp-0>" . my:text-scale-0)
 ("<C-kp-1>" . my:text-scale-1)
 ("<C-kp-2>" . my:text-scale-2)
 ("<C-kp-3>" . my:text-scale-3)
 ("<C-kp-4>" . my:text-scale-4)
 ("<C-kp-5>" . my:text-scale-5)
 ("<C-kp-6>" . my:text-scale-6)
 ("<C-kp-7>" . my:text-scale-7)
 ("<C-kp-8>" . my:text-scale-8)
 ("<C-kp-9>" . my:text-scale-9))

;;; -----------------------------------------------------------------------------
;;; ウィンドウの透明度を変更
;;; -----------------------------------------------------------------------------
(defun my:frame-alpha ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
	(if alpha alpha 100)))

(defun my:frame-alpha-set (level)
  (interactive "P")
  (setq level (if level level 100))
  (when (and (>= level frame-alpha-lower-limit) (<= level 100))
	(modify-frame-parameters nil `((alpha . ,level)))))

(defvar my:frame-alpha-step 5)

(defun my:frame-alpha-increase (inc)
  (interactive "p")
  (my:frame-alpha-set (+ (* inc my:frame-alpha-step) (my:frame-alpha))))

(defun my:frame-alpha-decrease (dec)
  (interactive "p")
  (my:frame-alpha-increase (- dec)))

(bind-keys
 ("<C-f11>" . my:frame-alpha-decrease)
 ("<C-f12>" . my:frame-alpha-increase)
 ("<C-f10>" . my:frame-alpha-set))

;;; -----------------------------------------------------------------------------
;;; 右クリックメニュー
;;; -----------------------------------------------------------------------------
(defun my:mouse-edit-menu (event)
  (interactive "e")
  (popup-menu menu-bar-edit-menu))
(bind-key "<mouse-3>" 'my:mouse-edit-menu)
(bind-key "<C-mouse-3>" 'mouse-popup-menubar)
