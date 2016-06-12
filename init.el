;;;-----------------------------------------------------------------------------
;;; Start
;;;-----------------------------------------------------------------------------
;; suppressing GC to improve the initialization time
(setq gc-cons-threshold (* 1024 1024 1024))

;; emacs -q -l init.el
(when load-file-name
  (setq user-init-file (concat (file-name-sans-extension load-file-name) ".el"))
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;;-----------------------------------------------------------------------------
;;; Configuration
;;;-----------------------------------------------------------------------------
;; directories
(defconst my/init-dir    (locate-user-emacs-file "conf/"))
(defconst my/lisp-dir    (locate-user-emacs-file "lisp/"))
(defconst my/package-dir (locate-user-emacs-file "packages/"))
(defconst my/setting-dir (locate-user-emacs-file "etc/"))
(defconst my/temp-dir    (locate-user-emacs-file "tmp/"))

;; ベンチマークを取るかどうか
(defconst my/benchmark-p t)
;; .emacs.d 編集用
(defconst my/user-emacs-editing-p t)
;; 実験用
(defconst my/experimental-p t)

;;;-----------------------------------------------------------------------------
;;; load-path
;;;-----------------------------------------------------------------------------
(defun my/add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths)
      (when (file-directory-p path)
        (let ((default-directory path))
          (add-to-list 'load-path default-directory)
          (normal-top-level-add-subdirs-to-load-path))))))

(my/add-to-load-path my/init-dir
                     my/lisp-dir)

;; *.el と *.elc の新しいほうを読み込む
(when (boundp 'load-prefer-newer) (setq load-prefer-newer t))

;;;-----------------------------------------------------------------------------
;;; package
;;;-----------------------------------------------------------------------------
(require 'package)
(setq package-user-dir (expand-file-name "elpa/" my/package-dir))

;; repositories
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(defvar my/-package-refresh-contents-p nil)
(defun my/package-refresh-contents-once ()
  (unless my/-package-refresh-contents-p
    (setq my/-package-refresh-contents-p t)
    (package-refresh-contents)))
(defun my/package-install (pkg)
  (unless (package-installed-p pkg)
    (my/package-refresh-contents-once)
    (package-install pkg)))
(defun my/package-install-from-list (pkgs)
  (dolist (pkg pkgs) (my/package-install pkg)))

;;;-----------------------------------------------------------------------------
;;; use-package
;;;-----------------------------------------------------------------------------
(my/package-install 'use-package)
(require 'use-package)

;;;-----------------------------------------------------------------------------
;;; bind-key
;;;-----------------------------------------------------------------------------
(my/package-install 'bind-key)
(require 'bind-key)

;;;-----------------------------------------------------------------------------
;;; benchmark-init
;;;-----------------------------------------------------------------------------
(when my/benchmark-p
  (my/package-install 'benchmark-init)
  (require benchmark-init))

;;;-----------------------------------------------------------------------------
;;; el-init
;;;-----------------------------------------------------------------------------
(my/package-install 'el-init)
(my/package-install 'el-init-viewer)
(el-init-load my/init-dir
			  :subdirectories '(".")
              :wrappers (if my/user-emacs-editing-p
                            '(el-init-require/record-error el-init-require/benchmark)
                          '(el-init-require/record-error)))

;;;-----------------------------------------------------------------------------
;;; Cleanup
;;;-----------------------------------------------------------------------------
(setq gc-cons-threshold (* 16 1024 1024))

(when my/benchmark-p
  (benchmark-init/deactivate))

(when my/user-emacs-editing-p
  ;;(switch-to-buffer (get-buffer "*Messages*"))
  ;;(cd user-emacs-directory)
  (benchmark-init/show-durations-tree)
  ;;(benchmark-init/show-durations-tabulated)
  (el-init-viewer))

