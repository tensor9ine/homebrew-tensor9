# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew install tensor9
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_10_10_05_13_2e25b903"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_10_10_05_13_2e25b903.tar.gz"
      sha256 "2e25b90322f02828a6af558632f203d58aecc706097102f95c4a2b96314bb86d"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_10_10_05_16_a41d3119.tar.gz"
      sha256 "a41d3119773d403e67fa18a4d89c82340128fae8b10f79a4709695227cc86327"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_10_10_05_19_08a75573.tar.gz"
      sha256 "08a755731264b951a38f18161659e18e0873bab6ddb3b8aa8756e2b9230c9db3"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_10_10_05_22_5bbde154.tar.gz"
      sha256 "5bbde15457f14d55384d1579d6a41cfd7ca19ae94d329ccead1ce1b358667978"
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
