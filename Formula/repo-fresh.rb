class RepoFresh < Formula
  desc "Keep local git repos fast-forwarded to their upstreams on a schedule"
  homepage "https://github.com/matthue-lee/repo-fresh"
  url "https://github.com/matthue-lee/repo-fresh/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "682e210d9e59352448ff1719c70ea0026b7e2008c113f35be9b65dc79722fd84"
  license "MIT"

  depends_on :macos

  def install
    libexec.install "repo-fresh", "repo-fresh.sh",
                    "com.local.repo-fresh.plist.template",
                    "install.sh", "uninstall.sh"
    # Wrap the CLI so it finds the worker Homebrew placed under libexec.
    (bin/"repo-fresh").write_env_script libexec/"repo-fresh",
      RF_WORKER: libexec/"repo-fresh.sh"
  end

  # Runs the fast-forward sweep daily at 07:00 via `brew services`.
  service do
    run [opt_libexec/"repo-fresh.sh"]
    run_type :cron
    cron "0 7 * * *"
    # Homebrew defaults RunAtLoad to true; keep it off so sweeps happen only on
    # the schedule or via `repo-fresh run`, never silently on login/start.
    run_at_load false
  end

  def caveats
    <<~EOS
      Track some repos, then start the scheduled daily sweep:
        repo-fresh add /path/to/repo
        brew services start repo-fresh      # runs daily at 07:00

      Check state or run immediately:
        repo-fresh status
        repo-fresh run

      The Homebrew install runs on a fixed daily 07:00 schedule. For a custom
      hour or interval, install from source instead of Homebrew (see the
      README) — use one method, not both, or two schedulers would double up.
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/repo-fresh --help")
    assert_match "no such directory", shell_output("#{bin}/repo-fresh add /nope 2>&1", 1)
  end
end
