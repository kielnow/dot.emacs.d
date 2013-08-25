;; 起動時間を計測する（目標は 3000ms 以内）
(when (or emacs23-p emacs24-p)
  (defun message-startup-time ()
    (message "Emacs loaded in %dms"
             (/ (- (+ (third after-init-time)  (* 1000000 (second after-init-time)))
                   (+ (third before-init-time) (* 1000000 (second before-init-time))))
                1000)))
  (add-hook 'after-init-hook 'message-startup-time))

;; 終了時にバイトコンパイルする
(add-hook 'kill-emacs-query-functions
  (lambda ()
	(if (file-newer-than-file-p (expand-file-name "init.el" user-emacs-directory)
								(expand-file-name "init.elc" user-emacs-directory))
		(byte-compile-file (expand-file-name "init.el" user-emacs-directory) 0))
	(byte-recompile-directory (expand-file-name "init" user-emacs-directory) 0)))

;;-----------------------------------------------------------------------------
;; 描画が遅い問題の対応
(when emacs24-p
  (setq-default bidi-display-reordering nil
                bidi-paragraph-direction (quote left-to-right)))
