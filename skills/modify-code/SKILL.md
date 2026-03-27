---
name: "modify-code"
description: "影響分析（search-references）で特定されたアクションリストをもとに、指定された文字コード(fileencoding)を厳守して実際のファイルを修正する場合に【必ず】このスキルを使用してください。"
license: MIT
metadata:
  version: "1.0"
---

## 概要
提供されたJSON配列のアクションリストに従い、ワークスペース内の対象ファイルを実際に修正するスキルです。

## 使用手順
実行環境に応じて、ターミナルから以下のコマンドやスクリプト（または等価なツール）を使用してファイルの置換を実行してください。

### Windows (PowerShell) の場合
PowerShellはバージョン（5.1とCore 6+）によって `-Encoding` の挙動（BOMの有無など）や指定可能な値が異なります。文字コード破壊を防ぐため、以下のコマンド例のように **.NET API** を使用して厳密にエンコーディングを指定・置換してください。

* 例: UTF-8（BOMなし）の場合
  `powershell -Command "$text = [System.IO.File]::ReadAllText('<filepath>', [System.Text.Encoding]::UTF8); $newText = $text -replace '\b<old_name>\b', '<new_name>'; [System.IO.File]::WriteAllText('<filepath>', $newText, [System.Text.Encoding]::new(20127))"`
  *(※ `20127`は ASCII, `932`は Shift-JIS など環境に合わせて .NET エンコーディングクラスを調整)*

### Linux / macOS (Bash/sed) の場合
`sed -i 's/\b<old_name>\b/<new_name>/g' <filepath>`
*(※エンコーディングがUTF-8以外の場合は `iconv` コマンド等を組み合わせて適切に変換・処理してください)*

### 🚨 文字コード対応の厳守事項（最重要）
1. **エンコーディングの厳守:** 提供された `fileencoding` で指定された文字コードを絶対に尊重してください。"Shift-JIS" や "UTF-8" と指定されているファイルを誤って別の文字コードとして上書き保存することは、致命的な破壊行為です。
2. **スコープの限定:** 指定された行番号の置換のみを実行し、それ以外のインデント調整や余計なリファクタリングは一切行わないでください。

### 出力フォーマット
修正が完了したファイルの一覧と、適用した `fileencoding` のリストを簡潔に報告してください。
