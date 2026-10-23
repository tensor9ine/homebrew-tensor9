# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew trust tensor9ine/tensor9 && brew install tensor9
#          (Homebrew 7+ loads formulae from third-party taps only after `brew trust`)
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_10_23_18_05_f4f1961c"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_10_23_18_05_f4f1961c.tar.gz"
      sha256 "f4f1961c9f1928e9beabe1275c6f7df6a1b65f98e8e1ec3a6881eeeb0e40f5d3"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_10_23_18_10_b8f83867.tar.gz"
      sha256 "b8f838673d8247bf653d406571b8580249ec973415631a6ee4b867f8eef9e461"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_10_23_18_14_d14f39d4.tar.gz"
      sha256 "d14f39d45f3f8adfcf28002362ed5330d92c175fcc5d7fcc24e56de6653e8a73"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_10_23_18_18_b00b2060.tar.gz"
      sha256 "b00b20607f591747287074bef47e85a61703ce1c69553802b1bed6d742261636"
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
