class Libiio < Formula
  desc "Library for interfacing with local and remote Linux IIO devices"
  homepage "https://analogdevicesinc.github.io/libiio/"
  url "https://github.com/analogdevicesinc/libiio/archive/v0.24.tar.gz"
  sha256 "a2b5d848531ea64fd9f95327dfd5a588bd227d9577281ec375e822702c6a52d5"
  license "LGPL-2.1"
  head "https://github.com/analogdevicesinc/libiio.git"

  depends_on "cmake" => :build

  depends_on "libserialport"
  depends_on "libusb"

  uses_from_macos "libxml2"

  def install
    mkdir "build" do
      cmake_args = [
        "-DOSX_INSTALL_FRAMEWORKSDIR=#{frameworks}",
        "-DOSX_PACKAGE=OFF",
        "-DPYTHON_BINDINGS=ON",
      ]
      system "cmake", "..", *cmake_args, *std_cmake_args
      system "make"
      system "make", "install"
    end

    Dir.glob("#{frameworks}/iio.framework/Tools/*").each do |exec|
      bin.install_symlink exec if File.executable?(exec)
    end
  end

  test do
    system "#{bin}/iio_info", "--help"
  end
end
