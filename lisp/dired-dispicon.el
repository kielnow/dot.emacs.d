;;; dired-dispicon.el --- dispicon & dropfile on dired

;; Author: Hideyuki SHIRAI <shirai@meadowy.org>
;;         Yuuichi Teranishi <teranisi@gohome.org>
;; Keywords: Windows, Icon

;; Copyright (C) 2005 Hideyuki SHIRAI <shirai@meadowy.org>
;;                    Yuuichi Teranishi <teranisi@gohome.org>

;; This file is not part of GNU Emacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;

;;; Commentary:
;;
;; Put following on your '.emacs' file.
;;
;; (autoload 'dired-dispicon-setup
;;           "dired-dispicon" "dispicon & dropfile on dired" t)
;; (add-hook 'dired-mode-hook
;;	  (lambda ()
;;	    (define-key dired-mode-map "\C-c\C-d" 'dired-dispicon)
;;	    (dired-dispicon-setup)))

;;; History:
;;
;; Appeared on Hideyuki SHIRAI's blog on June 2005.
;;

;;; Code:
(require 'dired)
(require 'dispicon)
(require 'dropfile)

(defcustom dired-dispicon-default-display-icon nil
  "*Non-nil forces display icon by default."
  :group 'dired
  :type 'boolean)

;; Buffer local variable.
(make-variable-buffer-local 'dired-dispicon-display-icon)
(defvar dired-dispicon-display-icon nil)

;; Icon cache.
(defvar dired-dispicon-icon-alist nil)
(defvar dired-dispicon-icon-alist-length 1024)

(defun dired-dispicon-setup ()
  "Setup function for `dired-dispicon'."
  (interactive)
  (setq dired-dispicon-display-icon dired-dispicon-default-display-icon)
  (jit-lock-register 'dired-dispicon-fontify-region))
 
(defun dired-dispicon-toggle (&optional args)
  "Toggle display icons.
If optional ARGS are non-nil, force display icons."
  (interactive "P")
  (when (eq major-mode 'dired-mode)
    (setq dired-dispicon-display-icon (or args
					  (not dired-dispicon-display-icon)))
    (message "Dired dispicon: %s" (if dired-dispicon-display-icon "ON" "off"))
    (revert-buffer)))
 
(defun dired-dispicon-font-lock (&optional beg end)
  "Font lock function for `dired-dispicon'.
A region specified by BEG and END is fontified."
  (let ((buffer-read-only nil)
	(inhibit-read-only t)
	(after-change-functions nil)
	(inhibit-point-motion-hooks t))
    (save-excursion
      (setq beg (or beg (point-min)))
      (setq end (or end (point-max)))
      (goto-char beg)
      (while (< (point) end)
	(condition-case nil
	    (when (dired-move-to-filename)
	      (unless (get-text-property (point) 'dropfile)
		(let ((beg (point))
		      end file map)
		  (add-text-properties
		   beg
		   (setq end (save-excursion
			       (dired-move-to-end-of-filename)
			       (point)))
		   '(mouse-face highlight
				help-echo
				"mouse-1: visit this file in other window"
				dropfile t))
		  (setq file (buffer-substring beg end)
			file (unix-to-dos-filename
			      (expand-file-name file dired-directory))
			map (make-sparse-keymap))
		  (define-key map [down-mouse-1] `(lambda ()
						    (interactive)
						    (dropfile ,file)))
		  (let ((ovl (make-overlay beg end)))
		    (if dired-dispicon-display-icon
			(overlay-put ovl 'before-string
				     (propertize
				      (dired-dispicon
				       file 'small
				       (aref (font-info
					      (face-font
					       'default (selected-frame)))
					     3))
				      'keymap map)))
		    (overlay-put ovl 'keymap map)
		    (overlay-put ovl 'evaporate t)))))
	  (error nil))
	(forward-line 1))
      (set-buffer-modified-p nil))))
 
(defun dired-dispicon (filename &optional type
				size depth bgcolor ignore-errors)
  "Wrapper function of `dispicon' which caches mini icons.
FILENAME, TYPE, SIZE, DEPTH, BGCOLOR, IGNORE-ERRORS are passed to `dispicon'."
  (let* ((name (downcase filename))
	 (nondir (file-name-nondirectory name))
	 ext iconkey icon)
    (setq type (or type dispicon-default-type))
    (setq size (or size dispicon-default-size))
    (cond
     ((or (file-directory-p filename)
	  (string= nondir ""))
      (setq ext "DIR"))
     ((or (not (string-match "\\." nondir))
	  (string-match "\\.$" nondir))
      (setq ext "TXT"))
     ((string-match "\\.\\([^.]+\\)$" nondir)
      (setq ext (match-string 1 nondir))
      (when (member ext '("bmp" "exe" "ico"))
	(setq ext name)))
     (t
      (setq ext "TXT")))
    (setq iconkey (format "%s:%s:%d" ext type size))
    (setq icon (cdr (assoc iconkey dired-dispicon-icon-alist)))
    (if icon
	(setq dired-dispicon-icon-alist
	      (delete (cons iconkey icon) dired-dispicon-icon-alist))
      (setq icon (dispicon (unix-to-dos-filename filename)
			   type size depth bgcolor ignore-errors)))
    (setq dired-dispicon-icon-alist
	  (cons (cons iconkey icon) dired-dispicon-icon-alist))
    (when (> (length dired-dispicon-icon-alist)
	     dired-dispicon-icon-alist-length)
      (setcdr (nthcdr (1- dired-dispicon-icon-alist-length)
		      dired-dispicon-icon-alist) nil))
    icon))
 
(defun dired-dispicon-fontify-region (&optional beg end)
  "A function for `jit-lock-register'.
A region specified by BEG and END is fontified."
  (let ((ddir (expand-file-name dired-directory)))
    (when (or (string-match "^[a-zA-Z]:" ddir)
	      (string-match "^//[^/]" ddir))
      (dired-dispicon-font-lock beg end))))

(provide 'dired-dispicon)

;;; dired-dispicon.el ends here
