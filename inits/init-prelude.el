;;; -----------------------------------------------------------------------------
;;; 環境を表示
;;; -----------------------------------------------------------------------------
(defun my:message-emacs-environment ()
  (interactive)
  (message
   (mapconcat
	'identity
	`("-----------------------------------------------------------------------------"
	  ,(format "user-init-file       = %s" user-init-file)
	  ,(format "user-emacs-directory = %s" user-emacs-directory)
	  ,(format "emacs-version        = %s" emacs-version)
	  ,(format "system-type          = %s" system-type)
	  ,(format "window-system        = %s" window-system)
	  ,(format "meadow-p             = %s" meadow-p)
	  "-----------------------------------------------------------------------------")
	"\n")))

(when my:user-emacs-editing-p
  (my:message-emacs-environment))

;;; -----------------------------------------------------------------------------
;;; パッケージ管理
;;; -----------------------------------------------------------------------------
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq package-user-dir (expand-file-name "elpa" my:package-dir))

(package-initialize)

;; require-package
(defvar my:-package-refresh-contents-p nil)
(defun my:-package-refresh-contents-once ()
  (unless my:-package-refresh-contents-p
    (setq my:-package-refresh-contents-p t)
    (package-refresh-contents)))
(defun require-package (feature)
  (unless (package-installed-p feature)
    (my:-package-refresh-contents-once)
    (package-install feature))
  (require feature))

;;; -----------------------------------------------------------------------------
;;; Common Lisp Extensions
;;; -----------------------------------------------------------------------------
;(unless (require 'cl-lib nil 'noerror) (require 'cl))
(require 'cl)

;;; -----------------------------------------------------------------------------
;;; 起動時間を表示
;;; -----------------------------------------------------------------------------
(defun my:message-emacs-init-time ()
  (interactive)
  (let ((elapsed (float-time (time-subtract after-init-time before-init-time))))
	(message "Emacs initialized in %.3f milliseconds" (* 1000 elapsed))))

(add-hook 'after-init-hook 'my:message-emacs-init-time)

;;; -----------------------------------------------------------------------------
;;; 終了時にバイトコンパイル
;;;
;;; 手動でバイトコンパイルする場合 C-u 0 M-x byte-recomile-directory ディレクトリ名 RET
;;; -----------------------------------------------------------------------------
(unless (fboundp 'byte-recompile-file)
  (defun byte-recompile-file (filename)
	(if (file-newer-than-file-p filename (concat filename "c"))
		(byte-compile-file filename) t)))

(defun my:byte-recompile-directory (dirname)
  (if (file-directory-p dirname)
	  (byte-recompile-directory dirname 0) t))

(defun byte-recompile-init-files ()
  "Recompile all your init files."
  (interactive)
  (byte-recompile-file user-init-file)
  (my:byte-recompile-directory my:init-dir)
  (my:byte-recompile-directory my:lisp-dir)
  (my:byte-recompile-directory my:lispver-dir)
  t)

(unless my:user-emacs-editing-p
  (add-hook 'kill-emacs-query-functions 'byte-recompile-init-files))

;;; -----------------------------------------------------------------------------
;;; 再初期化
;;; -----------------------------------------------------------------------------
(defun reinitialize ()
  "Reinitialize Emacs."
  (interactive)
  (unless my:user-emacs-editing-p
	(byte-recompile-init-files))
  (load-file user-init-file))
