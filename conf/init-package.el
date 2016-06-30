;;;-----------------------------------------------------------------------------
;;; package
;;;-----------------------------------------------------------------------------
(defvar my/packages
  '(el-init
	use-package
	bind-key
	el-get
	auto-install
	;;--------------------------------------------
	;; lib
	;; http://qiita.com/pogin503/items/01005402dc7cfd375b55
	;;--------------------------------------------
	dash
	dash-functional
	s
	f
	ht
	namespaces
	;;--------------------------------------------
	;; edit
	;;--------------------------------------------
	expand-region
	multiple-cursors
	color-moccur
	wgrep
	redo+
	undohist
	undo-tree
	point-undo
	fuzzy
	company
	readline-complete
	;;auto-complete
	;;ac-helm
	helm
	helm-company
	helm-c-moccur
	all-ext
	vlf
	savekill
	keyfreq
	recentf-ext
	sudo-edit
	;;--------------------------------------------
	;; eldoc
	;;--------------------------------------------
	eldoc-extension
	c-eldoc
	css-eldoc
	php-eldoc
	;;--------------------------------------------
	;; window
	;;--------------------------------------------
	elscreen
	popwin
	e2wm
	;;persp-mode
	;;window-number
	window-numbering
	;;switch-window
	;;win-switch
	owdriver
	hiwin
	;;windresize
	;;--------------------------------------------
	;; style
	;;--------------------------------------------
	theme-looper
	nyan-mode
	powerline
	minimap
	col-highlight
	rainbow-mode
	rainbow-delimiters
	highlight-symbol
	auto-highlight-symbol
	;;--------------------------------------------
	;; language
	;;--------------------------------------------
	quickrun
	markdown-mode
	glsl-mode
	shader-mode
	go-mode
	haskell-mode
	tuareg
	slime
	slime-company
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
  '(moccur-edit))

(my/package-install 'el-get)
(use-package el-get
  :init
  (set-variable 'el-get-dir (expand-file-name "el-get/" my/package-dir))
  :config
  (my/add-to-load-path el-get-dir)
  (use-package el-get-emacswiki)
  (unless (file-directory-p el-get-recipe-path-emacswiki)
	(el-get-emacswiki-build-local-recipes))
  (el-get 'sync my/el-get-packages))

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

;;;-----------------------------------------------------------------------------
;;; others
;;;-----------------------------------------------------------------------------
(require 'naruto)

(require 'el-init)
(el-init-provide)
