# Bloated `ffmpeg` compile command v1.2.20221130

only tested in Ubuntu but should work in Debian

```plain
#########################################################################
#             ____  _      ___   ____ ______   ___ ___                  B
#            |    \| T    /   \ /    |      T /  _|   \                 L
#            |  o  | |   Y     Y  o  |      |/  [_|    \                O
#            |     | l___|  O  |     l_j  l_Y    _|  D  Y               A
#            |  O  |     |     |  _  | |  | |   [_|     |               T
#            |     |     l     |  |  | |  | |     |     |               E
#            |     |     l     |  |  | |  | |     |     |               D
#            |     |     l     |  |  | |  | |     |     |               .
#            l_____l_____j\___/l__j__j l__j l_____l_____j               .
#                                                                       .
#                        _   .-')      _ (`-.    ('-.                   .
#                       ( '.( OO )_   ( (OO  ) _(  OO)                  F
#     ,------.   ,------.,--.   ,--.)_.`     \(,------. ,----.          F
#  ('-| _.---'('-| _.---'|   `.'   |(__...--'' |  .---''  .-./-')       M
#  (OO|(_\    (OO|(_\    |         | |  /  | | |  |    |  |_( O- )      P
#  /  |  '--. /  |  '--. |  |'.'|  | |  |_.' |(|  '--. |  | .--, \      E
#  \_)|  .--' \_)|  .--' |  |   |  | |  .___.' |  .--'(|  | '. (_/      G
#    \|  |_)    \|  |_)  |  |   |  | |  |      |  `---.|  '--'  |       .
#     `--'       `--'    `--'   `--' `--'      `------' `------'        .
#                                                                       .
#                                      ▀▀ ███                           .
#            ███  ███  ███████  █████  ██ ▒██  ███  ████                M
#           ██▒▒ ██▒██ ██▒██▒██ ▒██▒██ ██ ░██ ██▒██ ██▒██               A
#           ██   ██▒██ ██▒██▒██ ▒██▒██ ██ ░██ ████▒ ██                  P
#           ██   ██░██ ██▒██▒██ ▒██░██ ██ ░██ ██▒▒  ██                  A
#           ▒███ ▒███▒ ██░██░███░████  ██ ░██ ▒███  ███                 C
#            ▒▒▒  ▒▒▒  ▒▒ ▒▒ ▒▒▒░██▒▒  ▒▒ ░▒▒  ▒▒▒  ▒▒▒                 H
#                               ███                                     E
#                               ▒▒▒                                     🦝
#                                                                       🎈
#########################################################################
```

What it says on the tin.

A friend saw my absurd `ffmpeg` invocation banner:

```plain
ffmpeg version N-109274-gd7a5f068c2 Copyright (c) 2000-2022 the FFmpeg developers
  **OwO what's this?**
  configuration: --prefix=/opt --cc=clang --cxx=clang++ --enable-shared
  --enable-nvenc --enable-nvdec --enable-nonfree --enable-cuda-nvcc
  --enable-libnpp --extra-cflags=-I/usr/local/cuda/include
  --extra-ldflags='-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec'
  --enable-filter='stereo3d,asr,sofalizer' --enable-libaom --enable-libass
  --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus
  --enable-libdav1d --enable-libvorbis --enable-libvpx --enable-nonfree
  --enable-vaapi --enable-opencl --enable-opengl --enable-libtesseract
  --enable-libwebp --enable-openssl --enable-libfontconfig --enable-libbluray
  --enable-libv4l2 --enable-libfribidi --enable-libspeex --enable-librsvg
  --enable-libssh --enable-libpulse --enable-libcaca --enable-librubberband
  --enable-libxcb-xfixes --enable-libdavs2 --enable-frei0r --enable-libcdio
  --enable-libvidstab --enable-libsrt --enable-libglslang --enable-libsoxr
  --enable-pocketsphinx --enable-libflite --enable-libx264 --enable-libx265
  --enable-vdpau --enable-libzimg --enable-gpl --enable-libaribb24
  --enable-version3 --enable-libzvbi --enable-libmysofa --enable-ffplay
  --enable-stripping --disable-debug --enable-libjxl
  libavutil      57. 43.100 / 57. 43.100
  libavcodec     59. 54.100 / 59. 54.100
  libavformat    59. 34.102 / 59. 34.102
  libavdevice    59.  8.101 / 59.  8.101
  libavfilter     8. 51.100 /  8. 51.100
  libswscale      6.  8.112 /  6.  8.112
  libswresample   4.  9.100 /  4.  9.100
  libpostproc    56.  7.100 / 56.  7.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
```

And wanted to know how I got it. This version of ffmpeg has all of [these abilities](https://github.com/ctrlcctrlv/bloated-ffmpeg-compile-command/blob/main/doc/config_stdout.txt).

# Just how bloated is bloated?
Quite.

<img src="doc/コピペ.webp" width="200">
<sup><sub>Not this much though! Art by @<a href="https://twitter.com/Haruk000_">haruk000_</a>.</sub></sup>

Factoring in all shared libraries the Mapache bloated `ffmpeg` weighs 457 megabytes all told, with its `libavcodec.so` ranking first for size.
```bash
#!/bin/bash
doc/bin-size.sh ffmpeg | tac # | ansi2txt
```
```plain
  400.08MB	total
   68.41MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnppif.so.11.5.1.107
   64.36MB			/opt/lib/libavcodec.so.59.51.101
   30.95MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnppig.so.11.5.1.107
   28.12MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libicudata.so.70.1
   27.71MB			/opt/lib/libavfilter.so.8.49.101
   15.77MB			/opt/lib/libavformat.so.59.34.101
   15.33MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libx265.so.199
   10.72MB	(stripped!)	/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.48.0
    9.22MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnppidei.so.11.5.1.107
    7.22MB	(stripped!)	/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
    6.08MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnppicc.so.11.5.1.107
    5.14MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libaom.so.3.3.0
    4.71MB			/opt/lib/libjxl.so.0.8.0
    4.60MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmu_us_rms.so.2.2
    4.25MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcrypto.so.3
    3.97MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmu_us_slt.so.2.2
    3.96MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmu_us_awb.so.2.2
    3.85MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmu_us_kal16.so.2.2
    3.13MB			/opt/lib/libavutil.so.57.41.100
    3.08MB			/opt/lib/libwebp.so.7.1.5
    3.03MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libvpx.so.7.0.0
    3.03MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libtesseract.so.4.0.1
    2.86MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgfortran.so.5.0.0
    2.67MB	(stripped!)	/usr/lib/x86_64-linux-gnu/liblept.so.5.0.4
    2.51MB			/opt/lib/libswscale.so.6.8.112
    2.15MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.30
    2.12MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libc.so.6
    1.97MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libicuuc.so.70.1
    1.91MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgnutls.so.30.31.0
    1.88MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.13
    1.84MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgio-2.0.so.0.7200.1
    1.78MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libx264.so.163
    1.67MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libunistring.so.2.2.0
    1.60MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libSDL2-2.0.so.0.18.2
    1.53MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnppc.so.11.5.1.107
    1.43MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsamplerate.so.0.2.2
    1.40MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmu_us_kal.so.2.2
    1.33MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libslang.so.2.3.2
    1.26MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdav1d.so.5.1.1
    1.25MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libX11.so.6.4.0
    1.24MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgcrypt.so.20.3.4
    1.23MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libp11-kit.so.0.3.0
    1.22MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7200.1
    1.19MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libfdk-aac.so.2.0.2
    1.15MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcairo.so.2.11600.0
    1.14MB			/opt/bin//ffmpeg
    1.02MB	(stripped!)	/usr/lib/x86_64-linux-gnu/libasound.so.2.0.0
  952.83KB			/opt/lib/libavdevice.so.59.8.101
  918.52KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libm.so.6
  824.83KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libharfbuzz.so.0.20704.0
  822.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libzstd.so.1.4.8
  808.60KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libkrb5.so.3.3
  807.97KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcaca.so.0.99.19
  802.10KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libarchive.so.13.6.0
  794.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libfreetype.so.6.18.1
  789.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsystemd.so.0.32.0
  742.93KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsrt-gnutls.so.1.4.4
  698.44KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libGLdispatch.so.0.0.0
  678.18KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpixman-1.so.0.40.0
  678.14KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.12
  661.98KB			/opt/lib/libbrotlienc.so.1.0.7
  658.20KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdavs2.so.16
  657.85KB	(stripped!)	/usr/lib/x86_64-linux-gnu/blas/libblas.so.3.10.0
  652.22KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libssl.so.3
  602.23KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_cmulex.so.2.2
  598.70KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.10.4
  530.33KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libGL.so.1.7.0
  530.17KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libtiff.so.5.7.0
  526.33KB	(stripped!)	/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-15.99.so
  514.55KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgmp.so.10.4.1
  510.71KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libjpeg.so.8.2.2
  496.54KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.31
  466.11KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3
  431.59KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libssh.so.4.8.7
  407.75KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpango-1.0.so.0.5000.6
  405.15KB			/opt/lib/libswresample.so.4.9.100
  378.39KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0.7200.1
  374.41KB			/opt/lib/libpostproc.so.56.7.100
  370.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libopus.so.0.8.0
  346.49KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libopenjp2.so.2.4.0
  342.98KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libbluray.so.2.4.1
  335.20KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpulse.so.0.24.1
  330.78KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2.2
  306.31KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdbus-1.so.3.19.13
  291.78KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgomp.so.1.0.0
  291.14KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libfontconfig.so.1.12.0
  290.85KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpocketsphinx.so.3.0.0
  283.01KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libhogweed.so.6.4
  282.81KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libquadmath.so.0.0.0
  282.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libmp3lame.so.0.0.0
  278.55KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxkbcommon.so.0.0.0
  274.42KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnettle.so.8.4
  266.66KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libmount.so.1.1.0
  254.33KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsphinxbase.so.3.0.0
  235.29KB	(stripped!)	/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  234.10KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libFLAC.so.8.3.0
  234.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libncursesw.so.6.3
  230.17KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite.so.2.2
  230.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpng16.so.16.37.0
  218.17KB	(stripped!)	/usr/lib/x86_64-linux-gnu/librubberband.so.2.1.5
  215.04KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libblkid.so.1.1.0
  210.17KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libass.so.9.1.3
  195.45KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libtinfo.so.6.3
  195.06KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsoxr.so.0.1.2
  190.52KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libva.so.2.1400.0
  190.31KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libexpat.so.1.8.7
  187.28KB			/opt/lib/libwebpmux.so.3.0.10
  186.37KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0.4200.8
  178.65KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libk5crypto.so.3.1
  174.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.9
  166.47KB	(stripped!)	/usr/lib/x86_64-linux-gnu/liblzma.so.5.2.5
  166.23KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libflite_usenglish.so.2.2
  162.61KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  162.39KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libselinux.so.1
  158.45KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libv4lconvert.so.0.0.0
  150.39KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcdio.so.19.0.0
  150.30KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgraphite2.so.3.2.1
  146.25KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgpg-error.so.0.32.1
  138.58KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libGLX.so.0.0.0
  138.04KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdeflate.so.0
  135.61KB			/opt/lib/libbrotlicommon.so.1.0.7
  126.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libidn2.so.0.3.7
  122.55KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgcc_s.so.1
  122.22KB	(stripped!)	/usr/lib/x86_64-linux-gnu/liblz4.so.1.9.3
  114.04KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libspeex.so.1.5.0
  106.39KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libz.so.1.2.11
  106.32KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libfribidi.so.0.4.0
  102.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0.5000.6
   90.15KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libtasn1.so.6.6.2
   87.01KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libbsd.so.0.11.5
   83.45KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libwayland-server.so.0.20.0
   82.61KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdrm.so.2.4.0
   79.73KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXext.so.6.4.0
   78.88KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libapparmor.so.1.8.2
   74.54KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXi.so.6.1.0
   74.30KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libvidstab.so.1.1
   73.10KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libbz2.so.1.0.4
   70.25KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libaribb24.so.0.0.0
   67.67KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libOpenCL.so.1.0.0
   66.95KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libresolv.so.2
   66.47KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libsndio.so.7.1
   66.13KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so.0.5000.6
   65.01KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libjbig.so.0
   63.26KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libwayland-client.so.0.20.0
   63.21KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgbm.so.1.0.0
   62.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libmysofa.so.1.1.0
   61.75KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libv4l2.so.0.0.0
   58.42KB			/opt/lib/libbrotlidec.so.1.0.7
   54.25KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxcb-render.so.0.0.0
   50.86KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libkrb5support.so.0.1
   47.03KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libnuma.so.1.0.0
   46.61KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0
   46.58KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libffi.so.8.1.0
   46.40KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXrandr.so.2.2.0
   46.36KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libmd.so.0.0.5
   42.47KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2
   41.92KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcairo-gobject.so.2.11600.0
   40.19KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libthai.so.0.3.1
   38.11KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcap.so.2.44
   38.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libudfread.so.0.1.0
   38.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgif.so.7.1.0
   37.97KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libogg.so.0.8.5
   34.53KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libwayland-cursor.so.0.20.0
   34.52KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdecor-0.so.0.100.0
   34.22KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxcb-xfixes.so.0.0.0
   34.15KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcdio_cdda.so.2.0.0
   34.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdatrie.so.1.4.0
   34.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libacl.so.1.1.2301
   30.20KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libuuid.so.1.3.0
   30.20KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcdio_paranoia.so.2.0.0
   30.19KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0
   26.69KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libva-x11.so.2.1400.0
   26.18KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0
   26.00KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1
   23.61KB			/opt/lib/libjxl_threads.so.0.8.0
   22.45KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXv.so.1.0.0
   22.34KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXxf86vm.so.1.0.0
   22.21KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0.7200.1
   22.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libkeyutils.so.1.9
   20.95KB			/usr/lib/x86_64-linux-gnu/libpthread.so.0
   18.30KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXinerama.so.1.0.0
   18.29KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0
   18.16KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libvdpau.so.1.0.0
   18.08KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libcom_err.so.2.1
   14.34KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libXss.so.1.0.0
   14.33KB	(stripped!)	/usr/lib/x86_64-linux-gnu/librt.so.1
   14.32KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libva-drm.so.2.1400.0
   14.23KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxcb-shm.so.0.0.0
   14.22KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libxcb-shape.so.0.0.0
   14.10KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libdl.so.2
   14.04KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libwayland-egl.so.1.20.0
   13.72KB	(stripped!)	/usr/lib/x86_64-linux-gnu/libX11-xcb.so.1.0.0
```

# Effects
You will need to create `/opt` if it's not a directory you use as this script installs `ffmpeg` as `/opt/bin/ffmpeg`.

Note: I may forget to update this section. Ground truth version to version is always in [`doc/config_stdout.txt`](doc/config_stdout.txt).

## NVIDIA support
Enables all these flags if it sees you have the binary `nvidia-smi`:
1. --enable-nvdec
1. --enable-nonfree
1. --enable-cuda-nvcc
1. --enable-libnpp
1. --extra-cflags=`-I/usr/local/cuda/include`
1. --extra-ldflags=`-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec`

## Extra libraries
Enables all these libraries also:
1. --enable-filter=stereo3d,asr,sofalizer
1. --enable-libaom
1. --enable-libass
1. --enable-libfdk-aac
1. --enable-libfreetype
1. --enable-libmp3lame
1. --enable-libopus
1. --enable-libdav1d
1. --enable-libvorbis
1. --enable-libvpx
1. --enable-nonfree
1. --enable-vaapi
1. --enable-opencl
1. --enable-opengl
1. --enable-libtesseract
1. --enable-libwebp
1. --enable-openssl
1. --enable-libfontconfig
1. --enable-libbluray
1. --enable-libv4l2
1. --enable-libfribidi
1. --enable-libspeex
1. --enable-librsvg
1. --enable-libssh
1. --enable-libpulse
1. --enable-libcaca
1. --enable-librubberband
1. --enable-libxcb-xfixes
1. --enable-libdavs2
1. --enable-frei0r
1. --enable-libcdio
1. --enable-libvidstab
1. --enable-libsrt
1. --enable-libglslang
1. --enable-libsoxr
1. --enable-pocketsphinx
1. --enable-libflite
1. --enable-libaribb24
1. --enable-version3
1. --enable-libmysofa
1. --enable-libzimg
1. --enable-libzvbi

## OwO what's this?
Although easy to interpret as a joke in the above text, this was not one:

```diff
diff --git a/fftools/opt_common.c b/fftools/opt_common.c
index c303db4d09..e46e8dc98a 100644
--- a/fftools/opt_common.c
+++ b/tmp/opt_common.c
@@ -193,6 +193,7 @@ static void print_all_libs_info(int flags, int level)
 
 static void print_program_info(int flags, int level)
 {
+    int clevel = av_log_get_level();
     const char *indent = flags & INDENT? "  " : "";
 
     av_log(NULL, level, "%s version " FFMPEG_VERSION, program_name);
@@ -200,8 +201,8 @@ static void print_program_info(int flags, int level)
         av_log(NULL, level, " Copyright (c) %d-%d the FFmpeg developers",
                program_birth_year, CONFIG_THIS_YEAR);
     av_log(NULL, level, "\n");
-    av_log(NULL, level, "%sbuilt with %s\n", indent, CC_IDENT);
-
+    if (level <= clevel)
+        fprintf(stderr, "%s\e[1mOwO what's this?\e(B\e[m\n", indent);
     av_log(NULL, level, "%sconfiguration: " FFMPEG_CONFIGURATION "\n", indent);
 }
 
```

This patch is applied so that you know you're running your `ffmpeg` not the system's.

## Environment variables

If you run as `APT_INSTALL=y ./compile_command.sh`, it will install ≈206 packages. `grep` for `$APT_INSTALL` for a list. List may be incomplete or overly detailed, sorry.

If you run as `DOGIT=y …`, it will reset git.

A successful invocation looks like:

**stdin**
```
$ ./compile-command.sh
```
**stdout**
```
+ NVIDIASHIT=('--enable-shared' '--enable-nvenc' '--enable-nvdec' '--enable-nonfree' '--enable-cuda-nvcc' '--enable-libnpp' '--extra-cflags=-I/usr/local/cuda/include' '--extra-ldflags=-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec')
+ [[ -n '' ]]
++ git diff-index --name-only HEAD --
+ GIT_CHANGES=
+ for f in *.patch
+ git diff-index --name-only HEAD --
++ basename --suffix=.patch opt_common.c.patch
+ grep opt_common.c
+ git apply --verbose opt_common.c.patch
Checking patch fftools/opt_common.c...
Applied patch fftools/opt_common.c cleanly.
+ hash nvidia-smi
+ test '!' -e /opt/include/ffnvcodec/nvEncodeAPI.h
+ hash nvidia-smi
+ [[ -n '' ]]
+ tee config_stdout.txt
++ /bin/bash -c 'tput cols'
+ ncols=236
+ PKG_CONFIG_PATH=/opt/lib/pkgconfig
+ ./configure --prefix=/opt --enable-shared --enable-nvenc --enable-nvdec --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include '--extra-ldflags=-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec' --enable-filter=stereo3d,asr,sofalizer --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libdav1d --enable-libvorbis --enable-libvpx --enable-nonfree --enable-vaapi --enable-opencl --enable-opengl --enable-libtesseract --enable-libwebp --enable-openssl --enable-libfontconfig --enable-libbluray --enable-libv4l2 --enable-libfribidi --enable-libspeex --enable-librsvg --enable-libssh --enable-libpulse --enable-libcaca --enable-librubberband --enable-libxcb-xfixes --enable-libdavs2 --enable-frei0r --enable-libcdio --enable-libvidstab --enable-libsrt --enable-libglslang --enable-libsoxr --enable-pocketsphinx --enable-libflite --enable-gpl --enable-avisynth --enable-libaribb24 --enable-version3 --enable-libmysofa --enable-ffplay --disable-stripping --enable-debug
```
**stdout + config_stdout.txt (`tee`)**
```
install prefix            /opt
source path               .
C compiler                gcc
C library                 glibc
ARCH                      x86 (generic)
big-endian                no
runtime cpu detection     yes
standalone assembly       yes
x86 assembler             nasm
MMX enabled               yes
MMXEXT enabled            yes
3DNow! enabled            yes
3DNow! extended enabled   yes
SSE enabled               yes
SSSE3 enabled             yes
AESNI enabled             yes
AVX enabled               yes
AVX2 enabled              yes
AVX-512 enabled           yes
AVX-512ICL enabled        yes
XOP enabled               yes
FMA3 enabled              yes
FMA4 enabled              yes
i686 features enabled     yes
CMOV is fast              yes
EBX available             yes
EBP available             yes
debug symbols             yes
strip symbols             no
optimize for size         no
optimizations             yes
static                    yes
shared                    yes
postprocessing support    yes
network support           yes
threading support         pthreads
safe bitstream reader     yes
texi2html enabled         no
perl enabled              yes
pod2man enabled           yes
makeinfo enabled          no
makeinfo supports HTML    no
xmllint enabled           no

External libraries:
alsa                    libcaca                 libfreetype             librsvg                 libv4l2                 libxcb_shm              sndio
frei0r                  libcdio                 libfribidi              librubberband           libvidstab              libxcb_xfixes           xlib
iconv                   libdav1d                libglslang              libsoxr                 libvorbis               lzma                    zlib
libaom                  libdavs2                libmp3lame              libspeex                libvpx                  opengl
libaribb24              libfdk_aac              libmysofa               libsrt                  libwebp                 openssl
libass                  libflite                libopus                 libssh                  libxcb                  pocketsphinx
libbluray               libfontconfig           libpulse                libtesseract            libxcb_shape            sdl2

External libraries providing hardware acceleration:
cuda                    cuda_nvcc               ffnvcodec               nvdec                   opencl                  vaapi                   vulkan
cuda_llvm               cuvid                   libnpp                  nvenc                   v4l2_m2m                vdpau

Libraries:
avcodec                 avfilter                avutil                  swresample
avdevice                avformat                postproc                swscale

Programs:
ffmpeg                  ffplay                  ffprobe

Enabled decoders:
aac                     argo                    eamad                   jpegls                  mvc2                    r210                    v210x
aac_fixed               ass                     eatgq                   jv                      mvdv                    ra_144                  v308
aac_latm                asv1                    eatgv                   kgv1                    mvha                    ra_288                  v408
aasc                    asv2                    eatqi                   kmvc                    mwsc                    ralf                    v410
ac3                     atrac1                  eightbps                lagarith                mxpeg                   rasc                    vb
ac3_fixed               atrac3                  eightsvx_exp            libaom_av1              nellymoser              rawvideo                vble
acelp_kelvin            atrac3al                eightsvx_fib            libaribb24              notchlc                 realtext                vbn
adpcm_4xm               atrac3p                 escape124               libdav1d                nuv                     rl2                     vc1
adpcm_adx               atrac3pal               escape130               libdavs2                on2avc                  roq                     vc1_cuvid
adpcm_afc               atrac9                  evrc                    libfdk_aac              opus                    roq_dpcm                vc1_v4l2m2m
adpcm_agm               aura                    exr                     libopus                 paf_audio               rpza                    vc1image
adpcm_aica              aura2                   fastaudio               librsvg                 paf_video               rscc                    vcr1
adpcm_argo              av1                     ffv1                    libspeex                pam                     rv10                    vmdaudio
adpcm_ct                av1_cuvid               ffvhuff                 libvorbis               pbm                     rv20                    vmdvideo
adpcm_dtk               avrn                    ffwavesynth             libvpx_vp8              pcm_alaw                rv30                    vmnc
adpcm_ea                avrp                    fic                     libvpx_vp9              pcm_bluray              rv40                    vorbis
adpcm_ea_maxis_xa       avs                     fits                    loco                    pcm_dvd                 s302m                   vp3
adpcm_ea_r1             avui                    flac                    lscr                    pcm_f16le               sami                    vp4
adpcm_ea_r2             ayuv                    flashsv                 m101                    pcm_f24le               sanm                    vp5
adpcm_ea_r3             bethsoftvid             flashsv2                mace3                   pcm_f32be               sbc                     vp6
adpcm_ea_xas            bfi                     flic                    mace6                   pcm_f32le               scpr                    vp6a
adpcm_g722              bink                    flv                     magicyuv                pcm_f64be               screenpresso            vp6f
adpcm_g726              binkaudio_dct           fmvc                    mdec                    pcm_f64le               sdx2_dpcm               vp7
adpcm_g726le            binkaudio_rdft          fourxm                  media100                pcm_lxf                 sga                     vp8
adpcm_ima_acorn         bintext                 fraps                   metasound               pcm_mulaw               sgi                     vp8_cuvid
adpcm_ima_alp           bitpacked               frwu                    microdvd                pcm_s16be               sgirle                  vp8_v4l2m2m
adpcm_ima_amv           bmp                     ftr                     mimic                   pcm_s16be_planar        sheervideo              vp9
adpcm_ima_apc           bmv_audio               g2m                     misc4                   pcm_s16le               shorten                 vp9_cuvid
adpcm_ima_apm           bmv_video               g723_1                  mjpeg                   pcm_s16le_planar        simbiosis_imx           vp9_v4l2m2m
adpcm_ima_cunning       bonk                    g729                    mjpeg_cuvid             pcm_s24be               sipr                    vplayer
adpcm_ima_dat4          brender_pix             gdv                     mjpegb                  pcm_s24daud             siren                   vqa
adpcm_ima_dk3           c93                     gem                     mlp                     pcm_s24le               smackaud                vqc
adpcm_ima_dk4           cavs                    gif                     mmvideo                 pcm_s24le_planar        smacker                 wavpack
adpcm_ima_ea_eacs       ccaption                gremlin_dpcm            mobiclip                pcm_s32be               smc                     wbmp
adpcm_ima_ea_sead       cdgraphics              gsm                     motionpixels            pcm_s32le               smvjpeg                 wcmv
adpcm_ima_iss           cdtoons                 gsm_ms                  movtext                 pcm_s32le_planar        snow                    webp
adpcm_ima_moflex        cdxl                    h261                    mp1                     pcm_s64be               sol_dpcm                webvtt
adpcm_ima_mtf           cfhd                    h263                    mp1float                pcm_s64le               sonic                   wmalossless
adpcm_ima_oki           cinepak                 h263_v4l2m2m            mp2                     pcm_s8                  sp5x                    wmapro
adpcm_ima_qt            clearvideo              h263i                   mp2float                pcm_s8_planar           speedhq                 wmav1
adpcm_ima_rad           cljr                    h263p                   mp3                     pcm_sga                 speex                   wmav2
adpcm_ima_smjpeg        cllc                    h264                    mp3adu                  pcm_u16be               srgc                    wmavoice
adpcm_ima_ssi           comfortnoise            h264_cuvid              mp3adufloat             pcm_u16le               srt                     wmv1
adpcm_ima_wav           cook                    h264_v4l2m2m            mp3float                pcm_u24be               ssa                     wmv2
adpcm_ima_ws            cpia                    hap                     mp3on4                  pcm_u24le               stl                     wmv3
adpcm_ms                cri                     hca                     mp3on4float             pcm_u32be               subrip                  wmv3image
adpcm_mtaf              cscd                    hcom                    mpc7                    pcm_u32le               subviewer               wnv1
adpcm_psx               cyuv                    hdr                     mpc8                    pcm_u8                  subviewer1              wrapped_avframe
adpcm_sbpro_2           dca                     hevc                    mpeg1_cuvid             pcm_vidc                sunrast                 ws_snd1
adpcm_sbpro_3           dds                     hevc_cuvid              mpeg1_v4l2m2m           pcx                     svq1                    xan_dpcm
adpcm_sbpro_4           derf_dpcm               hevc_v4l2m2m            mpeg1video              pfm                     svq3                    xan_wc3
adpcm_swf               dfa                     hnm4_video              mpeg2_cuvid             pgm                     tak                     xan_wc4
adpcm_thp               dfpwm                   hq_hqa                  mpeg2_v4l2m2m           pgmyuv                  targa                   xbin
adpcm_thp_le            dirac                   hqx                     mpeg2video              pgssub                  targa_y216              xbm
adpcm_vima              dnxhd                   huffyuv                 mpeg4                   pgx                     tdsc                    xface
adpcm_xa                dolby_e                 hymt                    mpeg4_cuvid             phm                     text                    xl
adpcm_yamaha            dpx                     iac                     mpeg4_v4l2m2m           photocd                 theora                  xma1
adpcm_zork              dsd_lsbf                idcin                   mpegvideo               pictor                  thp                     xma2
agm                     dsd_lsbf_planar         idf                     mpl2                    pixlet                  tiertexseqvideo         xpm
aic                     dsd_msbf                iff_ilbm                msa1                    pjs                     tiff                    xsub
alac                    dsd_msbf_planar         ilbc                    mscc                    png                     tmv                     xwd
alias_pix               dsicinaudio             imc                     msmpeg4v1               ppm                     truehd                  y41p
als                     dsicinvideo             imm4                    msmpeg4v2               prores                  truemotion1             ylc
amrnb                   dss_sp                  imm5                    msmpeg4v3               prosumer                truemotion2             yop
amrwb                   dst                     indeo2                  msnsiren                psd                     truemotion2rt           yuv4
amv                     dvaudio                 indeo3                  msp2                    ptx                     truespeech              zero12v
anm                     dvbsub                  indeo4                  msrle                   qcelp                   tscc                    zerocodec
ansi                    dvdsub                  indeo5                  mss1                    qdm2                    tscc2                   zlib
apac                    dvvideo                 interplay_acm           mss2                    qdmc                    tta                     zmbv
ape                     dxa                     interplay_dpcm          msvideo1                qdraw                   twinvq
apng                    dxtory                  interplay_video         mszh                    qoi                     txd
aptx                    dxv                     ipu                     mts2                    qpeg                    ulti
aptx_hd                 eac3                    jacosub                 mv30                    qtrle                   utvideo
arbc                    eacmv                   jpeg2000                mvc1                    r10k                    v210

Enabled encoders:
a64multi                avrp                    h263_v4l2m2m            mp2fixed                pcm_s32be               ra_144                  v408
a64multi5               avui                    h263p                   mpeg1video              pcm_s32le               rawvideo                v410
aac                     ayuv                    h264_nvenc              mpeg2_vaapi             pcm_s32le_planar        roq                     vbn
ac3                     bitpacked               h264_v4l2m2m            mpeg2video              pcm_s64be               roq_dpcm                vc2
ac3_fixed               bmp                     h264_vaapi              mpeg4                   pcm_s64le               rpza                    vorbis
adpcm_adx               cfhd                    hdr                     mpeg4_v4l2m2m           pcm_s8                  rv10                    vp8_v4l2m2m
adpcm_argo              cinepak                 hevc_nvenc              msmpeg4v2               pcm_s8_planar           rv20                    vp8_vaapi
adpcm_g722              cljr                    hevc_v4l2m2m            msmpeg4v3               pcm_u16be               s302m                   vp9_vaapi
adpcm_g726              comfortnoise            hevc_vaapi              msvideo1                pcm_u16le               sbc                     wavpack
adpcm_g726le            dca                     huffyuv                 nellymoser              pcm_u24be               sgi                     wbmp
adpcm_ima_alp           dfpwm                   jpeg2000                opus                    pcm_u24le               smc                     webvtt
adpcm_ima_amv           dnxhd                   jpegls                  pam                     pcm_u32be               snow                    wmav1
adpcm_ima_apm           dpx                     libaom_av1              pbm                     pcm_u32le               sonic                   wmav2
adpcm_ima_qt            dvbsub                  libfdk_aac              pcm_alaw                pcm_u8                  sonic_ls                wmv1
adpcm_ima_ssi           dvdsub                  libmp3lame              pcm_bluray              pcm_vidc                speedhq                 wmv2
adpcm_ima_wav           dvvideo                 libopus                 pcm_dvd                 pcx                     srt                     wrapped_avframe
adpcm_ima_ws            eac3                    libspeex                pcm_f32be               pfm                     ssa                     xbm
adpcm_ms                exr                     libvorbis               pcm_f32le               pgm                     subrip                  xface
adpcm_swf               ffv1                    libvpx_vp8              pcm_f64be               pgmyuv                  sunrast                 xsub
adpcm_yamaha            ffvhuff                 libvpx_vp9              pcm_f64le               phm                     svq1                    xwd
alac                    fits                    libwebp                 pcm_mulaw               png                     targa                   y41p
alias_pix               flac                    libwebp_anim            pcm_s16be               ppm                     text                    yuv4
amv                     flashsv                 ljpeg                   pcm_s16be_planar        prores                  tiff                    zlib
apng                    flashsv2                magicyuv                pcm_s16le               prores_aw               truehd                  zmbv
aptx                    flv                     mjpeg                   pcm_s16le_planar        prores_ks               tta
aptx_hd                 g723_1                  mjpeg_vaapi             pcm_s24be               qoi                     ttml
ass                     gif                     mlp                     pcm_s24daud             qtrle                   utvideo
asv1                    h261                    movtext                 pcm_s24le               r10k                    v210
asv2                    h263                    mp2                     pcm_s24le_planar        r210                    v308

Enabled hwaccels:
av1_nvdec               h264_vdpau              mjpeg_vaapi             mpeg2_vdpau             vc1_vaapi               vp9_vaapi
av1_vaapi               hevc_nvdec              mpeg1_nvdec             mpeg4_nvdec             vc1_vdpau               vp9_vdpau
h263_vaapi              hevc_vaapi              mpeg1_vdpau             mpeg4_vaapi             vp8_nvdec               wmv3_nvdec
h264_nvdec              hevc_vdpau              mpeg2_nvdec             mpeg4_vdpau             vp8_vaapi               wmv3_vaapi
h264_vaapi              mjpeg_nvdec             mpeg2_vaapi             vc1_nvdec               vp9_nvdec               wmv3_vdpau

Enabled parsers:
aac                     cavsvideo               dvbsub                  h261                    mlp                     rv40                    webp
aac_latm                cook                    dvd_nav                 h263                    mpeg4video              sbc                     xbm
ac3                     cri                     dvdsub                  h264                    mpegaudio               sipr                    xma
adx                     dca                     flac                    hdr                     mpegvideo               tak                     xwd
amr                     dirac                   ftr                     hevc                    opus                    vc1
av1                     dnxhd                   g723_1                  ipu                     png                     vorbis
avs2                    dolby_e                 g729                    jpeg2000                pnm                     vp3
avs3                    dpx                     gif                     misc4                   qoi                     vp8
bmp                     dvaudio                 gsm                     mjpeg                   rv30                    vp9

Enabled demuxers:
aa                      bitpacked               g726le                  image_psd_pipe          mpc8                    pjs                     svs
aac                     bmv                     g729                    image_qdraw_pipe        mpegps                  pmp                     swf
aax                     boa                     gdv                     image_qoi_pipe          mpegts                  pp_bnk                  tak
ac3                     bonk                    genh                    image_sgi_pipe          mpegtsraw               pva                     tedcaptions
ace                     brstm                   gif                     image_sunrast_pipe      mpegvideo               pvf                     thp
acm                     c93                     gsm                     image_svg_pipe          mpjpeg                  qcp                     threedostr
act                     caf                     gxf                     image_tiff_pipe         mpl2                    r3d                     tiertexseq
adf                     cavsvideo               h261                    image_vbn_pipe          mpsub                   rawvideo                tmv
adp                     cdg                     h263                    image_webp_pipe         msf                     realtext                truehd
ads                     cdxl                    h264                    image_xbm_pipe          msnwc_tcp               redspark                tta
adx                     cine                    hca                     image_xpm_pipe          msp                     rl2                     tty
aea                     codec2                  hcom                    image_xwd_pipe          mtaf                    rm                      txd
afc                     codec2raw               hevc                    ingenient               mtv                     roq                     ty
aiff                    concat                  hls                     ipmovie                 musx                    rpl                     v210
aix                     data                    hnm                     ipu                     mv                      rsd                     v210x
alp                     daud                    ico                     ircam                   mvi                     rso                     vag
amr                     dcstr                   idcin                   iss                     mxf                     rtp                     vc1
amrnb                   derf                    idf                     iv8                     mxg                     rtsp                    vc1t
amrwb                   dfa                     iff                     ivf                     nc                      s337m                   vividas
anm                     dfpwm                   ifv                     ivr                     nistsphere              sami                    vivo
apac                    dhav                    ilbc                    jacosub                 nsp                     sap                     vmd
apc                     dirac                   image2                  jv                      nsv                     sbc                     vobsub
ape                     dnxhd                   image2_alias_pix        kux                     nut                     sbg                     voc
apm                     dsf                     image2_brender_pix      kvag                    nuv                     scc                     vpk
apng                    dsicin                  image2pipe              laf                     obu                     scd                     vplayer
aptx                    dss                     image_bmp_pipe          live_flv                ogg                     sdp                     vqf
aptx_hd                 dts                     image_cri_pipe          lmlm4                   oma                     sdr2                    w64
aqtitle                 dtshd                   image_dds_pipe          loas                    paf                     sds                     wav
argo_asf                dv                      image_dpx_pipe          lrc                     pcm_alaw                sdx                     wc3
argo_brp                dvbsub                  image_exr_pipe          luodat                  pcm_f32be               segafilm                webm_dash_manifest
argo_cvg                dvbtxt                  image_gem_pipe          lvf                     pcm_f32le               ser                     webvtt
asf                     dxa                     image_gif_pipe          lxf                     pcm_f64be               sga                     wsaud
asf_o                   ea                      image_hdr_pipe          m4v                     pcm_f64le               shorten                 wsd
ass                     ea_cdata                image_j2k_pipe          matroska                pcm_mulaw               siff                    wsvqa
ast                     eac3                    image_jpeg_pipe         mca                     pcm_s16be               simbiosis_imx           wtv
au                      epaf                    image_jpegls_pipe       mcc                     pcm_s16le               sln                     wv
av1                     ffmetadata              image_jpegxl_pipe       mgsts                   pcm_s24be               smacker                 wve
avi                     filmstrip               image_pam_pipe          microdvd                pcm_s24le               smjpeg                  xa
avr                     fits                    image_pbm_pipe          mjpeg                   pcm_s32be               smush                   xbin
avs                     flac                    image_pcx_pipe          mjpeg_2000              pcm_s32le               sol                     xmv
avs2                    flic                    image_pfm_pipe          mlp                     pcm_s8                  sox                     xvag
avs3                    flv                     image_pgm_pipe          mlv                     pcm_u16be               spdif                   xwma
bethsoftvid             fourxm                  image_pgmyuv_pipe       mm                      pcm_u16le               srt                     yop
bfi                     frm                     image_pgx_pipe          mmf                     pcm_u24be               stl                     yuv4mpegpipe
bfstm                   fsb                     image_phm_pipe          mods                    pcm_u24le               str
bink                    fwse                    image_photocd_pipe      moflex                  pcm_u32be               subviewer
binka                   g722                    image_pictor_pipe       mov                     pcm_u32le               subviewer1
bintext                 g723_1                  image_png_pipe          mp3                     pcm_u8                  sup
bit                     g726                    image_ppm_pipe          mpc                     pcm_vidc                svag

Enabled muxers:
a64                     caf                     g722                    lrc                     mxf_opatom              pcm_u24le               streamhash
ac3                     cavsvideo               g723_1                  m4v                     null                    pcm_u32be               sup
adts                    codec2                  g726                    matroska                nut                     pcm_u32le               swf
adx                     codec2raw               g726le                  matroska_audio          obu                     pcm_u8                  tee
aiff                    crc                     gif                     md5                     oga                     pcm_vidc                tg2
alp                     dash                    gsm                     microdvd                ogg                     psp                     tgp
amr                     data                    gxf                     mjpeg                   ogv                     rawvideo                truehd
amv                     daud                    h261                    mkvtimestamp_v2         oma                     rm                      tta
apm                     dfpwm                   h263                    mlp                     opus                    roq                     ttml
apng                    dirac                   h264                    mmf                     pcm_alaw                rso                     uncodedframecrc
aptx                    dnxhd                   hash                    mov                     pcm_f32be               rtp                     vc1
aptx_hd                 dts                     hds                     mp2                     pcm_f32le               rtp_mpegts              vc1t
argo_asf                dv                      hevc                    mp3                     pcm_f64be               rtsp                    voc
argo_cvg                eac3                    hls                     mp4                     pcm_f64le               sap                     w64
asf                     f4v                     ico                     mpeg1system             pcm_mulaw               sbc                     wav
asf_stream              ffmetadata              ilbc                    mpeg1vcd                pcm_s16be               scc                     webm
ass                     fifo                    image2                  mpeg1video              pcm_s16le               segafilm                webm_chunk
ast                     fifo_test               image2pipe              mpeg2dvd                pcm_s24be               segment                 webm_dash_manifest
au                      filmstrip               ipod                    mpeg2svcd               pcm_s24le               smjpeg                  webp
avi                     fits                    ircam                   mpeg2video              pcm_s32be               smoothstreaming         webvtt
avif                    flac                    ismv                    mpeg2vob                pcm_s32le               sox                     wsaud
avm2                    flv                     ivf                     mpegts                  pcm_s8                  spdif                   wtv
avs2                    framecrc                jacosub                 mpjpeg                  pcm_u16be               spx                     wv
avs3                    framehash               kvag                    mxf                     pcm_u16le               srt                     yuv4mpegpipe
bit                     framemd5                latm                    mxf_d10                 pcm_u24be               stream_segment

Enabled protocols:
async                   data                    gophers                 ipfs                    mmst                    rtmpt                   tcp
bluray                  ffrtmpcrypt             hls                     ipns                    pipe                    rtmpte                  tee
cache                   ffrtmphttp              http                    libsrt                  prompeg                 rtmpts                  tls
concat                  file                    httpproxy               libssh                  rtmp                    rtp                     udp
concatf                 ftp                     https                   md5                     rtmpe                   srtp                    udplite
crypto                  gopher                  icecast                 mmsh                    rtmps                   subfile                 unix

Enabled filters:
a3dscope                aselect                 colorspace              fifo                    lutrgb                  removelogo              streamselect
abench                  asendcmd                colorspace_cuda         fillborders             lutyuv                  repeatfields            subtitles
abitscope               asetnsamples            colorspectrum           find_rect               mandelbrot              replaygain              super2xsai
acompressor             asetpts                 colortemperature        firequalizer            maskedclamp             reverse                 superequalizer
acontrast               asetrate                compand                 flanger                 maskedmax               rgbashift               surround
acopy                   asettb                  compensationdelay       flip_vulkan             maskedmerge             rgbtestsrc              swaprect
acrossfade              ashowinfo               concat                  flite                   maskedmin               roberts                 swapuv
acrossover              asidedata               convolution             floodfill               maskedthreshold         roberts_opencl          tblend
acrusher                asoftclip               convolution_opencl      format                  maskfun                 rotate                  telecine
acue                    aspectralstats          convolve                fps                     mcompand                rubberband              testsrc
addroi                  asplit                  copy                    framepack               median                  sab                     testsrc2
adeclick                asr                     cover_rect              framerate               mergeplanes             scale                   thistogram
adeclip                 ass                     crop                    framestep               mestimate               scale2ref               threshold
adecorrelate            astats                  cropdetect              freezedetect            metadata                scale2ref_npp           thumbnail
adelay                  astreamselect           crossfeed               freezeframes            midequalizer            scale_cuda              thumbnail_cuda
adenorm                 asubboost               crystalizer             frei0r                  minterpolate            scale_npp               tile
aderivative             asubcut                 cue                     frei0r_src              mix                     scale_vaapi             tiltshelf
adrawgraph              asupercut               curves                  fspp                    monochrome              scale_vulkan            tinterlace
adynamicequalizer       asuperpass              datascope               gblur                   morpho                  scdet                   tlut2
adynamicsmooth          asuperstop              dblur                   gblur_vulkan            movie                   scharr                  tmedian
aecho                   atadenoise              dcshift                 geq                     mpdecimate              scroll                  tmidequalizer
aemphasis               atempo                  dctdnoiz                gradfun                 mptestsrc               segment                 tmix
aeval                   atilt                   deband                  gradients               msad                    select                  tonemap
aevalsrc                atrim                   deblock                 graphmonitor            multiply                selectivecolor          tonemap_opencl
aexciter                avectorscope            decimate                grayworld               negate                  sendcmd                 tonemap_vaapi
afade                   avgblur                 deconvolve              greyedge                nlmeans                 separatefields          tpad
afftdn                  avgblur_opencl          dedot                   guided                  nlmeans_opencl          setdar                  transpose
afftfilt                avgblur_vulkan          deesser                 haas                    nnedi                   setfield                transpose_npp
afifo                   avsynctest              deflate                 haldclut                noformat                setparams               transpose_opencl
afir                    axcorrelate             deflicker               haldclutsrc             noise                   setpts                  transpose_vaapi
afirsrc                 bandpass                deinterlace_vaapi       hdcd                    normalize               setrange                transpose_vulkan
aformat                 bandreject              dejudder                headphone               null                    setsar                  treble
afreqshift              bass                    delogo                  hflip                   nullsink                settb                   tremolo
afwtdn                  bbox                    denoise_vaapi           hflip_vulkan            nullsrc                 sharpen_npp             trim
agate                   bench                   derain                  highpass                ocr                     sharpness_vaapi         unpremultiply
agraphmonitor           bilateral               deshake                 highshelf               openclsrc               shear                   unsharp
ahistogram              bilateral_cuda          deshake_opencl          hilbert                 oscilloscope            showcqt                 unsharp_opencl
aiir                    biquad                  despill                 histeq                  overlay                 showfreqs               untile
aintegral               bitplanenoise           detelecine              histogram               overlay_cuda            showinfo                v360
ainterleave             blackdetect             dialoguenhance          hqdn3d                  overlay_opencl          showpalette             vaguedenoiser
alatency                blackframe              dilation                hqx                     overlay_vaapi           showspatial             varblur
alimiter                blend                   dilation_opencl         hstack                  overlay_vulkan          showspectrum            vectorscope
allpass                 blend_vulkan            displace                hsvhold                 owdenoise               showspectrumpic         vflip
allrgb                  blockdetect             dnn_classify            hsvkey                  pad                     showvolume              vflip_vulkan
allyuv                  blurdetect              dnn_detect              hue                     pad_opencl              showwaves               vfrdet
aloop                   bm3d                    dnn_processing          huesaturation           pal100bars              showwavespic            vibrance
alphaextract            boxblur                 doubleweave             hwdownload              pal75bars               shuffleframes           vibrato
alphamerge              boxblur_opencl          drawbox                 hwmap                   palettegen              shufflepixels           vidstabdetect
amerge                  bwdif                   drawgraph               hwupload                paletteuse              shuffleplanes           vidstabtransform
ametadata               cas                     drawgrid                hwupload_cuda           pan                     sidechaincompress       vif
amix                    cellauto                drawtext                hysteresis              perms                   sidechaingate           vignette
amovie                  channelmap              drmeter                 identity                perspective             sidedata                virtualbass
amplify                 channelsplit            dynaudnorm              idet                    phase                   sierpinski              vmafmotion
amultiply               chorus                  earwax                  il                      photosensitivity        signalstats             volume
anequalizer             chromaber_vulkan        ebur128                 inflate                 pixdesctest             signature               volumedetect
anlmdn                  chromahold              edgedetect              interlace               pixelize                silencedetect           vstack
anlmf                   chromakey               elbg                    interleave              pixscope                silenceremove           w3fdif
anlms                   chromakey_cuda          entropy                 join                    pp                      sinc                    waveform
anoisesrc               chromanr                epx                     kerndeint               pp7                     sine                    weave
anull                   chromashift             eq                      kirsch                  premultiply             siti                    xbr
anullsink               ciescope                equalizer               lagfun                  prewitt                 smartblur               xcorrelate
anullsrc                codecview               erosion                 latency                 prewitt_opencl          smptebars               xfade
apad                    color                   erosion_opencl          lenscorrection          procamp_vaapi           smptehdbars             xfade_opencl
aperms                  colorbalance            estdif                  life                    program_opencl          sobel                   xmedian
aphasemeter             colorchannelmixer       exposure                limitdiff               pseudocolor             sobel_opencl            xstack
aphaser                 colorchart              extractplanes           limiter                 psnr                    sofalizer               yadif
aphaseshift             colorcontrast           extrastereo             loop                    pullup                  spectrumsynth           yadif_cuda
apsyclip                colorcorrect            fade                    loudnorm                qp                      speechnorm              yaepblur
apulsator               colorhold               feedback                lowpass                 random                  split                   yuvtestsrc
arealtime               colorize                fftdnoiz                lowshelf                readeia608              spp                     zoompan
aresample               colorkey                fftfilt                 lumakey                 readvitc                sr
areverse                colorkey_opencl         field                   lut                     realtime                ssim
arnndn                  colorlevels             fieldhint               lut1d                   remap                   stereo3d
asdr                    colormap                fieldmatch              lut2                    remap_opencl            stereotools
asegment                colormatrix             fieldorder              lut3d                   removegrain             stereowiden

Enabled bsfs:
aac_adtstoasc           dts2pts                 h264_metadata           imx_dump_header         mpeg4_unpack_bframes    prores_metadata         vp9_metadata
av1_frame_merge         dump_extradata          h264_mp4toannexb        mjpeg2jpeg              noise                   remove_extradata        vp9_raw_reorder
av1_frame_split         dv_error_marker         h264_redundant_pps      mjpega_dump_header      null                    setts                   vp9_superframe
av1_metadata            eac3_core               hapqa_extract           mov2textsub             opus_metadata           text2movsub             vp9_superframe_split
chomp                   extract_extradata       hevc_metadata           mp3_header_decompress   pcm_rechunk             trace_headers
dca_core                filter_units            hevc_mp4toannexb        mpeg2_metadata          pgs_frame_merge         truehd_core

Enabled indevs:
alsa                    lavfi                   oss                     sndio                   xcbgrab
fbdev                   libcdio                 pulse                   v4l2

Enabled outdevs:
alsa                    fbdev                   oss                     sdl2                    v4l2
caca                    opengl                  pulse                   sndio                   xv

License: nonfree and unredistributable
```

Resulting in `ffbuild/config.sh` with contents:
```bash
# Automatically generated by configure - do not modify!
shared=yes
build_suffix=
prefix=/opt
libdir=${prefix}/lib
incdir=${prefix}/include
rpath=
source_path=.
LIBPREF=lib
LIBSUF=.a
extralibs_avutil="-pthread -lva-drm -lva -lva-x11 -lva -lvdpau -lX11 -lm -lOpenCL -lva -latomic -lX11"
extralibs_avcodec="-lvpx -lm -lvpx -lm -lvpx -lm -lvpx -lm -lwebpmux -lwebp -pthread -lm -latomic -llzma -laribb24 -ldav1d -ldavs2 -lrsvg-2 -lm -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0 -lcairo -laom -lfdk-aac -lmp3lame -lm -lopus -lspeex -lvorbis -lvorbisenc -lwebp -lz -lva"
extralibs_avformat="-lm -latomic -lbluray -lz -lssl -lcrypto -lsrt-gnutls -lssh"
extralibs_avdevice="-lm -latomic -lxcb -lxcb-shm -lxcb-shape -lxcb-xfixes -lcdio_paranoia -lcdio_cdda -lcdio -lm -lasound -lcaca -lGL -lpulse -pthread -lSDL2 -lsndio -lv4l2 -lXv -lX11 -lXext"
extralibs_avfilter="-pthread -lm -latomic -lpocketsphinx -lsphinxbase -lsphinxad -lrubberband -lsamplerate -lstdc++ -lmysofa -lflite_cmu_time_awb -lflite_cmu_us_awb -lflite_cmu_us_kal -lflite_cmu_us_kal16 -lflite_cmu_us_rms -lflite_cmu_us_slt -lflite_usenglish -lflite_cmulex -lflite -lfribidi -ltesseract -larchive -lass -lnppig -lnppicc -lnppc -lnppidei -lnppif -lva -lglslang -lMachineIndependent -lOSDependent -lHLSL -lOGLCompiler -lGenericCodeGen -lSPVRemapper -lSPIRV -lSPIRV-Tools-opt -lSPIRV-Tools -lpthread -lstdc++ -lm -lvidstab -lm -lgomp -lOpenCL -lfontconfig -lfreetype -lfreetype"
extralibs_postproc="-lm -latomic"
extralibs_swscale="-lm -latomic"
extralibs_swresample="-lm -lsoxr -latomic"
avdevice_deps="avfilter swscale postproc avformat avcodec swresample avutil"
avfilter_deps="swscale postproc avformat avcodec swresample avutil"
swscale_deps="avutil"
postproc_deps="avutil"
avformat_deps="avcodec swresample avutil"
avcodec_deps="swresample avutil"
swresample_deps="avutil"
avutil_deps=""
```

If this script is making your life harder rather than easier, quit using it. :)
