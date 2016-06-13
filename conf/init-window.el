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
  :config
  ;; Shift + 矢印キー でウィンドウ切り替え
  (windmove-default-keybindings)
  (setq windmove-wrap-around t))

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
;;; switch-window
;;;-----------------------------------------------------------------------------
;;(use-package switch-window
;;  :bind
;;  (("C-x o" . switch-window))
;;  :config
;;  (setq switch-window-shortcut-style 'qwerty))

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