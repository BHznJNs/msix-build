#!/bin/bash
# -----------------------------------------------------------------------------
# MSIX 图标资产生成脚本 (使用 ImageMagick) - v3 (最新语法)
#
# 用法:
#   bash generate-uwp-icon.sh <path_to_master_image.png>
#
# 描述:
#   此脚本使用 ImageMagick 7+ 的最新、最简洁的语法，不会产生弃用警告。
# -----------------------------------------------------------------------------

set -e # 如果任何命令失败，立即退出脚本

# --- 配置 ---
MASTER_IMAGE="$1"
OUTPUT_DIR="Assets"

# --- 验证输入 ---
if [[ -z "$MASTER_IMAGE" ]]; then
  echo "错误: 请提供母版图像的路径。"
  echo "用法: bash $0 <path_to_master_image.png>"
  exit 1
fi

if ! command -v magick &> /dev/null; then
    echo "错误: ImageMagick (magick) 未安装或未在系统路径中。"
    echo "请确保已安装 ImageMagick 7 或更高版本: https://imagemagick.org/script/download.php"
    exit 1
fi

# --- 开始生成 ---
echo "正在从 '$MASTER_IMAGE' 生成图标到 '$OUTPUT_DIR/' 目录..."
mkdir -p "$OUTPUT_DIR"

# --- 1. 方形磁贴和应用列表图标 (基础: 44x44) ---
echo "生成 Square44x44Logo 图标..."
magick "$MASTER_IMAGE" -resize 44x44   "$OUTPUT_DIR/Square44x44Logo.scale-100.png"
magick "$MASTER_IMAGE" -resize 55x55   "$OUTPUT_DIR/Square44x44Logo.scale-125.png"
magick "$MASTER_IMAGE" -resize 66x66   "$OUTPUT_DIR/Square44x44Logo.scale-150.png"
magick "$MASTER_IMAGE" -resize 88x88   "$OUTPUT_DIR/Square44x44Logo.scale-200.png"
magick "$MASTER_IMAGE" -resize 176x176 "$OUTPUT_DIR/Square44x44Logo.scale-400.png"

# --- 2. 应用列表特定尺寸图标 (Target-size) ---
echo "生成 Target-Size 应用列表图标..."
magick "$MASTER_IMAGE" -resize 16x16   "$OUTPUT_DIR/Square44x44Logo.targetsize-16_altform-unplated.png"
magick "$MASTER_IMAGE" -resize 24x24   "$OUTPUT_DIR/Square44x44Logo.targetsize-24_altform-unplated.png"
magick "$MASTER_IMAGE" -resize 32x32   "$OUTPUT_DIR/Square44x44Logo.targetsize-32_altform-unplated.png"
magick "$MASTER_IMAGE" -resize 48x48   "$OUTPUT_DIR/Square44x44Logo.targetsize-48_altform-unplated.png"
magick "$MASTER_IMAGE" -resize 256x256 "$OUTPUT_DIR/Square44x44Logo.targetsize-256_altform-unplated.png"

# --- 3. 中等磁贴 (基础: 150x150) ---
echo "生成 Square150x150Logo 图标..."
magick "$MASTER_IMAGE" -resize 150x150 "$OUTPUT_DIR/Square150x150Logo.scale-100.png"
magick "$MASTER_IMAGE" -resize 188x188 "$OUTPUT_DIR/Square150x150Logo.scale-125.png"
magick "$MASTER_IMAGE" -resize 225x225 "$OUTPUT_DIR/Square150x150Logo.scale-150.png"
magick "$MASTER_IMAGE" -resize 300x300 "$OUTPUT_DIR/Square150x150Logo.scale-200.png"
magick "$MASTER_IMAGE" -resize 600x600 "$OUTPUT_DIR/Square150x150Logo.scale-400.png"

# --- 4. 宽磁贴 (基础: 310x150) ---
echo "生成 Wide310x150Logo 图标..."
magick "$MASTER_IMAGE" -resize 310x150\! "$OUTPUT_DIR/Wide310x150Logo.scale-100.png"
magick "$MASTER_IMAGE" -resize 388x188\! "$OUTPUT_DIR/Wide310x150Logo.scale-125.png"
magick "$MASTER_IMAGE" -resize 465x225\! "$OUTPUT_DIR/Wide310x150Logo.scale-150.png"
magick "$MASTER_IMAGE" -resize 620x300\! "$OUTPUT_DIR/Wide310x150Logo.scale-200.png"
magick "$MASTER_IMAGE" -resize 1240x600\! "$OUTPUT_DIR/Wide310x150Logo.scale-400.png"

# --- 5. 大磁贴 (基础: 310x310) ---
echo "生成 Square310x310Logo 图标..."
magick "$MASTER_IMAGE" -resize 310x310 "$OUTPUT_DIR/Square310x310Logo.scale-100.png"
magick "$MASTER_IMAGE" -resize 388x388 "$OUTPUT_DIR/Square310x310Logo.scale-125.png"
magick "$MASTER_IMAGE" -resize 465x465 "$OUTPUT_DIR/Square310x310Logo.scale-150.png"
magick "$MASTER_IMAGE" -resize 620x620 "$OUTPUT_DIR/Square310x310Logo.scale-200.png"
magick "$MASTER_IMAGE" -resize 1240x1240 "$OUTPUT_DIR/Square310x310Logo.scale-400.png"

# --- 6. 应用商店徽标 (基础: 50x50) ---
echo "生成 StoreLogo 图标..."
magick "$MASTER_IMAGE" -resize 50x50 -background white -alpha remove -alpha off "$OUTPUT_DIR/StoreLogo.scale-100.png"
magick "$MASTER_IMAGE" -resize 63x63 -background white -alpha remove -alpha off "$OUTPUT_DIR/StoreLogo.scale-125.png"
magick "$MASTER_IMAGE" -resize 75x75 -background white -alpha remove -alpha off "$OUTPUT_DIR/StoreLogo.scale-150.png"
magick "$MASTER_IMAGE" -resize 100x100 -background white -alpha remove -alpha off "$OUTPUT_DIR/StoreLogo.scale-200.png"
magick "$MASTER_IMAGE" -resize 200x200 -background white -alpha remove -alpha off "$OUTPUT_DIR/StoreLogo.scale-400.png"

# --- 7. 闪屏 (基础: 620x300) ---
echo "生成 SplashScreen 图标..."
magick "$MASTER_IMAGE" -resize 300x300 -background none -gravity center -extent 620x300   "$OUTPUT_DIR/SplashScreen.scale-100.png"
magick "$MASTER_IMAGE" -resize 375x375 -background none -gravity center -extent 775x375   "$OUTPUT_DIR/SplashScreen.scale-125.png"
magick "$MASTER_IMAGE" -resize 450x450 -background none -gravity center -extent 930x450   "$OUTPUT_DIR/SplashScreen.scale-150.png"
magick "$MASTER_IMAGE" -resize 600x600 -background none -gravity center -extent 1240x600  "$OUTPUT_DIR/SplashScreen.scale-200.png"
magick "$MASTER_IMAGE" -resize 1200x1200 -background none -gravity center -extent 2480x1200 "$OUTPUT_DIR/SplashScreen.scale-400.png"

echo "✅ 所有图标已成功生成！"