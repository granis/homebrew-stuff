class SquashfsToolsNg < Formula
  desc "Set of tools and libraries for working with SquashFS images"
  homepage "https://github.com/AgentD/squashfs-tools-ng"
  url "https://github.com/AgentD/squashfs-tools-ng.git",
    tag: "v1.3.0"
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
    if OS.mac?
      inreplace "autogen.sh",
        "$(aclocal",
        "$(aclocal --system-acdir=/opt/homebrew/share/aclocal"
    end
    system "./autogen.sh"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
    pkgshare.install "licenses"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gensquashfs --version")
    assert_match version.to_s, shell_output("#{bin}/rdsquashfs --version")
    assert_match version.to_s, shell_output("#{bin}/sqfs2tar --version")
    assert_match version.to_s, shell_output("#{bin}/tar2sqfs --version")
    assert_match version.to_s, shell_output("#{bin}/sqfsdiff --version")
  end
end
