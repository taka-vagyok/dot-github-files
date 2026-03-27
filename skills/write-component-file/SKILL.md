---
name: write-component-file
description: 指定されたパス（ファイル名を含む）に文字列の内容をファイルとして書き込み・上書き保存する場合に【必ず】このスキルを使用してください。ディレクトリが存在しない場合は自動で作成します。
license: MIT
metadata:
  version: "1.0"
---

## 概要
AIコンポーネント（Prompt, Agent, Skill）のファイル内容を物理的にシステム（ディスク）に保存・書き出しを行うためのスキルです。
このスキルは推論を一切含まず、提供されたテキストデータをそのまま指定されたパスへ出力することのみを目的とします。

## 使用手順
実行環境（OS）に応じて、以下のスクリプトのいずれかを実行してファイルを作成・上書きしてください。

### Windows (PowerShell) の場合
`powershell -ExecutionPolicy Bypass -File scripts\write.ps1 -Filepath "<filepath>" -ContentString "<content_string>"`

### Linux / macOS (Bash) の場合
`bash scripts/write.sh "<filepath>" "<content_string>"`

### 入力
* `<filepath>`: 書き込む対象のファイルパス（リポジトリルートからの相対パス）。必要な親ディレクトリがない場合は自動作成されます。
* `<content_string>`: ファイルに書き込む内容の文字列（Markdown形式など）。

### 出力とエラーハンドリング
* **成功時**: `[SUCCESS] Wrote to <filepath>` と標準出力に返されます。
* **エラー時**: 親ディレクトリの作成失敗や権限エラーが発生した場合は、`[ERROR] Failed to write to <filepath>: <理由>` が返されます。エラーを受け取った場合は、パスが正しいか確認してリトライしてください。
