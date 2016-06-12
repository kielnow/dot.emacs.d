(require 'init-prelude)
(require 'bind-key)

;;;-----------------------------------------------------------------------------
;;; elscreen
;;;-----------------------------------------------------------------------------
(use-package elscreen
  :config
  (elscreen-start)
  ;; タブの先頭に [X] を表示しない
  (set-variable 'elscreen-tab-display-kill-screen nil))

;;;-----------------------------------------------------------------------------
;;; cua-mode
;;;
;;; C-RET     矩形編集
;;; C-RET M-n 連番入力
;;;-----------------------------------------------------------------------------
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;;-----------------------------------------------------------------------------
;;; expand-region
;;;-----------------------------------------------------------------------------
(use-package expand-region
  :bind
  (("C-@" . er/expand-region)
   ("C-M-@" . er/contract-region)))

;;;-----------------------------------------------------------------------------
;;; multiple-cursors
;;;-----------------------------------------------------------------------------
(use-package multiple-cursors
  :bind
  (("<C-M-return>" . mc/edit-lines)
   ("C-. C-n" . mc/mark-next-like-this)
   ("C-. C-p" . mc/mark-previous-like-this)
   ("C-. *" . mc/mark-all-like-this))
  :config
  (setq mc/list-file (expand-file-name ".mc-lists" my/setting-dir)))

;;;-----------------------------------------------------------------------------
;;; abbrev
;;;-----------------------------------------------------------------------------
(use-package abbrev
  :config
  (set-variable 'abbrev-file-name (expand-file-name "abbrev_defs" my/setting-dir)))

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
;;; occur
;;;
;;; *Occur* => e
;;;
;;; C-c C-c (occur-cease-edit) 編集終了
;;;-----------------------------------------------------------------------------

;;;-----------------------------------------------------------------------------
;;; color-moccur
;;;
;;; occur-by-moccur  カレントバッファに対してmoccur
;;; moccur           すべてのバッファに対してmoccur
;;; dmoccur          指定ディレクトリに対してmoccur
;;; moccur-grep      moccurを使ったgrep検索
;;; moccur-grep-find moccurを使ったgrep-find
;;;-----------------------------------------------------------------------------
(use-package color-moccur
  :bind
  (("M-o"   . occur-by-moccur)
   ("C-M-o" . moccur))
  :config
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のときに除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.*#$")
  ;; migemo
  (when (executable-find "cmigemo")
	(setq moccur-use-migemo t)))

;;;-----------------------------------------------------------------------------
;;; moccur-edit
;;; http://qiita.com/yewton/items/d16f17b9b7a474ed797c
;;;
;;; *Moccur* => r
;;;
;;; C-c C-c 編集反映
;;; C-c C-k 編集破棄
;;;-----------------------------------------------------------------------------
(use-package moccur-edit)

;;;-----------------------------------------------------------------------------
;;; wgrep
;;;
;;; *grep => C-c C-p (wgre-change-to-wgrep-mode)
;;;
;;; C-c C-c (wgrep-finish-edit)   編集反映
;;; C-c C-k (wgrep-abort-changes) 編集破棄
;;;-----------------------------------------------------------------------------
(use-package wgrep)

;;;-----------------------------------------------------------------------------
;;; wdird
;;;
;;; M-x dired => r
;;;
;;; C-c C-c 編集反映
;;; C-c C-k 編集破棄
;;;-----------------------------------------------------------------------------

;;;-----------------------------------------------------------------------------
;;; helm
;;;-----------------------------------------------------------------------------
(use-package helm-config
  :bind
  (("C-x C-f" . helm-find-files)
   ("C-x C-r" . helm-recentf)
   ("C-x b"   . helm-buffers-list)
   ("C-h a"   . helm-apropos)
   ("C-x C-i" . helm-imenu)
   ("C-M-s"   . helm-occur)
   ("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)
   :map isearch-mode-map
   ("C-o"     . helm-occur-from-isearch)))

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
  (set-variable 'save-kill-file-name (expand-file-name "kill-ring-saved.el" my/setting-dir)))

;;;-----------------------------------------------------------------------------
;;; redo+
;;;-----------------------------------------------------------------------------
(use-package redo+
  :bind
  (("C-?"   . redo)
   ("C-M-/" . redo))
  :config
  ;; undoがredoされないようにする
  (setq undo-no-redo t))

;;;-----------------------------------------------------------------------------
;;; undohist
;;;-----------------------------------------------------------------------------
(use-package undohist
  :config
  (customize-set-variable 'undohist-directory (expand-file-name "undohist/" my/temp-dir))
  (undohist-initialize))

;;;-----------------------------------------------------------------------------
;;; undo-tree
;;;-----------------------------------------------------------------------------
;;(use-package undo-tree
;;  :config
;;  (global-undo-tree-mode))

;;;-----------------------------------------------------------------------------
;;; point-undo
;;;-----------------------------------------------------------------------------
(use-package point-undo
  :bind
  (("M-[" . point-undo)
   ("M-]" . point-redo)))

;;;
;;; .emacs.dを散らかさない保存ファイルの場所を変更する設定まとめ
;;; http://qiita.com/ShingoFukuyama/items/19b02cd1679a6ea0bfdb
;;;

(require 'el-init)
(el-init-provide)