;;;-----------------------------------------------------------------------------
;;; package
;;;-----------------------------------------------------------------------------
(defvar my/packages
  '(
	minimap
	theme-looper
	;;auto-complete
	bind-key
	col-highlight
	;;haskell-mode
	;;helm
	markdown-mode
	;;minimap
	nyan-mode
	powerline
	;;recentf-ext
	;;slime
	;;tuareg
	;;php-mode
	web-mode
	e2wm
	;;persp-mode
	;;w3m
	owdriver
	switch-window
	hiwin
	vlf
	;;auto-install
	;;init-loader
	))

(my/package-install-from-list my/packages)

;;;-----------------------------------------------------------------------------
;;; el-get
;;;-----------------------------------------------------------------------------
(defvar my/el-get-packages
  '())

(my/package-install 'el-get)
(use-package el-get
  :config
  (setq el-get-dir (expand-file-name my/package-dir))
  (setq my/el-get-recipe-dir (concat el-get-dir "recipes/"))
  (setq el-get-recipe-path-elpa (concat my/el-get-recipe-dir "elpa/"))
  (setq el-get-recipe-path-emacswiki (concat my/el-get-recipe-dir "emacswiki/"))
  (setq el-get-recipe-path (list my/el-get-recipe-dir el-get-recipe-path-elpa el-get-recipe-path-emacswiki))
  (require 'el-get-emacswiki))

(require 'el-init)
(el-init-provide)
