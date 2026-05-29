class Yanka < Formula
  include Language::Python::Virtualenv

  desc "Yet ANother Knowledge App — capture engineering decisions from conversation"
  homepage "https://github.com/Nambu14/yanka"
  url "https://github.com/Nambu14/yanka/releases/download/v0.3.0/yanka-0.3.0.tar.gz"
  sha256 "42248afbf2336b6a4f8eb382ff9fc04bb937b772840741d16e717a20de5003ef"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yanka --version")
  end
end
