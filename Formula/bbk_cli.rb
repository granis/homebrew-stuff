class BbkCli < Formula
  desc "Unofficial formula for Bredbandskollen CLI"
  homepage "https://github.com/dotse/bbk"
  url "https://github.com/dotse/bbk/archive/refs/tags/BBK_CLI_1.2.tar.gz"
  version "1.2"
  sha256 "dff38d1226844642891afcd869bfce2b9d0414c9507bacf156fb5849ab2ae8c5"
  license "GPL-2.0-or-later"

  depends_on "gnutls"

  stable do
    # update version string to match release tag
    patch :DATA
  end

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

__END__
diff --git a/src/measurement/defs.h b/src/measurement/defs.h
--- a/src/measurement/defs.h
+++ b/src/measurement/defs.h
@@ -4,5 +4,5 @@

 namespace measurement {
     extern const std::string appName;
-    const std::string appVersion = "1.1";
+    const std::string appVersion = "1.2";
     // buildVersion 15 released to App Store in 2016.
