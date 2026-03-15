#!/bin/bash
# 天书 HTML 生成脚本
# 用法: ./build.sh tianshu.md [output.html]
# 输出: tianshu.html（同目录）

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/template.html"

if [ $# -lt 1 ]; then
  echo "用法: $0 <input.md> [output.html]"
  exit 1
fi

INPUT="$1"
OUTPUT="${2:-${INPUT%.md}.html}"

if [ ! -f "$INPUT" ]; then
  echo "文件不存在: $INPUT"
  exit 1
fi

pandoc "$INPUT" \
  --standalone \
  --template="$TEMPLATE" \
  --metadata title="天书" \
  --metadata lang="zh-CN" \
  --wrap=none \
  -o "$OUTPUT"

echo "✅ 生成: $OUTPUT ($(wc -c < "$OUTPUT") bytes)"
