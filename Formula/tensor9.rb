# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew trust tensor9ine/tensor9 && brew install tensor9
#          (Homebrew 7+ loads formulae from third-party taps only after `brew trust`)
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_10_12_16_59_e98d56f7"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_10_12_16_59_e98d56f7.tar.gz"
      sha256 "e98d56f7029db8354173d1e738c932175d9c318785edc15d16e891b2a52b45ce"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_10_12_17_16_1022f53a.tar.gz"
      sha256 "1022f53a63a5f209c5d453ac33764048f6172da06b2ba487e4b662fe3a0d6916"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_10_12_17_16_f9d5613d.tar.gz"
      sha256 "f9d5613db48c5984819c9e98d6afd6858d0c3fd304b223b1ab99e73f237b64d1"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_10_12_17_16_71609869.tar.gz"
      sha256 "7160986938bc444938caf8b752a85be2e1918d0aba5d4efcd8ee0835d7749f00"
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
