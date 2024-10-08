class BbkCli < Formula
  desc "Unofficial formula for Bredbandskollen CLI"
  homepage "https://github.com/dotse/bbk"
  url "https://github.com/dotse/bbk.git",
    revision: "1a5f2870b48c3ec85be1c45c397992a218b0af77"
  version "1.2"
  license "MIT"
  depends_on "gnutls"

  # update version string to match release tag
  patch :DATA

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
