# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew install tensor9
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_08_07_16_38_b5e5135c"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_08_07_16_38_b5e5135c.tar.gz"
      sha256 "b5e5135cabeba3ebec528573a63e9d6c1bde2f2e979fb98c61eba72dfef0cf1b"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_08_07_16_39_562828d5.tar.gz"
      sha256 "562828d5d4d92b3efada10ceb14f8a7b30a6b7e947ac72f88b9113c8f4c62a0f"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_08_07_16_39_8843230c.tar.gz"
      sha256 "8843230cec04b9f26d6af0ddac81b3b05b0380918a484e6d14e3d098fda28ba5"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_08_07_16_40_6b7bd856.tar.gz"
      sha256 "6b7bd85657a7c0f5fc9f413da5cbc4b815ed973827cff74eef2e2f5fe344b846"
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
