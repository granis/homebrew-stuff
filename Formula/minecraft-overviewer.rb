class MinecraftOverviewer < Formula
  include Language::Python::Virtualenv

  desc "Generates maps of a minecraft-worlds"
  homepage "https://docs.overviewer.org/"
  url "https://github.com/GregoryAM-SP/The-Minecraft-Overviewer/archive/refs/tags/v1.20.4.tar.gz"
  sha256 "8b8e0ee8e397463310b57b1d9f7d992849d5da072bdb8360d654aded2fb0f8aa"
  license "GPL-3.0-or-later"

  depends_on "numpy"
  depends_on "pillow"
  depends_on "python@3.11"

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/f8/3e/32cbd0129a28686621434cbf17bb64bf1458bfb838f1f668262fefce145c/pillow-10.2.0.tar.gz"
    sha256 "e87f0b2c78157e12d7686b27d63c070fd65d994e8ddae6f328e0dcf4a0cd007e"
  end

  def install
    venv = virtualenv_create(libexec)

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
