#!/bin/bash

# Перейти в директорию, где лежит сам скрипт
cd "$(dirname "$0")"

echo "📂 Current folder: $(pwd)"
echo "🔎 Looking for video files (mp4/mov)..."
echo

# Проверка, что ffmpeg установлен
if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "❌ ffmpeg not found. Install with:"
  echo "   brew install ffmpeg"
  exit 1
fi

# Папки для результата
mkdir -p optimized/mp4 optimized/webm

shopt -s nullglob

# Перебор файлов
for f in *.mov *.MOV *.mp4 *.MP4; do
  [ -e "$f" ] || continue

  base=$(basename "$f")
  name="${base%.*}"

  echo "🎬 Processing: $f"

  # ---------- MP4 (H.264, CRF, без звука) ----------
  echo "  ➜ Creating MP4: optimized/mp4/${name}.mp4"

  ffmpeg -y -i "$f" \
    -vf "scale='min(1920,iw)':-2" \
    -c:v libx264 -preset slow -crf 26 -pix_fmt yuv420p \
    -movflags +faststart -an \
    "optimized/mp4/${name}.mp4"

  # ---------- WebM (VP9, CRF, без звука) ----------
  echo "  ➜ Creating WebM: optimized/webm/${name}.webm"

  ffmpeg -y -i "$f" \
    -vf "scale='min(1920,iw)':-2" \
    -c:v libvpx-vp9 -crf 32 -b:v 0 -an \
    "optimized/webm/${name}.webm"

  # Показать размеры
  orig_size=$(stat -f%z "$f" 2>/dev/null || stat -c%s "$f")
  mp4_size=$(stat -f%z "optimized/mp4/${name}.mp4" 2>/dev/null || stat -c%s "optimized/mp4/${name}.mp4")
  webm_size=$(stat -f%z "optimized/webm/${name}.webm" 2>/dev/null || stat -c%s "optimized/webm/${name}.webm")

  echo "  ℹ️ Sizes:"
  echo "    Original: $orig_size bytes"
  echo "    MP4:      $mp4_size bytes"
  echo "    WebM:     $webm_size bytes"
  echo "----------------------------"
done

echo "🎉 Done!"
