(require 'init-prelude)

;;;
;;; M-x info Ret => Elisp => Standar Hooks
;;;

;;;-----------------------------------------------------------------------------
;;; eldoc
;;;-----------------------------------------------------------------------------
(use-package eldoc-extension)
(setq eldoc-idle-delay 0.2)
(setq eldoc-echo-area-use-multiline-p t)
;; M-: (eval-expression)
(add-hook 'eval-expression-minibuffer-setup-hook 'eldoc-mode)

;;;-----------------------------------------------------------------------------
;;; emacs-lisp-mode
;;;-----------------------------------------------------------------------------
(defun my/emacs-lisp-mode-hook ()
  (lambda () (turn-on-eldoc-mode)))
(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-mode-hook)

;;;-----------------------------------------------------------------------------
;;; cc-mode
;;;-----------------------------------------------------------------------------
(add-hook 'c-mode-common-hook (lambda () (c-set-style "stroustrup")))

;;;-----------------------------------------------------------------------------
;;; hlsl-mode
;;;-----------------------------------------------------------------------------
(use-package hlsl-mode)

;;;-----------------------------------------------------------------------------
;;; slime
;;;-----------------------------------------------------------------------------
(use-package slime
  :init
  (setq inferior-lisp-program "sbcl --noinform")
  (when cygwin-p
	(setq slime-to-lisp-filename-function 'cygwin-convert-file-name-to-windows)
	(setq slime-from-lisp-filename-function 'cygwin-convert-file-name-from-windows))
  :config
  (slime-setup '(slime-fancy slime-company slime-banner)))

;;;-----------------------------------------------------------------------------
;;; web-mode
;;;-----------------------------------------------------------------------------
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\(\\.php\\)?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (defun my:web-mode-hook ()
	(setq web-mode-markup-indent-offset 2)
	(setq web-mode-css-indent-offset    2)
	(setq web-mode-code-indent-offset   2)
	(setq indent-tabs-mode nil)
	(setq tab-width 2)
	(rainbow-mode 1))
  (add-hook 'web-mode-hook 'my:web-mode-hook)
  ;; C-c C-n   (web-mode-navigate)
  ;; C-c C-e / (web-mode-element-close)
  ;; C-c C-e s (web-mode-block-select)
  )

;;;-----------------------------------------------------------------------------
;;; js-mode
;;;-----------------------------------------------------------------------------
(setq js-indent-level 2)
(defun my:js-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'js-mode-hook 'my:js-mode-hook)

;;;-----------------------------------------------------------------------------
;;; php-mode
;;;-----------------------------------------------------------------------------
(use-package php-mode
  :config
  (defun my/php-mode-hook ()
	(setq c-basic-offset 2)
	(setq indent-tabs-mode nil)
	(setq tab-width 2))
  (add-hook 'php-mode-hook 'my/php-mode-hook))

;;;-----------------------------------------------------------------------------
;;; e2wm
;;;-----------------------------------------------------------------------------
(use-package e2wm
  :config
  ;;(setq e2wm:prefix-key "C-c ;")
  ;; 終了する場合は C-c ; Q
  (bind-key "M-+" 'e2wm:start-management)
  (e2wm:add-keymap
   e2wm:pst-minor-mode-keymap
   '(("<M-left>"  . e2wm:dp-code)
	 ("<M-right>" . e2wm:dp-two)
	 ("<M-up>"    . e2wm:dp-doc)
	 ("<M-down>"  . e2wm:dp-dashboard)
	 ("C-."       . e2wm:pst-history-forward-command)
	 ("C-,"       . e2wm:pst-history-back-command)
	 ("prefix L"  . ielm)  ; C-c ; L
	 ("M-m"       . e2wm:pst-window-select-main-command)
	 ) e2wm:prefix-key))

;;;-----------------------------------------------------------------------------
;;; twittering-mode
;;;-----------------------------------------------------------------------------
(use-package twittering-mode
  :defer t
  :config
  (twittering-icon-mode 1))

;;;-----------------------------------------------------------------------------
;;; persp-mode
;;;-----------------------------------------------------------------------------
;;(require 'persp-mode)
;;(setq persp-keymap-prefix (kbd "C-c p"))
;;(setq persp-add-on-switch-or-display t)
;;(persp-mode 1)
;; C-c p s (persp-switch)
;; C-c p k (persp-kill)

(require 'el-init)
(el-init-provide)