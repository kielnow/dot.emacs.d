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
  - cua-rectangle-mark-mode
  - expand-region
  - multiple-cursors
    - 一括編集
    - [x] color-moccur, moccur-edit
    - [ ] occur
    - [ ] all, all-ext
- 操作系
  - helm
  - redo+
  - point-undo
  - icomplete
  - ポップアップ
    - [x] company
    - [ ] auto-complete
- ウィンドウ操作系
  - iswitchb
  - タブ
    - [x] elscreen
    - [ ] tabbar

