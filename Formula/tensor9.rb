# Tensor9 CLI - Deploy anywhere with Tensor9
# https://tensor9.com
#
# Install: brew install tensor9ine/homebrew/tensor9
# Update:  brew upgrade tensor9

class Tensor9 < Formula
  desc "Deploy anywhere with Tensor9 - multi-cloud deployment platform"
  homepage "https://tensor9.com"
  version "2026.02.04-9ab28221"
  license :cannot_represent

  # Multi-architecture support
  on_macos do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_arm64-2026_02_04_23_14_9ab28221"
      sha256 "9ab2822156b4946a20455f61dc7dd1ab55298c2d0149498fe66878b2ee4cfe8f"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_mac_amd64-latest"
      sha256 "PLACEHOLDER_SHA256_AMD64"
    end
  end

  on_linux do
    on_arm do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_arm64-latest"
      sha256 "PLACEHOLDER_SHA256_LINUX_ARM64"
    end
    on_intel do
      url "https://t9-artifacts-prod-1.s3.us-west-2.amazonaws.com/tensor9_linux_amd64-latest"
      sha256 "PLACEHOLDER_SHA256_LINUX_AMD64"
    end
  end

  def install
    # The downloaded file is a raw binary, rename to tensor9
    binary_name = if Hardware::CPU.arm? && OS.mac?
      "tensor9_mac_arm64-2026_02_04_23_14_9ab28221"
    elsif Hardware::CPU.intel? && OS.mac?
      "tensor9_mac_amd64-latest"
    elsif Hardware::CPU.arm? && OS.linux?
      "tensor9_linux_arm64-latest"
    elsif Hardware::CPU.intel? && OS.linux?
      "tensor9_linux_amd64-latest"
    end

    bin.install binary_name => "tensor9"
  end

  def caveats
    <<~EOS
      To get started, run:
        tensor9 setup

      For help:
        tensor9 help
    EOS
  end

  test do
    system "#{bin}/tensor9", "env"
  end
end
