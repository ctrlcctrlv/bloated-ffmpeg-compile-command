#!/bin/bash
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
# This compiles a very featureful ("""bloated""") ffmpeg.
# Place in root of <https://git.ffmpeg.org/ffmpeg.git> HEAD.
# Run in lieu of ./configure.
set -x

NVIDIASHIT=(
    '--enable-shared' '--enable-nvenc' '--enable-nvdec' '--enable-nonfree' '--enable-cuda-nvcc' '--enable-libnpp' 
    '--extra-cflags=-I/usr/local/cuda/include' '--extra-ldflags=-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec'
)

if [[ -n $DOGIT ]]; then git pull && git reset --hard; fi
GIT_CHANGES=`git diff-index --name-only HEAD --`
for f in *.patch; do
    if ! (git diff-index --name-only HEAD -- | grep `basename --suffix=.patch "$f"`); then
        git apply --verbose "$f";
    fi
done

(hash nvidia-smi && test ! -e /opt/include/ffnvcodec/nvEncodeAPI.h) && ( \
    >&2 echo "Will install nv-codec-headers to /opt in 1s" && sleep 1 && \
    TEMPDIR=`mktemp -d --suffix=_nvidia_codec_headers_git` && \
    git clone 'https://git.videolan.org/git/ffmpeg/nv-codec-headers.git' "$TEMPDIR" && \
    pushd . && \
    cd "$TEMPDIR" && \
    make PREFIX=/opt install &&
    popd;
)

hash nvidia-smi || unset NVIDIASHIT

# I generated the below command from:
#
#   $ PKGS=`cat /var/log/dpkg.log.1 /var/log/dpkg.log|grep ' install '|grep -E '\bdev'\
#       |grep -v -E '\-perl\b|opencv|python|fcitx5|mono(-|sgen)|hunspell|linux|dpkg'\
#       '|manpages'|awk '{print $4}'|sed 's/:.*$//'|tr '\n' ' '`
#   $ echo "sudo apt install $PKGS"
# 
# Do you need them all? Almost assuredly not. But worrying about bloat is not
# something I have time for, neither should you :-)
#
# (SDL2 is needed for ffplay)
#######################################
if [[ -n $APT_INSTALL ]]; then
    sudo apt install libc-dev-bin libcrypt-dev libtirpc-dev libnsl-dev libc6-dev libgcc-11-dev \
        libstdc++-11-dev libtss2-tcti-device0 icu-devtools libc-devtools libffi-dev libglib2.0-dev-bin uuid-dev \
        libblkid-dev libsepol-dev libpcre2-dev libmount-dev libpcre3-dev zlib1g-dev libglib2.0-dev libostree-dev \
        libicu-dev libxml2-dev libflatpak-dev libssl-dev libuv1-dev libnode-dev autotools-dev libltdl-dev \
        libdvdcss-dev libnuma-dev x11proto-dev libxau-dev libxdmcp-dev xtrans-dev libpthread-stubs0-dev \
        libxcb1-dev libx11-dev libglx-dev libgl-dev libglvnd-core-dev libegl-dev libgles-dev libopengl-dev \
        libglvnd-dev libgl1-mesa-dev libglu1-mesa-dev x11proto-xext-dev libxext-dev libice-dev libsm-dev libxt-dev \
        freeglut3-dev libxmu-dev libgcc-10-dev libstdc++-10-dev libcub-dev libnvidia-ml-dev libvdpau-dev \
        libcupti-dev libthrust-dev nvidia-cuda-dev ocl-icd-opencl-dev nvidia-opencl-dev libnvidia-ml-dev \
        nvidia-cuda-dev libcurl4-gnutls-dev libgmp-dev libidn2-dev libp11-kit-dev libtasn1-6-dev nettle-dev \
        libgnutls28-dev libaom-dev libbrotli-dev libexpat1-dev libpng-dev libfreetype-dev libfreetype6-dev \
        libfontconfig-dev libfontconfig1-dev libfribidi-dev libgraphite2-dev libharfbuzz-dev libass-dev \
        libdav1d-dev libfdk-aac-dev libmp3lame-dev libopus-dev libgav1-dev libogg-dev libvorbis-dev libvpx-dev \
        libdeflate-dev libjpeg-turbo8-dev libjpeg8-dev libjpeg-dev libjbig-dev liblzma-dev libtiff-dev \
        libgdk-pixbuf-2.0-dev libatk1.0-dev libdbus-1-dev libxfixes-dev x11proto-input-dev libxi-dev \
        x11proto-record-dev libxtst-dev libatspi2.0-dev libatk-bridge2.0-dev libxrender-dev libpixman-1-dev \
        libxcb-render0-dev libxcb-shm0-dev libcairo2-dev libdatrie-dev libegl1-mesa-dev libepoxy-dev libthai-dev \
        libxft-dev libpango1.0-dev libwayland-dev libxcomposite-dev libxcursor-dev libxdamage-dev \
        x11proto-xinerama-dev libxinerama-dev libxkbcommon-dev x11proto-randr-dev libxrandr-dev libgtk-3-dev \
        libspiro-dev libstdc++-10-dev libcub-dev libnvidia-ml-dev libvdpau-dev libcupti-dev libthrust-dev \
        nvidia-cuda-dev ocl-icd-opencl-dev nvidia-opencl-dev libnunit-cil-dev libmpv-dev libnvidia-ml-dev \
        nvidia-cuda-dev nvidia-cuda-toolkit libgcc-9-dev libstdc++-9-dev libwebp-dev libigdgmm-dev \
        libva-dev libarchive-dev libleptonica-dev libtesseract-dev libavutil-dev libswresample-dev libavcodec-dev \
        libavformat-dev libraw1394-dev libdc1394-dev libexif-dev libgdcm-dev libgphoto2-dev libilmbase-dev \
        libtbb-dev libopenexr-dev libswscale-dev libudfread-dev libbluray-dev libspeex-dev librsvg2-dev \
        liblcms2-dev libvulkan-dev libplacebo-dev libdevil-dev libssh-dev libv4l-dev libpulse-dev libslang2-dev \
        libcaca-dev libxcb-shape0-dev libxcb-xfixes0-dev libpciaccess-dev libdrm-dev libdavs2-dev \
        frei0r-plugins-dev libaribb24-dev libcdio-dev glslang-dev libvidstab-dev liblensfun-dev libnspr4-dev \
        libnss3-dev libpcap0.8-dev libsrtp2-dev libsrt-gnutls-dev libcdio-cdda-dev \
        libcdio-paranoia-dev libsoxr-dev libsphinxbase-dev libpocketsphinx-dev librubberband-dev libmysofa-dev \
        flite1-dev libsdl2-dev nasm yasm
fi

ncols=$(/bin/bash -c 'tput cols') PKG_CONFIG_PATH='/opt/lib/pkgconfig' ./configure \
    \
    --prefix=/opt \
    \
    "${NVIDIASHIT[@]}" \
    \
    --enable-filter=stereo3d,asr,sofalizer \
    \
    --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame \
    --enable-libopus --enable-libdav1d --enable-libvorbis --enable-libvpx --enable-nonfree --enable-vaapi \
    --enable-opencl --enable-opengl --enable-libtesseract --enable-libwebp --enable-openssl \
    --enable-libfontconfig --enable-libbluray --enable-libv4l2 --enable-libfribidi --enable-libspeex \
    --enable-librsvg --enable-libssh --enable-libpulse --enable-libcaca --enable-librubberband \
    --enable-libxcb-xfixes --enable-libdavs2 --enable-frei0r --enable-libcdio --enable-libvidstab \
    --enable-libsrt --enable-libglslang --enable-libsoxr --enable-pocketsphinx --enable-libflite \
    \
    --enable-gpl \
    \
    --enable-libaribb24 --enable-version3 \
    \
    --enable-libmysofa \
    \
    --enable-ffplay --disable-stripping --enable-debug | tee config_stdout.txt

set +x
