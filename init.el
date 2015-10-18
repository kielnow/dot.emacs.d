;;; -----------------------------------------------------------------------------
;;; Start
;;; -----------------------------------------------------------------------------
;; for improving emacs init time
(setq gc-cons-threshold (* 1024 1024 1024))

;; emacs -q -l init.el
(when load-file-name
  (setq user-init-file (concat (file-name-sans-extension load-file-name) ".el"))
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; -----------------------------------------------------------------------------
;;; 定数
;;; -----------------------------------------------------------------------------
(defconst my:init-dir    (locate-user-emacs-file "inits/"))
(defconst my:lisp-dir    (locate-user-emacs-file "lisp/"))
(defconst my:lispver-dir (locate-user-emacs-file (format "lisp%d/" emacs-major-version)))
(defconst my:package-dir (locate-user-emacs-file "packages/"))
(defconst my:temp-dir    (locate-user-emacs-file "tmp/"))

(defconst emacs23-p (= emacs-major-version 23))
(defconst emacs24-p (= emacs-major-version 24))
(defconst linux-p   (eq system-type 'gnu/linux))
(defconst darwin-p  (eq system-type 'darwin))
(defconst nt-p      (eq system-type 'windows-nt))
(defconst cygwin-p  (eq system-type 'cygwin))
(defconst meadow-p  (featurep 'meadow))
(defconst windows-p (or nt-p cygwin-p meadow-p))

;; .emacs.d 編集用
(defconst my:user-emacs-editing-p t)
(defconst my:experimental-p t)

;;; -----------------------------------------------------------------------------
;;; load-path
;;; -----------------------------------------------------------------------------
(defun my:add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths)
      (when (file-directory-p path)
		(let ((default-directory path))
		  (add-to-list 'load-path default-directory)
		  (normal-top-level-add-subdirs-to-load-path))))))

(my:add-to-load-path
   my:init-dir
   my:lisp-dir
   my:lispver-dir)

;;; -----------------------------------------------------------------------------
;;; init
;;; -----------------------------------------------------------------------------
;; .elc と .el のタイムスタンプを比較して新しいほうを読み込む
(when (boundp 'load-prefer-newer) (setq load-prefer-newer t))

(load "init-prelude")
(load "init-global")
(load "init-key")
(load "init-style")

;;; -----------------------------------------------------------------------------
;;; Cleanup
;;; -----------------------------------------------------------------------------
(setq gc-cons-threshold (* 8 1024 1024))

(when my:user-emacs-editing-p
  (switch-to-buffer (get-buffer "*Messages*")))

;;; -----------------------------------------------------------------------------
;;; End
;;; -----------------------------------------------------------------------------
