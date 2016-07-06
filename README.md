# .emacs.d

## Policy

- 分割した設定ファイルは `el-init` で読み込む
- パッケージ管理は基本的に `package` で行う
- `package` に登録されていないものだけ `el-get` で管理する
- `use-package` を全面的に使用する
- `bind-key` を全面的に使用する
- カスタム変数の設定には `set-variable` もしくは `custom-set-variables` を使用する

## Features

- 編集系
  - `cua-rectangle-mark-mode`
  - `expand-region`
  - `multiple-cursors`
  - `wgrep`
  - `migemo`
  - 一括編集
    - [x] `color-moccur`, `moccur-edit`
    - [ ] `occur`
    - [ ] `all`, `all-ext`
- 操作系
  - `icomplete`
  - `helm`
  - `helm-swoop`
  - `helm-migemo`
  - `redo+`
  - [ ] `undo-tree`
  - [ ] `point-undo`
  - `goto-chg`
  - ポップアップ
    - [x] `company`
    - [ ] `auto-complete`
- ウィンドウ操作系
  - `popwin`
  - `iswitchb`
  - `windresize`
  - ウィンドウ切り替え
    - [x] `windmove`
	- [ ] `window-number`
	- [x] `window-numbering`
    - [ ] `switch-window`
    - [ ] `win-switch`
    - [x] `owdriver`
  - タブ
    - [x] `elscreen`
    - [ ] `tabbar`
- スタイル
  - `theme-looper`
  - `nyan-mode`
  - `rainbow-mode`
  - `rainbow-delimiters`
  - `highlight-symbol`
  - `auto-highlight-symbol`
  - `hiwin`
- その他
  - `sudo-edit`
  - `w3m`
  - `twittering-mode`