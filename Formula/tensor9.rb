# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew trust tensor9ine/tensor9 && brew install tensor9
#          (Homebrew 7+ loads formulae from third-party taps only after `brew trust`)
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_11_07_01_17_972861d5"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_11_07_01_17_972861d5.tar.gz"
      sha256 "972861d52620c77b1a9ca3c7680a0e1eb6b0f0814f32f547c088a265d304c941"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_11_07_01_18_01127267.tar.gz"
      sha256 "011272670804346962dff4274847ac177036c2744ce1b13e18200c8d550375ab"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_11_07_01_19_967e272c.tar.gz"
      sha256 "967e272cf2997011b88a8a45f9be640629150e1f7b8c18e76b8f5ac6db24f7b6"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_11_07_01_19_51746b5c.tar.gz"
      sha256 "51746b5c71722405ba455383b3c05fd1c061f22a10687558a2763672ccbedc75"
    end
  end

  def install
    # The tarball extracts to tensor9-{platform}_{arch}/
    # containing: bin/tensor9, lib/t9min-*.jar, jre/

    # Install entire bundle to libexec (Homebrew convention for private deps)
    libexec.install Dir["*"]

    # Create wrapper script that calls the bundled launcher
    bin.write_exec_script libexec/"bin/tensor9"
  end

  def caveats
    <<~EOS
      tensor9 has been installed with a bundled Java runtime.
      No separate Java installation is required.

      Get started:
        tensor9 --help

      Shell completions (optional):
        tensor9 completion --help

      Configuration is stored in:
        ~/.tensor9/
    EOS
  end

  test do
    assert_match "tensor9", shell_output("#{bin}/tensor9 --help")
  end
end
