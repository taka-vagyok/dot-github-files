---
name: "extract-vcs-diff"
description: "GitまたはSVNの差分から新規に追加された変数名・関数名を抽出する必要がある場合に【必ず】このスキルを使用してください。入力は不要（自律的にターミナルを実行します）。"
license: MIT
metadata:
  version: "1.0"
---

## 概要
バージョン管理システム（VCS）の差分から、新規に定義された変数名や関数名のリストを抽出するスキルです。

## 使用手順
ターミナルを使用して以下のコマンド（または環境に合った等価なコマンド）を実行し、新規追加（+）された行のみを取得・解析してください。

### Gitの場合
* Linux / macOS (bash/zsh): `git diff -U0 | grep "^\+"`
* Windows (PowerShell): `git diff -U0 | Select-String "^\+"`
* Windows (CMD): `git diff -U0 | findstr /R "^\+"`

### SVNの場合
* Linux / macOS (bash/zsh): `svn diff --diff-cmd diff -x "-U0" | grep "^\+"`
* Windows (PowerShell): `svn diff --diff-cmd diff -x "-U0" | Select-String "^\+"`
* Windows (CMD): `svn diff --diff-cmd diff -x "-U0" | findstr /R "^\+"`

### 抽出時の厳守事項
1. 取得したテキストから、新規に追加・定義された変数名と関数のシグネチャのみを抽出してください。既存コードの変更箇所は無視します。
2. コマンドの出力結果に文字化けが含まれていても無視し、ASCIIの有効な識別子のみに集中してください。
3. 対象ファイルの文字コードを推測し（不明な場合はシステムのデフォルト、例えば "UTF-8" または "Shift-JIS"）、結果に `fileencoding` キーを含めてください。

### 出力フォーマット（厳守）
挨拶や解説は一切省き、以下の形式の純粋なJSON配列のみを出力してください。
[
  {
    "file": "path/to/source.cpp",
    "fileencoding": "Shift-JIS",
    "type": "function",
    "original_name": "calcData"
  }
]
