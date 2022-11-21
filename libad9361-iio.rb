class Libad9361Iio < Formula
  desc "IIO AD9361 library for filter design and handling, multi-chip sync, etc."
  homepage "https://analogdevicesinc.github.io/libad9361-iio/"
  url "https://github.com/analogdevicesinc/libad9361-iio/archive/refs/heads/2021_R2.zip"
  sha256 "bccc570b6d21fb8fc64c170fbabc8ca5d7b9f212dcd39157b3746f7097465202"
  license "LGPL-2.1"
  head "https://github.com/analogdevicesinc/libad9361-iio.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "libiio"

  patch :DATA

  def install
    mkdir "build" do
      cmake_args = [
        "-DOSX_PACKAGE=OFF",
        "-D__APPLE__=0",
      ]
      system "cmake", "..", *cmake_args, *std_cmake_args
      system "make"
      system "make", "install"
    end

    # For some reason they install a framework in lib/
    frameworks.install_symlink lib/"ad9361.framework"
  end

end
__END__
diff --git a/test/auto_rate_test_hw.c b/test/auto_rate_test_hw.c
index af9bae3..2fac59c 100644
--- a/test/auto_rate_test_hw.c
+++ b/test/auto_rate_test_hw.c
@@ -8,11 +8,7 @@
 #include <string.h>
 #include <errno.h>

-#ifdef __APPLE__
-#include <iio/iio.h>
-#else
 #include <iio.h>
-#endif

 #define RATE_TOLERANCE_HZ 2

diff --git a/test/filter_designer_hw.c b/test/filter_designer_hw.c
index 395f5e3..5691f2d 100644
--- a/test/filter_designer_hw.c
+++ b/test/filter_designer_hw.c
@@ -7,11 +7,7 @@
 #include <stdlib.h>
 #include <string.h>

-#ifdef __APPLE__
-#include <iio/iio.h>
-#else
 #include <iio.h>
-#endif

 int main(void)
 {
diff --git a/test/fmcomms5_sync_test.c b/test/fmcomms5_sync_test.c
index 5dd3807..b7367e3 100644
--- a/test/fmcomms5_sync_test.c
+++ b/test/fmcomms5_sync_test.c
@@ -3,11 +3,7 @@
 #include <math.h>
 #include <stdbool.h>
 #include <stdio.h>
-#ifdef __APPLE__
-#include <iio/iio.h>
-#else
 #include <iio.h>
-#endif
 #include <stdlib.h>
 #include <stdint.h>
 #include <string.h>
