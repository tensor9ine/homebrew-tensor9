# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew tap tensor9ine/tensor9 && brew install tensor9
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026_03_31_09_02_458309ca"
  license :cannot_represent

  # Multi-architecture support - bundled JRE tar.gz archives
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_03_31_09_02_458309ca.tar.gz"
      sha256 "458309ca3708f89b88dd415b3ebb7a35c75f196b66431d03416dbeb90072e1d8"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-2026_03_31_09_02_458309ca.tar.gz"
      sha256 "794034703cb3434c42cb3c6ba5060a1605f9f8a82e4e2bddbd982c53d94e37bc"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-2026_03_31_09_02_458309ca.tar.gz"
      sha256 "b9cf8e5afcea6fe23e0a8c428d8b3c6aea013552dbda0cfc15d9d8731212f7a6"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-2026_03_31_09_02_458309ca.tar.gz"
      sha256 "6788794be93c2fe6fdcb76f0b33b56e1e45cb57afac20fbc98ebb7c3c9509ef2"
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
