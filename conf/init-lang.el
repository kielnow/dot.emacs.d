(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; 言語設定
;;;-----------------------------------------------------------------------------
(set-language-environment "Japanese")

;; 今は不要らしい
;;(prefer-coding-system 'utf-8)
;;(set-default-coding-systems 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-terminal-coding-system 'utf-8)
;;(set-file-name-coding-system 'utf-8)

(cond (cygwin-p
	   (setq-default buffer-file-coding-system 'utf-8-dos)
	   (setq file-name-coding-system 'utf-8-dos)
	   (setq locale-coding-system 'utf-8-dos))
	  (nt-p
	   (setq-default buffer-file-coding-system 'utf-8-dos)
	   (setq file-name-coding-system 'cp932)
	   (setq locale-coding-system 'cp932))
	  (darwin-p
	   (setq-default buffer-file-coding-system 'utf-8-dos)
	   (require 'ucs-normalize)
	   (setq file-name-coding-system 'utf-8-hfs)
	   (setq locale-coding-system 'utf-8-hfs)
	   (add-hook 'shell-mode-hook '(lambda () (set-buffer-process-coding-system 'utf-8-hfs 'utf-8-hfs))))
	  (t
	   (setq-default buffer-file-coding-system 'utf-8-dos)
	   (setq file-name-coding-system 'utf-8)
	   (setq locale-coding-system 'utf-8)
	   (add-hook 'shell-mode-hook '(lambda () (set-buffer-process-coding-system 'utf-8 'utf-8)))))

;;; ファイルの種類ごとに文字コードを指定
(modify-coding-system-alist 'file "\\.el\\'" 	'utf-8)
(modify-coding-system-alist 'file "\\.h\\'" 	'utf-8-with-signature)
(modify-coding-system-alist 'file "\\.cpp\\'" 	'utf-8-with-signature)
(modify-coding-system-alist 'file "\\.java\\'" 	'utf-8)

;;;-----------------------------------------------------------------------------
;;; East Asian Ambiguous Width 問題の修正ロケール
;;; https://github.com/hamano/locale-eaw
;;;-----------------------------------------------------------------------------
(use-package eaw
  :config
  (eaw-fullwidth))

(require 'el-init)
(el-init-provide)