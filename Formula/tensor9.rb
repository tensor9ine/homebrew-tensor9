# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew install tensor9
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_04_06_10_18_ff16cb6e"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_04_06_10_18_ff16cb6e.tar.gz"
      sha256 "ff16cb6ec2d621e67594004bcdb14b9e0eb69ac339127f5ff12c6e741e9127fb"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_04_06_10_19_9e4c741d.tar.gz"
      sha256 "9e4c741d353c3fc5aecaee8c3f2f10e9099e99eb68e1b1066bfea8fc064333c9"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_04_06_10_19_4daf5da0.tar.gz"
      sha256 "4daf5da0272033916c69af73386c32eaba4f0afb07ee93983d9d7f93f0c614ae"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_04_06_10_20_a53afc85.tar.gz"
      sha256 "a53afc85bced5ef791a6cbb63a756aa838c5e1b3d00c20db5c13a92974ef425e"
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
