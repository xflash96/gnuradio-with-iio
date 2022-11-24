class Sdrangel < Formula
  desc "SDRAngel"
  homepage "https://github.com/f4exb/sdrangel"
  url "https://github.com/f4exb/sdrangel/archive/refs/tags/v7.8.3.tar.gz"
  sha256 "f429718edefb7a886a923d981a8bcc12756ed9062b3be61bf6a0219c6b0eec56"
  license "GPL-3.0"
  head "https://github.com/f4exb/sdrangel.git"

  depends_on "svn" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "automake" => :build

  depends_on "numpy"
  depends_on "nasm"
  depends_on "qt@5"

  depends_on "libusb"
  depends_on "hidapi"
  depends_on "opus"
  depends_on "zlib"
  depends_on "faad2"
  depends_on "fftw"
  depends_on "boost"

  # for ffmpeg
  depends_on "x264"
  depends_on "x265"
  depends_on "fdk-aac"
  depends_on "mpg123"
  depends_on "lame"


  depends_on "opencv"
  depends_on "codec2"
  depends_on "libxml2"
  depends_on "libiio"
  
  # TODO cm256cc
  # TODO libmbe
  # TODO libserialdv
  # TODO libdsdcc
  # TODO dab
  # depends_on "hackrf"
  # depends_on "airspy"
  # depends_on "airspyhf"
  # depends_on "soapysdr"

  uses_from_macos "libxml2"

  resource "Cheetah3" do
    url "https://files.pythonhosted.org/packages/ee/6f/29c6d74d8536dede06815eeaebfad53699e3f3df0fb22b7a9801a893b426/Cheetah3-3.2.6.tar.gz"
    sha256 "f1c2b693cdcac2ded2823d363f8459ae785261e61c128d68464c8781dba0466b"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/6d/f2/8ad2ec3d531c97c4071572a4104e00095300e278a7449511bee197ca22c9/Mako-1.2.2.tar.gz"
    sha256 "3724869b363ba630a272a5f89f68c070352137b8fd1757650017b7e06fda163f"
  end

  patch :DATA

  def install
    mkdir "build" do
      cmake_args = [
        "-Wno-dev",
        "-DDEBUG_OUTPUT=ON",
        "-DENABLE_RTLSDR=OFF",
        "-DENABLE_BLADERF=OFF",
        "-DENABLE_AIRSPY=OFF",
        "-DENABLE_AIRSPYHF=OFF",
        "-DENABLE_FUNCUBE=OFF",
        "-DENABLE_HACKRF=OFF",
        "-DENABLE_IIO=ON",
        "-DENABLE_LIMESUITE=OFF",
        "-DENABLE_MIRISDR=OFF",
        "-DENABLE_PERSEUS=OFF",
        "-DENABLE_SDRPLAY=OFF",
        "-DENABLE_SOAPYSDR=OFF",
        "-DENABLE_XTRX=OFF",
        "-DENABLE_USRP=OFF",
        "-DENABLE_EXTERNAL_LIBRARIES=AUTO",
        "-DBUNDLE=ON",
        "-DRX_SAMPLE_24BIT=ON",
        "-DCMAKE_BUILD_TYPE=Release",
        "-DPKG_CONFIG_USE_CMAKE_PREFIX_PATH=TRUE",
        "-DCMAKE_PREFIX_PATH=#{Formula['qt@5'].opt_lib}",
     ]
      system "cmake", "..", *cmake_args, *std_cmake_args

      # The dependency of CMakeList isn't working in parallel mode,
      # so I build modules sequencially.
      system "make", "ffmpeg"
      system "make", "dab"
      system "make", "swagger"
      system "make", "sdrbase"
      system "make", "sdrgui"
      system "make", "-j1"
      system "make", "install"
      bin.install_symlink prefix/"sdrangel"
      bin.install_symlink prefix/"sdrangelbench"
      bin.install_symlink prefix/"sdrangelsrv"
      bin.install_symlink prefix/"ldpctool"
    end
  end

end
__END__
01:28 ~/repos/sdrangel git diff
diff --git a/external/CMakeLists.txt b/external/CMakeLists.txt
index e32fbbbe2..85133a8ba 100644
--- a/external/CMakeLists.txt
+++ b/external/CMakeLists.txt
@@ -513,7 +513,7 @@ if (NOT FFMEG_FOUND AND NOT USE_PRECOMPILED_LIBS)
             GIT_TAG n4.4.2
             DEPENDS ${X264_DEPENDS} ${X265_DEPENDS} ${OPUS_DEPENDS} ${FDK_AAC_DEPENDS} ${LAME_DEPENDS}
             PREFIX "${EXTERNAL_BUILD_LIBRARIES}/ffmpeg"
-            CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env PKG_CONFIG_PATH=${X264_PKG_CONFIG_DIR}:${X265_PKG_CONFIG_DIR}:${OPUS_PKG_CONFIG_DIR}:${FDK_AAC_PKG_CONFIG_DIR} <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --enable-shared --enable-gpl --enable-nonfree --enable-libx264 --enable-libx265 --enable-libopus --enable-libfdk-aac --enable-libmp3lame --extra-ldflags=${LAME_EXTRA_LDFLAGS} --extra-cflags=${LAME_EXTRA_CFLAGS}
+           CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env PKG_CONFIG_PATH=${X264_PKG_CONFIG_DIR}:${X265_PKG_CONFIG_DIR}:${OPUS_PKG_CONFIG_DIR}:${FDK_AAC_PKG_CONFIG_DIR}:$ENV{PKG_CONFIG_PATH} <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --enable-shared --enable-gpl --enable-nonfree --enable-libx264 --enable-libx265 --enable-libopus --enable-libfdk-aac --enable-libmp3lame --extra-ldflags=${LAME_EXTRA_LDFLAGS} --extra-cflags=${LAME_EXTRA_CFLAGS}
             BUILD_COMMAND ${MAKE}
             TEST_COMMAND ""
             )
@@ -1061,7 +1061,7 @@ if (LINUX)

 endif (LINUX)

-if (WIN32 OR APPLE)
+if (WIN32)
     if (ENABLE_RTLSDR)
         set(RTLSDR_LIBUSB_INCLUDE "${LIBUSB_INCLUDE_DIR}")
         if (WIN32)
