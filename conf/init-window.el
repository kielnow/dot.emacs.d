(require 'init-prelude)

;;;-----------------------------------------------------------------------------
;;; other-window-or-split
;;;-----------------------------------------------------------------------------
(defun my/other-window-or-split ()
  (interactive)
  (when (one-window-p)
	(split-window-vertically))
  (other-window 1))
(bind-key "C-o" 'my/other-window-or-split)
;;(bind-key "C-S-o" 'previous-multiframe-window)
(bind-key "C-S-o" 'switch-window-then-swap-buffer)

;;;-----------------------------------------------------------------------------
;;; switch-to-minibuffer-window
;;;-----------------------------------------------------------------------------
(defun my/switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window))))
(bind-key "<C-tab>" 'my/switch-to-minibuffer-window)

;;;-----------------------------------------------------------------------------
;;; windmove
;;;-----------------------------------------------------------------------------
(use-package windmove
  :bind
  (("M-J" . windmove-left)
   ("M-L" . windmove-right)
   ("M-I" . windmove-up)
   ("M-K" . windmove-down))
  :config
  ;; Shift + 矢印キー でウィンドウ切り替え
  (windmove-default-keybindings)
  (setq windmove-wrap-around t))

;;;-----------------------------------------------------------------------------
;;; windresize
;;;-----------------------------------------------------------------------------
(use-package windresize
  :bind
  (("C-M-S-j" . windresize-left-force-left)
   ("C-M-S-l" . windresize-right-force-left)
   ("C-M-S-i" . windresize-up-force-up)
   ("C-M-S-k" . windresize-down-force-up)
   ("C-M-S-b" . windresize-balance-windows))
  :config
  (setq windresize-increment 4)
  (set-variable 'windresize-move-borders t))

;;;-----------------------------------------------------------------------------
;;; window-number
;;;-----------------------------------------------------------------------------
;;(use-package window-number
;;  :config
;;  (window-number-mode))

;;;-----------------------------------------------------------------------------
;;; window-numbering
;;;-----------------------------------------------------------------------------
(use-package window-numbering
  :config
  (window-numbering-mode 1))

;;;-----------------------------------------------------------------------------
;;; ace-window
;;;-----------------------------------------------------------------------------
;;(use-package ace-window
;;  :bind
;;  (("C-x o" . ace-window))
;;  :config
;;  ;;(set-variable 'aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;;  )

;;;-----------------------------------------------------------------------------
;;; switch-window
;;;-----------------------------------------------------------------------------
;;(use-package switch-window
;;  :bind
;;  (("C-x o" . switch-window))
;;  :config
;;  (setq switch-window-shortcut-style 'qwerty))

;;;-----------------------------------------------------------------------------
;;; win-switch
;;;-----------------------------------------------------------------------------
;;(use-package win-switch
;;  :config
;;  (setq win-switch-idle-time 1.0)
;;  (win-switch-setup-keys-default (kbd "C-x o")))

;;;-----------------------------------------------------------------------------
;;; owdriver
;;;-----------------------------------------------------------------------------
(use-package owdriver
  :config
  (global-unset-key (kbd "M-m"))
  (setq owdriver-prefix-key "M-m")
  (owdriver-config-default)
  (owdriver-add-keymap owdriver-prefix-key 'owdriver-next-window)
  (owdriver-mode 1))

;;;-----------------------------------------------------------------------------
;;; elscreen
;;;-----------------------------------------------------------------------------
(use-package elscreen
  :config
  (elscreen-start)
  ;; タブの先頭に [X] を表示しない
  (set-variable 'elscreen-tab-display-kill-screen nil))

(require 'el-init)
(el-init-provide)