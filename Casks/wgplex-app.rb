cask "wgplex-app" do
  version "0.1.0"
  sha256 "b485befe0e1697a1d8493035ab28da65e75db9986bc38e4ed8cdd10a322d0992"

  url "https://github.com/mrFokin/wgplex-app/releases/download/v#{version}/Wgplex-#{version}.dmg"
  name "Wgplex"
  desc "Menu bar client for the wgplex WireGuard engine"
  homepage "https://github.com/mrFokin/wgplex-app"

  depends_on formula: "mrfokin/tap/wgplex"
  depends_on macos: :ventura

  app "Wgplex.app"

  zap trash: "~/Library/Preferences/io.github.mrfokin.wgplex.plist"
end
