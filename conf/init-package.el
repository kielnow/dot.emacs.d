﻿;;;-----------------------------------------------------------------------------
;;; package
;;;-----------------------------------------------------------------------------
(defvar my/packages
  '(use-package
	el-init
	el-get
	auto-install
	bind-key
	;;--------------------------------------------
	;; lib
	;; http://qiita.com/pogin503/items/01005402dc7cfd375b55
	;;--------------------------------------------
	dash
	dash-functional
	s
	f
	ht
	;;--------------------------------------------
	;; edit
	;;--------------------------------------------
	fuzzy
	company
	;;auto-complete
	;;ac-helm
	helm
	helm-company
	vlf
	savekill
	keyfreq
	;;--------------------------------------------
	;; window
	;;--------------------------------------------
	popwin
	e2wm
	;;persp-mode
	owdriver
	switch-window
	hiwin
	;;recentf-ext
	;;--------------------------------------------
	;; style
	;;--------------------------------------------
	theme-looper
	nyan-mode
	powerline
	minimap
	col-highlight
	;;--------------------------------------------
	;; language
	;;--------------------------------------------
	quickrun
	markdown-mode
	glsl-mode
	shader-mode
	haskell-mode
	tuareg
	;;slime
	web-mode
	php-mode
	;;--------------------------------------------
	;; application
	;;--------------------------------------------
	migemo
	w3m
	twittering-mode
	))

(my/package-install-from-list my/packages)

;;;-----------------------------------------------------------------------------
;;; el-get
;;;-----------------------------------------------------------------------------
(defvar my/el-get-packages
  '())

(my/package-install 'el-get)
(use-package el-get
  :init
  (custom-set-variables `(el-get-dir ,(expand-file-name "el-get/" my/package-dir)))
  :config
  (use-package el-get-emacswiki))

;;;-----------------------------------------------------------------------------
;;; auto-install
;;;
;;; M-x install-elisp URL
;;; M-x install-elisp-from-emacswiki EmacsWikiのページ名
;;; M-x install-elisp-from-gist gist-id
;;;-----------------------------------------------------------------------------
;;(my/package-install 'auto-install)
;;(use-package auto-install
;;  :config
;;  (setq auto-install-directory (expand-file-name my/lisp-dir))
;;  (auto-install-compatibility-setup))

(require 'el-init)
(el-init-provide)
