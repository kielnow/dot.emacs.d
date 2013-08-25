;; 初期ディレクトリを設定
(cd "~")

;;-----------------------------------------------------------------------------
;; 使用する言語環境
(set-language-environment "Japanese")
;; 開く場合に優先する文字コード
(prefer-coding-system 'utf-8-unix)
;; デフォルトで使用する文字コード
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;; キーボードから入力される文字コード
(set-keyboard-coding-system 'utf-8)
;; ターミナルの文字コード
(set-terminal-coding-system 'utf-8)
;; ファイル名の文字コード
(setq file-name-coding-system 'utf-8)

;;-----------------------------------------------------------------------------
;; IMEを設定
(when linux-p
  (require 'scim-bridge)
  (add-hook 'after-init-hook 'scim-mode-on)
  (scim-define-common-key 'zenkaku-hankaku t)
  (setq scim-mode-local nil)
  ;; SCIM が ON のときにカーソル色を変更
  (setq scim-cursor-color "red")
)

;; OSのクリップボードを使う
(setq x-select-enable-clipboard t)

;;-----------------------------------------------------------------------------
;; 起動画面を抑制
(setq inhibit-startup-message t)
;; ツールバーを消す
(tool-bar-mode 0)
(menu-bar-mode 0)
;; 行番号と列番号をモードラインに表示
(setq line-number-mode t)
(setq column-number-mode t)
;; 対応する括弧をハイライト
(show-paren-mode 1)

;;-----------------------------------------------------------------------------
;; バックアップファイルを無効に
(setq backup-inhibited t)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-file t)

;; (yes/no) を (y/n) に
(fset 'yes-or-no-p 'y-or-n-p)

;;-----------------------------------------------------------------------------
;; タブ幅を4に
(setq-default tab-width 4)
;; タブをスペースに
;(setq-default indent-tabs-mode nil)
;; 区切り文字に全角スペースや・を含める
(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

;; 全角スペース、タブ、改行、行末の空白を可視化
(setq whitespace-style
  '(tabs tab-mark
    spaces space-mark
    ;trailing
    ;newline newline-mark
    face))
(setq whitespace-space-regexp "\\([\x3000]+\\)")
;(setq whitespace-space-regexp "\\([\x0020\x3000]+\\)")
(setq whitespace-display-mappings
  '((space-mark   ?\x3000 [?\□])
    ;(space-mark   ?\x0020 [?\xB7])
    (tab-mark     ?\t     [?\xBB ?\t])
    ;(newline-mark ?\n     [?\xAB ?\n])
    ;(newline-mark ?\n     [?\x2936 ?\n])
    (newline-mark ?\n      [?\x21B5 ?\n])
  ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "cyan")
(set-face-background 'whitespace-space nil)
(set-face-foreground 'whitespace-tab "cyan")
(set-face-background 'whitespace-tab nil)
(set-face-foreground 'whitespace-newline "cyan")
(set-face-background 'whitespace-newline nil)
;(set-face-underline  'whitespace-trailing t)
(set-face-foreground 'whitespace-trailing nil)
(set-face-background 'whitespace-trailing "cyan")
;; 行末の空白を表示
;(setq-default show-trailing-whitespace t)
;(set-face-background 'trailing-whitespace "cyan")
;; EOB を表示
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

;;-----------------------------------------------------------------------------
;; find-fileのファイル名補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; バッファ名が同一の場合にディレクトリ名を追加
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; バッファ切り替えを使いやすく
;; iswitchb は、バッファ名の一部の文字を入力することで、選択バッファの絞り込みを行う機能を実現します。
;; バッファ名を先頭から入力する必要はなく、とても使いやすくなります。
(iswitchb-mode 1) ;;iswitchbモードON
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
  (lambda ()
    (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
    (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
    (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
	(define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;;-----------------------------------------------------------------------------
;; *scratch* バッファの初期メッセージを消す
(setq initial-scratch-message "")

;; *scratch* バッファを kill させない
(defun my-make-scratch (&optional arg)
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
				 (progn (my-make-scratch 0) nil) t)))

;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
(add-hook 'after-save-hook
  (lambda () (unless (member (get-buffer "*scratch*") (buffer-list))
			   (my-make-scratch 1))))
