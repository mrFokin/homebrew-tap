cask "wgplex-app" do
  version "0.1.1"
  sha256 "464cc57819560535e16d06836e8f08178355128379ed9537ee436eba5d42c64f"

  url "https://github.com/mrFokin/wgplex-app/releases/download/v#{version}/Wgplex-#{version}.dmg"
  name "Wgplex"
  desc "Menu bar client for the wgplex WireGuard engine"
  homepage "https://github.com/mrFokin/wgplex-app"

  depends_on formula: "mrfokin/tap/wgplex"
  depends_on macos: :ventura

  app "Wgplex.app"

  zap trash: "~/Library/Preferences/io.github.mrfokin.wgplex.plist"
end
