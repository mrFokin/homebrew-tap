class Wgplex < Formula
  desc "Run several WireGuard tunnels at once with rule-based routing"
  homepage "https://github.com/mrFokin/wgplex"
  url "https://github.com/mrFokin/wgplex/releases/download/v0.1.0/wgplex-0.1.0-darwin-universal.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/wgplex"
    pkgshare.install "share/wgplex/wgplex.yaml"
  end

  post_install_steps do
    unless_path_exists "wgplex", base: :etc do
      mkdir_p "wgplex", base: :etc
      copy "wgplex.yaml", "wgplex/wgplex.yaml", source_base: :pkgshare, target_base: :etc
      set_permissions "wgplex", "0700", base: :etc, recursive: false
      set_permissions "wgplex/wgplex.yaml", "0600", base: :etc, recursive: false
    end
    mkdir_p "wgplex", base: :var
    mkdir_p "log/wgplex", base: :var
    mkdir_p "run", base: :var
  end

  service do
    run [opt_bin/"wgplex", "daemon"]
    require_root true
    keep_alive successful_exit: false
    log_path var/"log/wgplex/wgplex.log"
    error_log_path var/"log/wgplex/wgplex.log"
  end

  def caveats
    <<~EOS
      Start the daemon as root, keeping your ownership of the formula files:
        sudo brew services start --sudo-service-user=root wgplex
      Ignore the "brew services start" hint Homebrew prints below: it lacks
      --sudo-service-user=root.
      Pass --sudo-service-user=root to every start and restart; without it
      brew makes root the owner of the formula files, and later brew upgrade,
      cleanup and uninstall leave files behind or fail.

      brew upgrade does not restart the daemon. After an upgrade run:
        sudo brew services restart --sudo-service-user=root wgplex

      Manage the service only with sudo: brew services without sudo
      controls a separate per-user copy, not the root daemon.

      Config: #{etc}/wgplex/wgplex.yaml, tunnel *.conf files next to it.
      Check it with: wgplex check

      The daemon runs as root the binary from #{HOMEBREW_PREFIX},
      which your user owns: anyone who can write there can run code as root.

      To uninstall, stop the service first:
        sudo brew services stop wgplex
        brew uninstall wgplex
    EOS
  end

  test do
    assert_match(/^wgplex #{Regexp.escape(version.to_s)}$/, shell_output("#{bin}/wgplex version"))
    cp pkgshare/"wgplex.yaml", testpath/"wgplex.yaml"
    chmod 0700, testpath
    chmod 0600, testpath/"wgplex.yaml"
    system bin/"wgplex", "check", "-config", testpath
  end
end
