# 🎬 Video Converter for macOS

Batch-optimize your `.mp4` and `.mov` videos into **lightweight, web-ready formats** with a single click.  
This script creates both **MP4 (H.264)** and **WebM (VP9)** versions — perfect for websites, portfolios, and apps that need fast-loading media across all browsers.

---

## ✨ Features
- 🔁 Batch converts all `.mp4` and `.mov` files in the current folder  
- 🎞️ Produces two optimized versions:
  - `MP4` (H.264, AAC-free, browser-compatible)
  - `WebM` (VP9, modern and lightweight)
- 📁 Saves results automatically into `/optimized/mp4` and `/optimized/webm`
- 🧹 Removes audio tracks for smaller file size
- ⚙️ Automatically downscales videos above 1080p
- 💨 Web-optimized flags (`+faststart`, `yuv420p`)
- 🧾 Shows before/after file sizes

---

## 🧰 Requirements
- macOS (Ventura or newer recommended)
- [FFmpeg](https://ffmpeg.org/download.html) installed via Homebrew:
  ```bash
  brew install ffmpeg
