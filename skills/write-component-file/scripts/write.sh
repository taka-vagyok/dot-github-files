#!/usr/bin/env bash
# write.sh <filepath> <content_string>

if [ "$#" -ne 2 ]; then
    echo "[ERROR] Invalid arguments. Usage: $0 <filepath> <content_string>"
    exit 1
fi

FILEPATH="$1"
CONTENT="$2"

# 拡張子のディレクトリなどへの書き込みを防ぐ単純なチェック
if [ -z "$FILEPATH" ]; then
    echo "[ERROR] Filepath cannot be empty."
    exit 1
fi

# 親ディレクトリの取得と作成
DIRNAME=$(dirname "$FILEPATH")
if [ ! -d "$DIRNAME" ]; then
    mkdir -p "$DIRNAME" || { echo "[ERROR] Failed to create directory: $DIRNAME"; exit 1; }
fi

# ファイル書き込み
# 改行コード等が適切に処理されるように printf を使用する
printf "%s\n" "$CONTENT" > "$FILEPATH" || { echo "[ERROR] Failed to write to file: $FILEPATH"; exit 1; }

echo "[SUCCESS] Wrote to $FILEPATH"
