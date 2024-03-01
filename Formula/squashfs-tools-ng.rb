class SquashfsToolsNg < Formula
  desc "Set of tools and libraries for working with SquashFS images"
  homepage "https://github.com/AgentD/squashfs-tools-ng"
  # url "https://github.com/AgentD/squashfs-tools-ng/archive/v1.0.7.tar.gz"
  url "https://github.com/AgentD/squashfs-tools-ng.git",
    tag: "v1.0.7"
  sha256 "0d6d0324daf7a7d8ed3fa9aa07ca4f2484907617ab23b9f933e8c98c550d1fbc"
  license "GPL-3.0-or-later"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "lz4"
  depends_on "lzo"
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "zlib"

  def install
    system "./autogen.sh"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "make", "check"
  end
end
