;;;-----------------------------------------------------------------------------
;;; Environment variables
;;;-----------------------------------------------------------------------------
;; major version
(defconst emacs23-p (= emacs-major-version 23))
(defconst emacs24-p (= emacs-major-version 24))

;; platform
(defconst linux-p   (eq system-type 'gnu/linux))
(defconst darwin-p  (eq system-type 'darwin))
(defconst nt-p      (eq system-type 'windows-nt))
(defconst cygwin-p  (eq system-type 'cygwin))
(defconst meadow-p  (featurep 'meadow))
(defconst windows-p (or nt-p cygwin-p meadow-p))

;;;-----------------------------------------------------------------------------
;;; Common Lisp extensions
;;;-----------------------------------------------------------------------------
(unless (require 'cl-lib nil 'noerror) (require 'cl))
;;(require 'cl)

;;;-----------------------------------------------------------------------------
;;; Show environment information
;;;-----------------------------------------------------------------------------
(defun my/message-emacs-environment ()
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
	  ;;,(format "meadow-p             = %s" meadow-p)
	  "-----------------------------------------------------------------------------")
	"\n")))

(when my/user-emacs-editing-p
  (my/message-emacs-environment))

;;;-----------------------------------------------------------------------------
;;; 起動時間を表示
;;;-----------------------------------------------------------------------------
(defun my/message-emacs-init-time ()
  (interactive)
  (let ((elapsed (float-time (time-subtract after-init-time before-init-time))))
	(message "Emacs initialized in %.3f milliseconds" (* 1000 elapsed))))

(add-hook 'after-init-hook 'my/message-emacs-init-time)

;;;-----------------------------------------------------------------------------
;;; 終了時にバイトコンパイルする
;;;
;;; 手動でバイトコンパイルする場合 C-u 0 M-x byte-recomile-directory ディレクトリ名 RET
;;;-----------------------------------------------------------------------------
(defun my/byte-recompile-file (filename)
  (interactive "fByte recompile file: ")
  (if (file-newer-than-file-p filename (concat filename "c"))
	  (byte-compile-file filename) t))

(defun my/byte-recompile-directory (directory)
  (if (file-directory-p directory)
	  (byte-recompile-directory directory 0) t))

(defun byte-recompile-init-files ()
  "Recompile all the init files."
  (interactive)
  (my/byte-recompile-file user-init-file)
  (my/byte-recompile-directory my/init-dir)
  (my/byte-recompile-directory my/lisp-dir)
  t)

(unless nil;;my/user-emacs-editing-p
  (add-hook 'kill-emacs-query-functions 'byte-recompile-init-files))

;; 再初期化
(defun reinitialize ()
  "Reinitialize Emacs."
  (interactive)
  (unless my/user-emacs-editing-p
	(byte-recompile-init-files))
  (load-file user-init-file))

;;;-----------------------------------------------------------------------------
;;; Platform dependent settings
;;;-----------------------------------------------------------------------------
(when windows-p
  (defun w32-maximize-window ()
	(interactive)
	(w32-send-sys-command ?\xF030))
  (defun w32-restore-window ()
	(interactive)
	(w32-send-sys-command ?\xF120))
  (defvar w32-window-fullscreen-p nil)
  (defun w32-toggle-window-fullscreen ()
	(interactive)
	(if w32-window-fullscreen-p (w32-restore-window) (w32-maximize-window))
	(setq w32-window-fullscreen-p (not w32-window-fullscreen-p))))

;;;-----------------------------------------------------------------------------
;;; Prelude
;;;-----------------------------------------------------------------------------
(require 'init-package)

(require 'el-init)
(el-init-provide)
