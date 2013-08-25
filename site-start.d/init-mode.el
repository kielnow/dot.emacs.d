;; highlight-indentation-mode
;(require 'highlight-indentation)
;(highlight-indentation-set-offset 4)
;;(set-face-background 'highlight-indentation-face "#1e292a")
;;(set-face-background 'highlight-indentation-current-column-face "#293739")
;;(add-hook 'c++-mode-hook 'highlight-indentation-mode)
;;(add-hook 'elixir-mode-hook 'highlight-indentation-mode)

;; c++-mode
(setq c-basic-offset 4)

;; objc-mode
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; hlsl-mode
(autoload 'hlsl-mode "hlsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.fx\\'" . hlsl-mode))

;; elixir-mode
(require 'elixir-mode)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(when nt-p
  (setq markdown-command "perl ~/.emacs.d/etc/Markdown_1.0.1/Markdown.pl")
  (setenv "LC_ALL" "C"))

;; tuareg-mode
(setq tuareg-support-metaocaml t)
;(setq tuareg-interactive-program "/usr/bin/ocaml")
;(setq tuareg-library-path "/usr/lib/ocaml")
