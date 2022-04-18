# Bloated `ffmpeg` compile command

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
#                                      ██ ███                           .
#            ███  ███  ███████  █████  ▒▒ ▒██  ███  ████                M
#           ██▒▒ ██▒██ ██▒██▒██ ▒██▒██ ██ ▒██ ██▒██ ██▒██               A
#           ██   ██▒██ ██▒██▒██ ▒██▒██ ██ ▒██ ████▒ ██                  P
#           ██   ██▒██ ██▒██▒██  ██▒██ ██ ▒██ ██▒▒  ██                  A
#           ▒███ ▒███▒ ██▒██▒███ ████  ██ ▒██ ▒███  ███                 C
#            ▒▒▒  ▒▒▒  ▒▒ ▒▒ ▒▒▒ ██▒▒  ▒▒ ▒▒▒  ▒▒▒  ▒▒▒                 H
#                               ███                                     E
#                               ▒▒▒                                     🦝
#                                                                       🎈
#########################################################################
```

What it says on the tin.

A friend saw my absurd `ffmpeg` invocation banner:

```
ffmpeg version N-106625-g4e98cc29f4 Copyright (c) 2000-2022 the FFmpeg developers
  OwO what's this?
  configuration: --prefix=/opt --enable-shared --enable-nvenc --enable-nvdec --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags='-L/usr/local/cuda/lib64 -L/opt/include/ffnvcodec' --enable-filter='stereo3d,asr,sofalizer' --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libdav1d --enable-libvorbis --enable-libvpx --enable-nonfree --enable-vaapi --enable-opencl --enable-opengl --enable-libtesseract --enable-libwebp --enable-openssl --enable-libfontconfig --enable-libbluray --enable-libv4l2 --enable-libfribidi --enable-libspeex --enable-librsvg --enable-libssh --enable-libpulse --enable-libcaca --enable-librubberband --enable-libxcb-xfixes --enable-libdavs2 --enable-frei0r --enable-libcdio --enable-libvidstab --enable-libsrt --enable-libglslang --enable-libsoxr --enable-pocketsphinx --enable-libflite --enable-gpl --enable-avisynth --enable-libaribb24 --enable-version3 --enable-libmysofa --enable-ffplay --disable-stripping --enable-debug
  libavutil      57. 24.101 / 57. 24.101
  libavcodec     59. 26.100 / 59. 26.100
  libavformat    59. 22.100 / 59. 22.100
  libavdevice    59.  6.100 / 59.  6.100
  libavfilter     8. 33.100 /  8. 33.100
  libswscale      6.  6.100 /  6.  6.100
  libswresample   4.  6.100 /  4.  6.100
  libpostproc    56.  5.100 / 56.  5.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
```

And wanted to know how I got it. This version of ffmpeg has all of [these abilities](https://github.com/ctrlcctrlv/bloated-ffmpeg-compile-command/blob/main/doc/config_stdout.txt).

# Effects
You will need to create `/opt` if it's not a directory you use.

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
1. --enable-avisynth
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

## Debugging help
And applies these:
1. --enable-ffplay
1. --disable-stripping
1. --enable-debug

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
x86 assembler             yasm
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
xmllint enabled           yes

External libraries:
avisynth                libass                  libdavs2                libfribidi              libopus                 libspeex                libvidstab              libxcb_shape            openssl
frei0r                  libbluray               libfdk_aac              libglslang              libpulse                libsrt                  libvorbis               libxcb_shm              pocketsphinx
iconv                   libcaca                 libflite                liblensfun              librsvg                 libssh                  libvpx                  libxcb_xfixes           zlib
libaom                  libcdio                 libfontconfig           libmp3lame              librubberband           libtesseract            libwebp                 lzma
libaribb24              libdav1d                libfreetype             libmysofa               libsoxr                 libv4l2                 libxcb                  opengl

External libraries providing hardware acceleration:
cuda                    cuda_nvcc               ffnvcodec               nvdec                   opencl                  vaapi
cuda_llvm               cuvid                   libnpp                  nvenc                   v4l2_m2m                vdpau

Libraries:
avcodec                 avdevice                avfilter                avformat                avutil                  postproc                swresample              swscale

Programs:
ffmpeg                  ffprobe

Enabled decoders:
aac                     adpcm_yamaha            cljr                    fmvc                    libaribb24              msnsiren                pcm_u32le               siren                   vmdaudio
aac_fixed               adpcm_zork              cllc                    fourxm                  libdav1d                msp2                    pcm_u8                  smackaud                vmdvideo
aac_latm                agm                     comfortnoise            fraps                   libdavs2                msrle                   pcm_vidc                smacker                 vmnc
aasc                    aic                     cook                    frwu                    libfdk_aac              mss1                    pcx                     smc                     vorbis
ac3                     alac                    cpia                    g2m                     libopus                 mss2                    pfm                     smvjpeg                 vp3
ac3_fixed               alias_pix               cri                     g723_1                  librsvg                 msvideo1                pgm                     snow                    vp4
acelp_kelvin            als                     cscd                    g729                    libspeex                mszh                    pgmyuv                  sol_dpcm                vp5
adpcm_4xm               amrnb                   cyuv                    gdv                     libvorbis               mts2                    pgssub                  sonic                   vp6
adpcm_adx               amrwb                   dca                     gem                     libvpx_vp8              mv30                    pgx                     sp5x                    vp6a
adpcm_afc               amv                     dds                     gif                     libvpx_vp9              mvc1                    photocd                 speedhq                 vp6f
adpcm_agm               anm                     derf_dpcm               gremlin_dpcm            loco                    mvc2                    pictor                  speex                   vp7
adpcm_aica              ansi                    dfa                     gsm                     lscr                    mvdv                    pixlet                  srgc                    vp8
adpcm_argo              ape                     dfpwm                   gsm_ms                  m101                    mvha                    pjs                     srt                     vp8_cuvid
adpcm_ct                apng                    dirac                   h261                    mace3                   mwsc                    png                     ssa                     vp8_v4l2m2m
adpcm_dtk               aptx                    dnxhd                   h263                    mace6                   mxpeg                   ppm                     stl                     vp9
adpcm_ea                aptx_hd                 dolby_e                 h263_v4l2m2m            magicyuv                nellymoser              prores                  subrip                  vp9_cuvid
adpcm_ea_maxis_xa       arbc                    dpx                     h263i                   mdec                    notchlc                 prosumer                subviewer               vp9_v4l2m2m
adpcm_ea_r1             argo                    dsd_lsbf                h263p                   metasound               nuv                     psd                     subviewer1              vplayer
adpcm_ea_r2             ass                     dsd_lsbf_planar         h264                    microdvd                on2avc                  ptx                     sunrast                 vqa
adpcm_ea_r3             asv1                    dsd_msbf                h264_cuvid              mimic                   opus                    qcelp                   svq1                    wavpack
adpcm_ea_xas            asv2                    dsd_msbf_planar         h264_v4l2m2m            mjpeg                   paf_audio               qdm2                    svq3                    wcmv
adpcm_g722              atrac1                  dsicinaudio             hap                     mjpeg_cuvid             paf_video               qdmc                    tak                     webp
adpcm_g726              atrac3                  dsicinvideo             hca                     mjpegb                  pam                     qdraw                   targa                   webvtt
adpcm_g726le            atrac3al                dss_sp                  hcom                    mlp                     pbm                     qpeg                    targa_y216              wmalossless
adpcm_ima_acorn         atrac3p                 dst                     hevc                    mmvideo                 pcm_alaw                qtrle                   tdsc                    wmapro
adpcm_ima_alp           atrac3pal               dvaudio                 hevc_cuvid              mobiclip                pcm_bluray              r10k                    text                    wmav1
adpcm_ima_amv           atrac9                  dvbsub                  hevc_v4l2m2m            motionpixels            pcm_dvd                 r210                    theora                  wmav2
adpcm_ima_apc           aura                    dvdsub                  hnm4_video              movtext                 pcm_f16le               ra_144                  thp                     wmavoice
adpcm_ima_apm           aura2                   dvvideo                 hq_hqa                  mp1                     pcm_f24le               ra_288                  tiertexseqvideo         wmv1
adpcm_ima_cunning       av1                     dxa                     hqx                     mp1float                pcm_f32be               ralf                    tiff                    wmv2
adpcm_ima_dat4          av1_cuvid               dxtory                  huffyuv                 mp2                     pcm_f32le               rasc                    tmv                     wmv3
adpcm_ima_dk3           avrn                    dxv                     hymt                    mp2float                pcm_f64be               rawvideo                truehd                  wmv3image
adpcm_ima_dk4           avrp                    eac3                    iac                     mp3                     pcm_f64le               realtext                truemotion1             wnv1
adpcm_ima_ea_eacs       avs                     eacmv                   idcin                   mp3adu                  pcm_lxf                 rl2                     truemotion2             wrapped_avframe
adpcm_ima_ea_sead       avui                    eamad                   idf                     mp3adufloat             pcm_mulaw               roq                     truemotion2rt           ws_snd1
adpcm_ima_iss           ayuv                    eatgq                   iff_ilbm                mp3float                pcm_s16be               roq_dpcm                truespeech              xan_dpcm
adpcm_ima_moflex        bethsoftvid             eatgv                   ilbc                    mp3on4                  pcm_s16be_planar        rpza                    tscc                    xan_wc3
adpcm_ima_mtf           bfi                     eatqi                   imc                     mp3on4float             pcm_s16le               rscc                    tscc2                   xan_wc4
adpcm_ima_oki           bink                    eightbps                imm4                    mpc7                    pcm_s16le_planar        rv10                    tta                     xbin
adpcm_ima_qt            binkaudio_dct           eightsvx_exp            imm5                    mpc8                    pcm_s24be               rv20                    twinvq                  xbm
adpcm_ima_rad           binkaudio_rdft          eightsvx_fib            indeo2                  mpeg1_cuvid             pcm_s24daud             rv30                    txd                     xface
adpcm_ima_smjpeg        bintext                 escape124               indeo3                  mpeg1_v4l2m2m           pcm_s24le               rv40                    ulti                    xl
adpcm_ima_ssi           bitpacked               escape130               indeo4                  mpeg1video              pcm_s24le_planar        s302m                   utvideo                 xma1
adpcm_ima_wav           bmp                     evrc                    indeo5                  mpeg2_cuvid             pcm_s32be               sami                    v210                    xma2
adpcm_ima_ws            bmv_audio               exr                     interplay_acm           mpeg2_v4l2m2m           pcm_s32le               sanm                    v210x                   xpm
adpcm_ms                bmv_video               fastaudio               interplay_dpcm          mpeg2video              pcm_s32le_planar        sbc                     v308                    xsub
adpcm_mtaf              brender_pix             ffv1                    interplay_video         mpeg4                   pcm_s64be               scpr                    v408                    xwd
adpcm_psx               c93                     ffvhuff                 ipu                     mpeg4_cuvid             pcm_s64le               screenpresso            v410                    y41p
adpcm_sbpro_2           cavs                    ffwavesynth             jacosub                 mpeg4_v4l2m2m           pcm_s8                  sdx2_dpcm               vb                      ylc
adpcm_sbpro_3           ccaption                fic                     jpeg2000                mpegvideo               pcm_s8_planar           sga                     vble                    yop
adpcm_sbpro_4           cdgraphics              fits                    jpegls                  mpl2                    pcm_sga                 sgi                     vbn                     yuv4
adpcm_swf               cdtoons                 flac                    jv                      msa1                    pcm_u16be               sgirle                  vc1                     zero12v
adpcm_thp               cdxl                    flashsv                 kgv1                    mscc                    pcm_u16le               sheervideo              vc1_cuvid               zerocodec
adpcm_thp_le            cfhd                    flashsv2                kmvc                    msmpeg4v1               pcm_u24be               shorten                 vc1_v4l2m2m             zlib
adpcm_vima              cinepak                 flic                    lagarith                msmpeg4v2               pcm_u24le               simbiosis_imx           vc1image                zmbv
adpcm_xa                clearvideo              flv                     libaom_av1              msmpeg4v3               pcm_u32be               sipr                    vcr1

Enabled encoders:
a64multi                amv                     dvvideo                 huffyuv                 mpeg2_vaapi             pcm_s16le_planar        pgm                     sonic                   vp8_v4l2m2m
a64multi5               apng                    eac3                    jpeg2000                mpeg2video              pcm_s24be               pgmyuv                  sonic_ls                vp8_vaapi
aac                     aptx                    exr                     jpegls                  mpeg4                   pcm_s24daud             png                     speedhq                 vp9_vaapi
ac3                     aptx_hd                 ffv1                    libaom_av1              mpeg4_v4l2m2m           pcm_s24le               ppm                     srt                     wavpack
ac3_fixed               ass                     ffvhuff                 libfdk_aac              msmpeg4v2               pcm_s24le_planar        prores                  ssa                     webvtt
adpcm_adx               asv1                    fits                    libmp3lame              msmpeg4v3               pcm_s32be               prores_aw               subrip                  wmav1
adpcm_argo              asv2                    flac                    libopus                 msvideo1                pcm_s32le               prores_ks               sunrast                 wmav2
adpcm_g722              avrp                    flashsv                 libspeex                nellymoser              pcm_s32le_planar        qtrle                   svq1                    wmv1
adpcm_g726              avui                    flashsv2                libvorbis               opus                    pcm_s64be               r10k                    targa                   wmv2
adpcm_g726le            ayuv                    flv                     libvpx_vp8              pam                     pcm_s64le               r210                    text                    wrapped_avframe
adpcm_ima_alp           bitpacked               g723_1                  libvpx_vp9              pbm                     pcm_s8                  ra_144                  tiff                    xbm
adpcm_ima_amv           bmp                     gif                     libwebp                 pcm_alaw                pcm_s8_planar           rawvideo                truehd                  xface
adpcm_ima_apm           cfhd                    h261                    libwebp_anim            pcm_bluray              pcm_u16be               roq                     tta                     xsub
adpcm_ima_qt            cinepak                 h263                    ljpeg                   pcm_dvd                 pcm_u16le               roq_dpcm                ttml                    xwd
adpcm_ima_ssi           cljr                    h263_v4l2m2m            magicyuv                pcm_f32be               pcm_u24be               rpza                    utvideo                 y41p
adpcm_ima_wav           comfortnoise            h263p                   mjpeg                   pcm_f32le               pcm_u24le               rv10                    v210                    yuv4
adpcm_ima_ws            dca                     h264_nvenc              mjpeg_vaapi             pcm_f64be               pcm_u32be               rv20                    v308                    zlib
adpcm_ms                dfpwm                   h264_v4l2m2m            mlp                     pcm_f64le               pcm_u32le               s302m                   v408                    zmbv
adpcm_swf               dnxhd                   h264_vaapi              movtext                 pcm_mulaw               pcm_u8                  sbc                     v410
adpcm_yamaha            dpx                     hevc_nvenc              mp2                     pcm_s16be               pcm_vidc                sgi                     vbn
alac                    dvbsub                  hevc_v4l2m2m            mp2fixed                pcm_s16be_planar        pcx                     smc                     vc2
alias_pix               dvdsub                  hevc_vaapi              mpeg1video              pcm_s16le               pfm                     snow                    vorbis

Enabled hwaccels:
av1_nvdec               h264_vaapi              hevc_vdpau              mpeg1_vdpau             mpeg4_nvdec             vc1_vaapi               vp9_nvdec               wmv3_vaapi
av1_vaapi               h264_vdpau              mjpeg_nvdec             mpeg2_nvdec             mpeg4_vaapi             vc1_vdpau               vp9_vaapi               wmv3_vdpau
h263_vaapi              hevc_nvdec              mjpeg_vaapi             mpeg2_vaapi             mpeg4_vdpau             vp8_nvdec               vp9_vdpau
h264_nvdec              hevc_vaapi              mpeg1_nvdec             mpeg2_vdpau             vc1_nvdec               vp8_vaapi               wmv3_nvdec

Enabled parsers:
aac                     avs2                    dca                     dvbsub                  gif                     ipu                     mpegvideo               sbc                     vp8
aac_latm                avs3                    dirac                   dvd_nav                 gsm                     jpeg2000                opus                    sipr                    vp9
ac3                     bmp                     dnxhd                   dvdsub                  h261                    mjpeg                   png                     tak                     webp
adx                     cavsvideo               dolby_e                 flac                    h263                    mlp                     pnm                     vc1                     xbm
amr                     cook                    dpx                     g723_1                  h264                    mpeg4video              rv30                    vorbis                  xma
av1                     cri                     dvaudio                 g729                    hevc                    mpegaudio               rv40                    vp3

Enabled demuxers:
aa                      avisynth                dts                     hnm                     image_vbn_pipe          moflex                  pcm_mulaw               sbc                     tta
aac                     avr                     dtshd                   ico                     image_webp_pipe         mov                     pcm_s16be               sbg                     tty
aax                     avs                     dv                      idcin                   image_xbm_pipe          mp3                     pcm_s16le               scc                     txd
ac3                     avs2                    dvbsub                  idf                     image_xpm_pipe          mpc                     pcm_s24be               scd                     ty
ace                     avs3                    dvbtxt                  iff                     image_xwd_pipe          mpc8                    pcm_s24le               sdp                     v210
acm                     bethsoftvid             dxa                     ifv                     ingenient               mpegps                  pcm_s32be               sdr2                    v210x
act                     bfi                     ea                      ilbc                    ipmovie                 mpegts                  pcm_s32le               sds                     vag
adf                     bfstm                   ea_cdata                image2                  ipu                     mpegtsraw               pcm_s8                  sdx                     vc1
adp                     bink                    eac3                    image2_alias_pix        ircam                   mpegvideo               pcm_u16be               segafilm                vc1t
ads                     binka                   epaf                    image2_brender_pix      iss                     mpjpeg                  pcm_u16le               ser                     vividas
adx                     bintext                 ffmetadata              image2pipe              iv8                     mpl2                    pcm_u24be               sga                     vivo
aea                     bit                     filmstrip               image_bmp_pipe          ivf                     mpsub                   pcm_u24le               shorten                 vmd
afc                     bitpacked               fits                    image_cri_pipe          ivr                     msf                     pcm_u32be               siff                    vobsub
aiff                    bmv                     flac                    image_dds_pipe          jacosub                 msnwc_tcp               pcm_u32le               simbiosis_imx           voc
aix                     boa                     flic                    image_dpx_pipe          jv                      msp                     pcm_u8                  sln                     vpk
alp                     brstm                   flv                     image_exr_pipe          kux                     mtaf                    pcm_vidc                smacker                 vplayer
amr                     c93                     fourxm                  image_gem_pipe          kvag                    mtv                     pjs                     smjpeg                  vqf
amrnb                   caf                     frm                     image_gif_pipe          live_flv                musx                    pmp                     smush                   w64
amrwb                   cavsvideo               fsb                     image_j2k_pipe          lmlm4                   mv                      pp_bnk                  sol                     wav
anm                     cdg                     fwse                    image_jpeg_pipe         loas                    mvi                     pva                     sox                     wc3
apc                     cdxl                    g722                    image_jpegls_pipe       lrc                     mxf                     pvf                     spdif                   webm_dash_manifest
ape                     cine                    g723_1                  image_pam_pipe          luodat                  mxg                     qcp                     srt                     webvtt
apm                     codec2                  g726                    image_pbm_pipe          lvf                     nc                      r3d                     stl                     wsaud
apng                    codec2raw               g726le                  image_pcx_pipe          lxf                     nistsphere              rawvideo                str                     wsd
aptx                    concat                  g729                    image_pgm_pipe          m4v                     nsp                     realtext                subviewer               wsvqa
aptx_hd                 data                    gdv                     image_pgmyuv_pipe       matroska                nsv                     redspark                subviewer1              wtv
aqtitle                 daud                    genh                    image_pgx_pipe          mca                     nut                     rl2                     sup                     wv
argo_asf                dcstr                   gif                     image_photocd_pipe      mcc                     nuv                     rm                      svag                    wve
argo_brp                derf                    gsm                     image_pictor_pipe       mgsts                   obu                     roq                     svs                     xa
argo_cvg                dfa                     gxf                     image_png_pipe          microdvd                ogg                     rpl                     swf                     xbin
asf                     dfpwm                   h261                    image_ppm_pipe          mjpeg                   oma                     rsd                     tak                     xmv
asf_o                   dhav                    h263                    image_psd_pipe          mjpeg_2000              paf                     rso                     tedcaptions             xvag
ass                     dirac                   h264                    image_qdraw_pipe        mlp                     pcm_alaw                rtp                     thp                     xwma
ast                     dnxhd                   hca                     image_sgi_pipe          mlv                     pcm_f32be               rtsp                    threedostr              yop
au                      dsf                     hcom                    image_sunrast_pipe      mm                      pcm_f32le               s337m                   tiertexseq              yuv4mpegpipe
av1                     dsicin                  hevc                    image_svg_pipe          mmf                     pcm_f64be               sami                    tmv
avi                     dss                     hls                     image_tiff_pipe         mods                    pcm_f64le               sap                     truehd

Enabled muxers:
a64                     avm2                    fifo                    hds                     mjpeg                   null                    pcm_s8                  segafilm                vc1t
ac3                     avs2                    fifo_test               hevc                    mkvtimestamp_v2         nut                     pcm_u16be               segment                 voc
adts                    avs3                    filmstrip               hls                     mlp                     obu                     pcm_u16le               smjpeg                  w64
adx                     bit                     fits                    ico                     mmf                     oga                     pcm_u24be               smoothstreaming         wav
aiff                    caf                     flac                    ilbc                    mov                     ogg                     pcm_u24le               sox                     webm
alp                     cavsvideo               flv                     image2                  mp2                     ogv                     pcm_u32be               spdif                   webm_chunk
amr                     codec2                  framecrc                image2pipe              mp3                     oma                     pcm_u32le               spx                     webm_dash_manifest
amv                     codec2raw               framehash               ipod                    mp4                     opus                    pcm_u8                  srt                     webp
apm                     crc                     framemd5                ircam                   mpeg1system             pcm_alaw                pcm_vidc                stream_segment          webvtt
apng                    dash                    g722                    ismv                    mpeg1vcd                pcm_f32be               psp                     streamhash              wsaud
aptx                    data                    g723_1                  ivf                     mpeg1video              pcm_f32le               rawvideo                sup                     wtv
aptx_hd                 daud                    g726                    jacosub                 mpeg2dvd                pcm_f64be               rm                      swf                     wv
argo_asf                dfpwm                   g726le                  kvag                    mpeg2svcd               pcm_f64le               roq                     tee                     yuv4mpegpipe
argo_cvg                dirac                   gif                     latm                    mpeg2video              pcm_mulaw               rso                     tg2
asf                     dnxhd                   gsm                     lrc                     mpeg2vob                pcm_s16be               rtp                     tgp
asf_stream              dts                     gxf                     m4v                     mpegts                  pcm_s16le               rtp_mpegts              truehd
ass                     dv                      h261                    matroska                mpjpeg                  pcm_s24be               rtsp                    tta
ast                     eac3                    h263                    matroska_audio          mxf                     pcm_s24le               sap                     ttml
au                      f4v                     h264                    md5                     mxf_d10                 pcm_s32be               sbc                     uncodedframecrc
avi                     ffmetadata              hash                    microdvd                mxf_opatom              pcm_s32le               scc                     vc1

Enabled protocols:
async                   crypto                  ftp                     httpproxy               libsrt                  pipe                    rtmpt                   subfile                 udplite
bluray                  data                    gopher                  https                   libssh                  prompeg                 rtmpte                  tcp                     unix
cache                   ffrtmpcrypt             gophers                 icecast                 md5                     rtmp                    rtmpts                  tee
concat                  ffrtmphttp              hls                     ipfs                    mmsh                    rtmpe                   rtp                     tls
concatf                 file                    http                    ipns                    mmst                    rtmps                   srtp                    udp

Enabled filters:
abench                  anlms                   blackframe              deflicker               framerate               lowpass                 perspective             sharpness_vaapi         tile
abitscope               anoisesrc               blend                   deinterlace_vaapi       framestep               lowshelf                phase                   shear                   tinterlace
acompressor             anull                   bm3d                    dejudder                freezedetect            lumakey                 photosensitivity        showcqt                 tlut2
acontrast               anullsink               boxblur                 delogo                  freezeframes            lut                     pixdesctest             showfreqs               tmedian
acopy                   anullsrc                boxblur_opencl          denoise_vaapi           frei0r                  lut1d                   pixelize                showinfo                tmidequalizer
acrossfade              apad                    bwdif                   derain                  frei0r_src              lut2                    pixscope                showpalette             tmix
acrossover              aperms                  cas                     deshake                 fspp                    lut3d                   pp                      showspatial             tonemap
acrusher                aphasemeter             cellauto                deshake_opencl          gblur                   lutrgb                  pp7                     showspectrum            tonemap_opencl
acue                    aphaser                 channelmap              despill                 geq                     lutyuv                  premultiply             showspectrumpic         tonemap_vaapi
addroi                  aphaseshift             channelsplit            detelecine              gradfun                 mandelbrot              prewitt                 showvolume              tpad
adeclick                apsyclip                chorus                  dialoguenhance          gradients               maskedclamp             prewitt_opencl          showwaves               transpose
adeclip                 apulsator               chromahold              dilation                graphmonitor            maskedmax               procamp_vaapi           showwavespic            transpose_npp
adecorrelate            arealtime               chromakey               dilation_opencl         grayworld               maskedmerge             program_opencl          shuffleframes           transpose_opencl
adelay                  aresample               chromanr                displace                greyedge                maskedmin               pseudocolor             shufflepixels           transpose_vaapi
adenorm                 areverse                chromashift             dnn_classify            guided                  maskedthreshold         psnr                    shuffleplanes           treble
aderivative             arnndn                  ciescope                dnn_detect              haas                    maskfun                 pullup                  sidechaincompress       tremolo
adrawgraph              asdr                    codecview               dnn_processing          haldclut                mcompand                qp                      sidechaingate           trim
adynamicequalizer       asegment                color                   doubleweave             haldclutsrc             median                  random                  sidedata                unpremultiply
adynamicsmooth          aselect                 colorbalance            drawbox                 hdcd                    mergeplanes             readeia608              sierpinski              unsharp
aecho                   asendcmd                colorchannelmixer       drawgraph               headphone               mestimate               readvitc                signalstats             unsharp_opencl
aemphasis               asetnsamples            colorcontrast           drawgrid                hflip                   metadata                realtime                signature               untile
aeval                   asetpts                 colorcorrect            drawtext                highpass                midequalizer            remap                   silencedetect           v360
aevalsrc                asetrate                colorhold               drmeter                 highshelf               minterpolate            removegrain             silenceremove           vaguedenoiser
aexciter                asettb                  colorize                dynaudnorm              hilbert                 mix                     removelogo              sinc                    varblur
afade                   ashowinfo               colorkey                earwax                  histeq                  monochrome              repeatfields            sine                    vectorscope
afftdn                  asidedata               colorkey_opencl         ebur128                 histogram               morpho                  replaygain              siti                    vflip
afftfilt                asoftclip               colorlevels             edgedetect              hqdn3d                  movie                   reverse                 smartblur               vfrdet
afifo                   aspectralstats          colormatrix             elbg                    hqx                     mpdecimate              rgbashift               smptebars               vibrance
afir                    asplit                  colorspace              entropy                 hstack                  mptestsrc               rgbtestsrc              smptehdbars             vibrato
afirsrc                 asr                     colorspectrum           epx                     hsvhold                 msad                    roberts                 sobel                   vidstabdetect
aformat                 ass                     colortemperature        eq                      hsvkey                  negate                  roberts_opencl          sobel_opencl            vidstabtransform
afreqshift              astats                  compand                 equalizer               hue                     nlmeans                 rotate                  sofalizer               vif
afwtdn                  astreamselect           compensationdelay       erosion                 huesaturation           nlmeans_opencl          rubberband              spectrumsynth           vignette
agate                   asubboost               concat                  erosion_opencl          hwdownload              nnedi                   sab                     speechnorm              vmafmotion
agraphmonitor           asubcut                 convolution             estdif                  hwmap                   noformat                scale                   split                   volume
ahistogram              asupercut               convolution_opencl      exposure                hwupload                noise                   scale2ref               spp                     volumedetect
aiir                    asuperpass              convolve                extractplanes           hwupload_cuda           normalize               scale2ref_npp           sr                      vstack
aintegral               asuperstop              copy                    extrastereo             hysteresis              null                    scale_cuda              ssim                    w3fdif
ainterleave             atadenoise              cover_rect              fade                    identity                nullsink                scale_npp               stereo3d                waveform
alatency                atempo                  crop                    feedback                idet                    nullsrc                 scale_vaapi             stereotools             weave
alimiter                atilt                   cropdetect              fftdnoiz                il                      ocr                     scdet                   stereowiden             xbr
allpass                 atrim                   crossfeed               fftfilt                 inflate                 openclsrc               scharr                  streamselect            xcorrelate
allrgb                  avectorscope            crystalizer             field                   interlace               oscilloscope            scroll                  subtitles               xfade
allyuv                  avgblur                 cue                     fieldhint               interleave              overlay                 segment                 super2xsai              xfade_opencl
aloop                   avgblur_opencl          curves                  fieldmatch              join                    overlay_cuda            select                  superequalizer          xmedian
alphaextract            avsynctest              datascope               fieldorder              kerndeint               overlay_opencl          selectivecolor          surround                xstack
alphamerge              axcorrelate             dblur                   fifo                    kirsch                  overlay_vaapi           sendcmd                 swaprect                yadif
amerge                  bandpass                dcshift                 fillborders             lagfun                  owdenoise               separatefields          swapuv                  yadif_cuda
ametadata               bandreject              dctdnoiz                find_rect               latency                 pad                     setdar                  tblend                  yaepblur
amix                    bass                    deband                  firequalizer            lenscorrection          pad_opencl              setfield                telecine                yuvtestsrc
amovie                  bbox                    deblock                 flanger                 lensfun                 pal100bars              setparams               testsrc                 zoompan
amplify                 bench                   decimate                flite                   life                    pal75bars               setpts                  testsrc2
amultiply               bilateral               deconvolve              floodfill               limitdiff               palettegen              setrange                thistogram
anequalizer             biquad                  dedot                   format                  limiter                 paletteuse              setsar                  threshold
anlmdn                  bitplanenoise           deesser                 fps                     loop                    pan                     settb                   thumbnail
anlmf                   blackdetect             deflate                 framepack               loudnorm                perms                   sharpen_npp             thumbnail_cuda

Enabled bsfs:
aac_adtstoasc           dca_core                filter_units            hevc_metadata           mov2textsub             null                    setts                   vp9_raw_reorder
av1_frame_merge         dump_extradata          h264_metadata           hevc_mp4toannexb        mp3_header_decompress   opus_metadata           text2movsub             vp9_superframe
av1_frame_split         dv_error_marker         h264_mp4toannexb        imx_dump_header         mpeg2_metadata          pcm_rechunk             trace_headers           vp9_superframe_split
av1_metadata            eac3_core               h264_redundant_pps      mjpeg2jpeg              mpeg4_unpack_bframes    prores_metadata         truehd_core
chomp                   extract_extradata       hapqa_extract           mjpega_dump_header      noise                   remove_extradata        vp9_metadata

Enabled indevs:
fbdev                   lavfi                   libcdio                 oss                     pulse                   v4l2                    xcbgrab

Enabled outdevs:
caca                    fbdev                   opengl                  oss                     pulse                   v4l2

License: nonfree and unredistributable
config.h is unchanged
config.asm is unchanged
config_components.h is unchanged
libavutil/avconfig.h is unchanged
libavfilter/filter_list.c is unchanged
libavcodec/codec_list.c is unchanged
libavcodec/parser_list.c is unchanged
libavcodec/bsf_list.c is unchanged
libavformat/demuxer_list.c is unchanged
libavformat/muxer_list.c is unchanged
libavdevice/indev_list.c is unchanged
libavdevice/outdev_list.c is unchanged
libavformat/protocol_list.c is unchanged
ffbuild/config.sh is unchanged
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
extralibs_avcodec="-lvpx -lm -lvpx -lm -lvpx -lm -lvpx -lm -lwebpmux -lwebp -pthread -lm -latomic -llzma -laribb24 -ldav1d -ldavs2 -lrsvg-2 -lm -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0 -lcairo -laom -lm -lpthread -lfdk-aac -lmp3lame -lm -lopus -lspeex -lvorbis -lvorbisenc -lwebp -lz -lva"
extralibs_avformat="-lm -latomic -lbluray -lz -lssl -lcrypto -lsrt-gnutls -lssh"
extralibs_avdevice="-lm -latomic -lxcb -lxcb-shm -lxcb-shape -lxcb-xfixes -lcdio_paranoia -lcdio_cdda -lcdio -lm -lcaca -lGL -lpulse -pthread -lv4l2"
extralibs_avfilter="-pthread -lm -latomic -lpocketsphinx -lsphinxbase -lsphinxad -lrubberband -lstdc++ -lmysofa -lflite_cmu_time_awb -lflite_cmu_us_awb -lflite_cmu_us_kal -lflite_cmu_us_kal16 -lflite_cmu_us_rms -lflite_cmu_us_slt -lflite_usenglish -lflite_cmulex -lflite -lfribidi -llensfun -ltesseract -larchive -lass -lnppig -lnppicc -lnppc -lnppidei -lnppif -lva -lvidstab -lm -lgomp -lOpenCL -lfontconfig -lfreetype -lfreetype"
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
