class MinecraftOverviewer < Formula
  include Language::Python::Virtualenv

  desc "Generates maps of a minecraft-worlds"
  homepage "https://docs.overviewer.org/"
  url "https://github.com/GregoryAM-SP/The-Minecraft-Overviewer/archive/refs/tags/1.21.0.tar.gz"
  sha256 "e576bda1bdaf478eeb93ce30114acace6a3015a249c34090618ac72b5612a665"
  license "GPL-3.0-or-later"

  depends_on "numpy"
  depends_on "pillow"
  depends_on "python@3.11"

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/cd/74/ad3d526f3bf7b6d3f408b73fde271ec69dfac8b81341a318ce825f2b3812/pillow-10.4.0.tar.gz"
    sha256 "166c1cd4d24309b30d61f79f4a9114b7b2313d7450912277855ff5dfd7cd4a06"
  end

  def install
    venv = virtualenv_create(libexec, "python3.11")

    resource("pillow").stage do
      cp "./src/libImaging/Imaging.h", buildpath
      cp "./src/libImaging/ImPlatform.h", buildpath
      cp "./src/libImaging/ImagingUtils.h", buildpath
    end

    inreplace "overviewer_core/util.py", "unknown", "1.20.4"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "Minecraft Overviewer 1.20.4", shell_output("overviewer.py --version")
  end
end
