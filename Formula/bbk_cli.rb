class BbkCli < Formula
  desc "Unofficial formula for Bredbandskollen CLI"
  homepage "https://github.com/dotse/bbk"
  url "https://github.com/dotse/bbk/archive/3180567c5830c82c991a8059692d8fc3725df7cd.tar.gz"
  version "1.1"
  sha256 "0158403c6c822e6843aa25543ac977934e34398ddfbc6509dcc12747937d97ee"
  license "GPL-2.0-or-later"

  depends_on "gnutls"

  def install
    chdir "src/cli" do
      system "make", "GNUTLS=1"
      bin.install "cli" => "bbk_cli"
    end
  end

  test do
    assert_match "Bredbandskollen ", shell_output("#{bin}/bbk_cli --version", 1)
  end
end
