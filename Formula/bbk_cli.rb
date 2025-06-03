class BbkCli < Formula
  desc "Unofficial formula for Bredbandskollen CLI"
  homepage "https://github.com/dotse/bbk"
  url "https://github.com/dotse/bbk.git",
    revision: "4d4fc98dce5c9534511b7d83b5e310487fa95247"
  version "1.2"
  license "MIT"
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
