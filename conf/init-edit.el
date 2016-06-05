(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; abbrev
;;;-----------------------------------------------------------------------------
(use-package abbrev
  :config
  (custom-set-variables
   `(abbrev-file-name ,(expand-file-name "abbrev_defs" my/setting-dir))))

;;;-----------------------------------------------------------------------------
;;; company
;;;-----------------------------------------------------------------------------
(use-package company
  :config
  (global-company-mode)
  (custom-set-variables
   '(company-idle-delay 0)
   '(company-minimum-prefix-length 2)
   '(company-selection-wrap-around t))
  (use-package readline-complete))

;;;-----------------------------------------------------------------------------
;;; auto-complete
;;;-----------------------------------------------------------------------------
;;(use-package auto-complete-config
;;  :config
;;  (ac-config-default)
;;  (setq ac-use-fuzzy t))

;;;-----------------------------------------------------------------------------
;;; migemo
;;;-----------------------------------------------------------------------------
(use-package migemo
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\g"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  ;; use cache
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1024)
  (setq migemo-coding-system 'utf-8)
  (load-library "migemo")
  (migemo-init))

;;;-----------------------------------------------------------------------------
;;; helm
;;;-----------------------------------------------------------------------------
(use-package helm-config
  :bind
  (("C-x C-r" . helm-recentf)
   ("C-x b"   . helm-buffers-list)
   ("C-h a"   . helm-apropos)
   ("C-x C-i" . helm-imenu)
   ("C-M-s"   . helm-occur)
   ("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)))

;;;-----------------------------------------------------------------------------
;;; popwin
;;;-----------------------------------------------------------------------------
(use-package popwin
  :config
  (setq display-buffer-function 'popwin:display-buffer))

;;;-----------------------------------------------------------------------------
;;; savekill
;;;-----------------------------------------------------------------------------
(use-package savekill
  :config
  (custom-set-variables
   `(save-kill-file-name ,(expand-file-name "kill-ring-saved.el" my/setting-dir))))

(require 'el-init)
(el-init-provide)