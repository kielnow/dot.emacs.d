(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; 表示設定
;;;-----------------------------------------------------------------------------
;; 起動画面を抑制
(setq inhibit-startup-message t)

;; タイトルバーにバッファ名を表示
(setq frame-title-format '("%b - " invocation-name emacs-version "@" system-name))

;; ツールバーを消す
(tool-bar-mode 0)
;; メニューバーを消す
(menu-bar-mode 0)
;; スクロールバーを消す
;;(scroll-bar-mode 0)

;; 行番号をモードラインに表示
(setq line-number-mode t)
;; 列番号をモードラインに表示
(setq column-number-mode t)
;; ファイルサイズをモードラインに表示
(setq size-indication-mode t)
;; 現在の関数名をモードラインに表示
;;(which-function-mode 1)
;; 時間をモードラインに表示
(setq display-time-string-forms '((format "%s/%s(%s)%s:%s" month day dayname 24-hours minutes)))
(display-time)

;; 選択リージョンをハイライト
(setq transient-mark-mode t)

;; 対応する括弧をハイライト
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)

;; linum-mode
(global-linum-mode 1)
(setq linum-format "%5d")

;; hl-line-mode
(global-hl-line-mode 1)

;;;-----------------------------------------------------------------------------
;;; 操作設定
;;;-----------------------------------------------------------------------------
;; (yes/no) を (y/n) に
(fset 'yes-or-no-p 'y-or-n-p)

;; 補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; ファイル名の補間で大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)
;; バッファ名の補間で大文字小文字を区別しない
(setq read-buffer-completion-ignore-case t)

;; 論理行移動に
(setq line-move-visual nil)

;; バッファ名が同一の場合にディレクトリ名を付加
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(icomplete-mode 1)

;; バッファ切り替えでインクリメンタル補完を使う
(iswitchb-mode 1)
;; C-f, C-b, C-n, C-p で候補を切り替えられるように
(add-hook 'iswitchb-define-mode-map-hook
		  (lambda ()
			(define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
			(define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
			(define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
			(define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)))

;; カレントディレクトリ設定
(cd "~")
;; OS のクリップボードを使う
(setq x-select-enable-clipboard t)
;; ゴミ箱を使う
(setq delete-by-moving-to-trash t)

;; ロックファイルを作成しない
(setq create-lockfiles nil)
;; 変更があったファイルを自動再読み込み
;;(global-auto-revert-mode 1)
;; シンボリックリンクをたどる
;;(setq vc-follow-symlink t)

;; スクリプト保存時に実行属性を付ける
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; .el ファイル保存時に .elc ファイルを削除する
(defun my/remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
			(lambda ()
			  (if (file-exists-p (concat buffer-file-name "c"))
				  (delete-file (concat buffer-file-name "c"))))
			nil t))
(add-hook 'emacs-lisp-mode-hook 'my/remove-elc-on-save)

;;;-----------------------------------------------------------------------------
;;; 編集設定
;;;-----------------------------------------------------------------------------
;; タブ幅を 4 に
(setq-default tab-width 4)
;; インデントはタブを使う
(setq-default indent-tabs-mode t)

;; 行末の無駄な空白を削除する
(defvar my/delete-trailing-whitespace-exclude-suffix
  (list "\\.rd$" "\\.md$" "\\.rbt$" "\\.rab$"))
(defun my/delete-trailing-whitespace ()
  (interactive)
  (cond
   ((equal nil
           (loop for pattern in my/delete-trailing-whitespace-exclude-suffix
                 thereis (string-match pattern buffer-file-name)))
    (delete-trailing-whitespace))))
;;(add-hook 'before-save-hook 'my/delete-trailing-whitespace)

;; ファイル末尾に自動的に改行を入れない
(setq-default mode-require-final-newline nil)
(setq-default require-final-newline nil)
;; バッファ終端で次の行に移動したときに自動的に改行しない
(setq-default next-line-add-newlines nil)

;; 区切り文字に全角スペースや・などを含める
(setq paragraph-start '"^\\([ 　・■◆●□◇○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

;; kill-line で改行も切り取る
;;(setq kill-whole-line t)
;; リージョン選択時に文字を入力するとリージョンを削除する
;;(delete-selection-mode t)

;;;-----------------------------------------------------------------------------
;;; オートセーブ #foo.txt"
;;;
;;; 復元方法 M-x recover-file RET ファイル名 RET
;;;-----------------------------------------------------------------------------
;; オートセーブしない
;;(setq auto-save-default nil)
;; オートセーブファイルの保存先
(setq auto-save-list-file-prefix (expand-file-name ".saves-" my/temp-dir))
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name my/temp-dir) t)))
(setq temporary-file-directory my/temp-dir)
;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-file t)
;; オートセーブする間隔
(setq auto-save-timeout 15)
(setq auto-save-interval 60)

;;;-----------------------------------------------------------------------------
;;; バックアップ foo.txt~
;;;-----------------------------------------------------------------------------
;; バックアップしない
;;(setq make-backup-files nil)
;; バックアップファイルの保存先
(setq backup-directory-alist `((".*" . ,my/temp-dir)))
;; バックアップをバージョン管理する
(setq version-control t)
(setq kept-new-versions 4)
(setq kept-old-versions 4)
(setq delete-old-versions t)

;;;-----------------------------------------------------------------------------
;;; *scratch* バッファ
;;;-----------------------------------------------------------------------------
;; *scratch* バッファの初期メッセージを消す
(setq initial-scratch-message "")

;; *scratch* バッファを kill させない
(defun my/create-scratch (&optional arg)
  (interactive)
  (progn
    ;; *scratch* バッファを作成して buffer-list に追加する
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created.")))))

;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
(add-hook 'kill-buffer-query-functions
		  (lambda () (if (string= "*scratch*" (buffer-name))
						 (progn (my/create-scratch 0) nil) t)))

;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
(add-hook 'after-save-hook
		  (lambda () (unless (member (get-buffer "*scratch*") (buffer-list))
					   (my/create-scratch 1))))

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

;; ファイルの種類ごとに文字コードを指定
(modify-coding-system-alist 'file "\\.el\\'" 	'utf-8-with-signature)
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

;;;-----------------------------------------------------------------------------
;;; その他
;;;-----------------------------------------------------------------------------
;; for improving performance
(unless emacs23-p
  (setq-default bidi-display-reordering nil))

;;;-----------------------------------------------------------------------------
;;; Large file
;;;-----------------------------------------------------------------------------
(defvar my/large-file-threshould (* 1024 1024))
(defun my/find-file-hook ()
  "If a file is over a given size, make the buffer read only"
  (when (> (buffer-size) my/large-file-threshould)
	(message "(Large file)")
	;; make the buffer read only
	;;(setq buffer-read-only t)
	;;(buffer-disable-undo)
	(fundamental-mode)
	;;(linum-mode 0)
	(font-lock-mode 0)))
(add-hook 'find-file-hook 'my/find-file-hook)

(require 'el-init)
(el-init-provide)