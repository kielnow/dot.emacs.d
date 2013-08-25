(defvar oldemacs-p (<= emacs-major-version 22))   ; 22 以下
(defvar emacs23-p  (<= emacs-major-version 23))   ; 23 以下
(defvar emacs24-p  (>= emacs-major-version 24))   ; 24 以上
(defvar linux-p    (eq system-type 'gnu/linux))   ; Linux
(defvar darwin-p   (eq system-type 'darwin))      ; Mac OS X
(defvar nt-p       (eq system-type 'windows-nt))  ; Windows
(defvar cygwin-p   (eq system-type 'cygwin))      ; Cygwin
(defvar meadow-p   (featurep 'meadow))            ; Meadow
(defvar windows-p  (or nt-p meadow-p cygwin-p))

;;-----------------------------------------------------------------------------
;; Common Lisp Extensions を有効に
(require 'cl)
;(eval-when-compile (require 'cl))

;;-----------------------------------------------------------------------------
;; load-path を設定
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "site-start.d" "elisp")

;;-----------------------------------------------------------------------------
(load "init-global")  ; 共通設定
(load "init-misc")
(load "init-style")   ; 見た目の設定
(load "init-key")     ; キーバインドの設定
(load "init-mode")    ; モードの設定
(load "init-util")

;;-----------------------------------------------------------------------------
;; パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
