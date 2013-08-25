;; dmacro
;; 2回同じ操作をすると自動でマクロ登録
(defconst *dmacro-key* "\C-^")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;; 変更箇所に色を付ける
(global-highlight-changes-mode t)
(add-hook 'write-file-hooks 'highlight-changes-rotate-faces)
;; デフォルトでは非表示
;;  highlight-changes-visible-mode で表示する
(setq highlight-changes-visibility-initial-state nil)
(global-set-key (kbd "M-]") 'highlight-changes-next-change)
(global-set-key (kbd "M-[") 'highlight-changes-previous-change)

;; w3m
(autoload 'w3m "w3m" "Interface for w3m on Emacs" t)
(setq w3m-home-page "http://google.com/")
(add-hook 'w3m-mode-hook (function (lambda () (progn (global-linum-mode 0)))))
