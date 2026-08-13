class TzGuard < Formula
  desc "Reset macOS system timezone back to your home zone after a chosen hour"
  homepage "https://github.com/matthue-lee/tz-guard"
  url "https://github.com/matthue-lee/tz-guard/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8d0fae40cec97d0236de44f3137f6ce721852d4de8069515dabc651f320ab7aa"
  license "MIT"

  depends_on :macos

  # tz-guard runs as a *root* LaunchDaemon with interactive setup (home zone +
  # reset hour), so it can't be a `brew services` job. Homebrew delivers the
  # files; the bundled installer wires up the daemon (see caveats).
  def install
    libexec.install "tz-guard", "tz-guard.sh",
                    "com.local.tz-guard.plist.template",
                    "install.sh", "uninstall.sh"
  end

  def caveats
    <<~EOS
      tz-guard runs as a root LaunchDaemon and needs one-time interactive setup
      (home timezone + reset hour). Finish installing with:

        sudo #{opt_libexec}/install.sh

      That installs the `tz-guard` control command to /usr/local/bin and loads
      the daemon. Then:
        tz-guard status | pause | resume

      Uninstall the daemon with:
        sudo #{opt_libexec}/uninstall.sh
    EOS
  end

  test do
    assert_path_exists libexec/"tz-guard.sh"
    assert_path_exists libexec/"install.sh"
  end
end
