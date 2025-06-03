class MinecraftOverviewer < Formula
  include Language::Python::Virtualenv
  desc "Generates maps of a minecraft-worlds"
  homepage "https://docs.overviewer.org/"
  url "https://github.com/GregoryAM-SP/The-Minecraft-Overviewer/archive/refs/tags/1.21.2-rc.2.tar.gz"
  sha256 "cabd6356315aed5d00a5cb37410edf365d8a925b3015bfedff535c8bfeb98cd4"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build # for numpy
  depends_on "meson" => :build # for numpy
  depends_on "ninja" => :build # for numpy
  depends_on "python-setuptools" => :build
  depends_on "pillow"
  depends_on "python@3.13"

  on_linux do
    depends_on "patchelf" => :build # for numpy
  end

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/65/6e/09db70a523a96d25e115e71cc56a6f9031e7b8cd166c1ac8438307c14058/numpy-1.26.4.tar.gz"
    sha256 "2a02aba9ed12e4ac4eb3ea9421c420301a0c6460d9830d74a9df87efa4912010"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/af/cb/bb5c01fcd2a69335b86c22142b2bccfc3464087efb7fd382eee5ffc7fdf7/pillow-11.2.1.tar.gz"
    sha256 "a64dd61998416367b7ef979b73d3a85853ba9bec4c2925f74e588879a58716b6"
  end

  def install
    venv = virtualenv_create(libexec, "python3.13")
    resource("pillow").stage do
      cp "./src/libImaging/Arrow.h", buildpath
      cp "./src/libImaging/Imaging.h", buildpath
      cp "./src/libImaging/ImPlatform.h", buildpath
      cp "./src/libImaging/ImagingUtils.h", buildpath
    end
    venv.pip_install resource("numpy")

    inreplace "overviewer_core/util.py", "unknown", "1.21.2-rc.2"
    venv.pip_install_and_link(buildpath)
  end

  test do
    assert_match(/^Minecraft Overviewer \(Prerelease\) 1.21.2-rc.2/, shell_output("overviewer.py --version"))
  end
end
