# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew trust tensor9ine/tensor9 && brew install tensor9
#          (Homebrew 7+ loads formulae from third-party taps only after `brew trust`)
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_10_25_12_14_bbbffe37"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_10_25_12_14_bbbffe37.tar.gz"
      sha256 "bbbffe37b16e0d9e6f1fccb0052457e476b231a60ae9bbf9dcfc070b9f5b5310"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_10_25_12_19_d8006be1.tar.gz"
      sha256 "d8006be107d57bfab36d6c1927d10ecc0cc4ab40e669120e6930000533d296f7"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_10_25_12_10_30833e6b.tar.gz"
      sha256 "30833e6bd90a9748c3da59b57a5198358f1b38c1a1658fd9ee0823f062ae23dc"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_10_25_12_06_010886fb.tar.gz"
      sha256 "010886fb62fc7809b10655110d892332a6243a703c13240ac67609007fb6bc25"
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
