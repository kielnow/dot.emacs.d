;; Metaキーを変更
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; システムの装飾キーを無効に
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

;; キーバインドの通知
(setq suggest-key-bindings t)

;;-----------------------------------------------------------------------------
;; 画面分割時に Shift + 矢印キー でウィンドウを移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; 日付を挿入
(global-set-key [f5] (lambda ()  (interactive) (insert (format-time-string "%Y/%m/%d %H:%M:%S"))))

;; 行末の空白を削除
(global-set-key [(meta f8)] (lambda () (interactive) (delete-trailing-whitespace)))

;; フォントの大きさを変更
(global-set-key [(control ?+)] (lambda () (interactive) (text-scale-increase 1)))
(global-set-key [(control ?-)] (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key [(control ?0)] (lambda () (interactive) (text-scale-set 0)))
(global-set-key [(control ?1)] (lambda () (interactive) (text-scale-set 1)))
(global-set-key [(control ?2)] (lambda () (interactive) (text-scale-set 2)))
(global-set-key [(control ?3)] (lambda () (interactive) (text-scale-set 3)))
(global-set-key [(control ?4)] (lambda () (interactive) (text-scale-set 4)))
(global-set-key [(control ?5)] (lambda () (interactive) (text-scale-set 5)))
(global-set-key [(control ?6)] (lambda () (interactive) (text-scale-set 6)))
(global-set-key [(control ?7)] (lambda () (interactive) (text-scale-set 7)))
(global-set-key [(control ?8)] (lambda () (interactive) (text-scale-set 8)))
(global-set-key [(control ?9)] (lambda () (interactive) (text-scale-set 9)))
(global-set-key [(control kp-add)] (lambda () (interactive) (text-scale-increase 1)))
(global-set-key [(control kp-subtract)] (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key [(control kp-0)] (lambda () (interactive) (text-scale-set 0)))
(global-set-key [(control kp-1)] (lambda () (interactive) (text-scale-set 1)))
(global-set-key [(control kp-2)] (lambda () (interactive) (text-scale-set 2)))
(global-set-key [(control kp-3)] (lambda () (interactive) (text-scale-set 3)))
(global-set-key [(control kp-4)] (lambda () (interactive) (text-scale-set 4)))
(global-set-key [(control kp-5)] (lambda () (interactive) (text-scale-set 5)))
(global-set-key [(control kp-6)] (lambda () (interactive) (text-scale-set 6)))
(global-set-key [(control kp-7)] (lambda () (interactive) (text-scale-set 7)))
(global-set-key [(control kp-8)] (lambda () (interactive) (text-scale-set 8)))
(global-set-key [(control kp-9)] (lambda () (interactive) (text-scale-set 9)))

;; ウィンドウの透明度を変更
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t, decrease the transparency, 
   otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha))
         (oldalpha (if alpha-or-nil alpha-or-nil 100))
         (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

(global-set-key [(control f11)] '(lambda () (interactive) (djcb-opacity-modify t)))  ; increase transparency
(global-set-key [(control f12)] '(lambda () (interactive) (djcb-opacity-modify)))    ; decrease transparency
(global-set-key [(control f10)] '(lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))
