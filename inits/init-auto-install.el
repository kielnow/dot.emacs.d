;;; -----------------------------------------------------------------------------
;;; auto-install
;;;
;;; M-x install-elisp URL
;;; M-x install-elisp-from-emacswiki EmacsWikiのページ名
;;; M-x install-elisp-from-gist gist-id
;;; -----------------------------------------------------------------------------
(require 'auto-install)
(setq auto-install-directory (expand-file-name my:lisp-dir))
(auto-install-compatibility-setup)
