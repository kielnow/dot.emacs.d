(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; eww
;;;-----------------------------------------------------------------------------
(use-package eww
  :commands (eww)
  :init
  (progn
	(defvar eww-disable-colorize t)
	(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
	  (unless eww-disable-colorize
		(funcall orig start end fg)))
	(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
	(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
	(defun eww-disable-color ()
	  (interactive)
	  (setq-local eww-disable-colorize t)
	  (eww-reload))
	(defun eww-enable-color ()
	  (interactive)
	  (setq-local eww-disable-colorize nil)
	  (eww-reload))
	;; 画像を非表示
	(defun shr-put-image-alt (spec alt &optional flags)
	  (insert alt))
	(defun eww-disable-image ()
	  (interactive)
	  (setq-local shr-put-image-function 'shr-put-image-alt)
	  (eww-reload))
	(defun eww-enable-image ()
	  (interactive)
	  (setq-local shr-put-image-function 'shr-put-image)
	  (eww-reload))
	;;(defun eww-mode-hook--disable-image ()
	;;	(setq-local shr-put-image-function 'shr-put-image-alt))
	;;(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)
	)
  :config
  (set-variable 'eww-search-prefix "http://www.google.co.jp/search?q=")
  (add-hook 'eww-mode-hook 'auto-highlight-symbol-mode))

;;;
;;; Emacs 使用中に素早く検索する
;;; http://qiita.com/akisute3@github/items/8deb54b75b48e8b04cb0
;;;

;;;-----------------------------------------------------------------------------
;;; twittering-mode
;;;-----------------------------------------------------------------------------
(use-package twit
  :commands (twit)
  :config
  (twittering-icon-mode 1))

(require 'el-init)
(el-init-provide)

