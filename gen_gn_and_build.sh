#!/bin/bash

git clone 'https://chromium.googlesource.com/chromium/tools/depot_tools.git'
export PATH="${PWD}/depot_tools:${PATH}"

python3 tools/git-sync-deps > /dev/null 2>&1

gn gen out/$1/$2 --args="is_official_build = true
cc=\"$3 -ffunction-sections -fdata-sections -fno-rtti -flto $CFLAGS\"
cxx=\"$4 -ffunction-sections -fdata-sections -fno-rtti -flto $CXXFLAGS\"
is_debug = false
skia_enable_skottie = true
skia_enable_skparagraph = true
skia_enable_skshaper = false
skia_use_gl = true
skia_enable_skunicode = true
skia_use_x11 = false
skia_use_egl = true
skia_enable_gpu = true
skia_enable_ganesh = true
skia_build_fuzzers = false
skia_enable_fontmgr_custom_embedded = false
skia_enable_fontmgr_custom_empty = false
skia_compile_modules = false
skia_use_dng_sdk = false
skia_enable_fontmgr_custom_directory = false
skunicode_tests_enabled = false
skia_use_sfntly = false
skia_use_perfetto = false
skia_use_lua = false
skia_use_freetype_woff2 = true
skia_use_freetype_zlib_bundled = false
skia_enable_tools = false
skia_enable_android_utils = false
skia_enable_sksl_tracing = false
skia_enable_spirv_validation = false
skia_use_system_libjpeg_turbo = true
skia_use_piex = false
skia_use_system_libpng = true
skia_use_system_libwebp = true
skia_use_system_zlib = true
skia_enable_optimize_size = true
skia_enable_pdf = false
skia_enable_svg = true
skia_pdf_subset_harfbuzz = false
skia_use_xps = false
skia_use_expat = false
skia_use_wuffs = false
paragraph_gms_enabled = false
paragraph_tests_enabled = false
skia_use_icu = true
skia_use_client_icu = true
skia_use_system_icu = true
skia_use_runtime_icu = false
skia_use_icu4x = false
skia_use_libavif = false
is_component_build = true"

ninja -C out/$1/$2

for FILE in $(ls out/$1/$2)
do
    strip -g out/$1/$2/$FILE > /dev/null 2>&1
done