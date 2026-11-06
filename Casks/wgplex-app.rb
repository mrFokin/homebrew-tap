cask "wgplex-app" do
  version "0.1.2"
  sha256 "0ab8176628b78affbfc63e3bad8ede24080ed5d4df79f7a78c911e36ca53b7d6"

  url "https://github.com/mrFokin/wgplex-app/releases/download/v#{version}/Wgplex-#{version}.dmg"
  name "Wgplex"
  desc "Menu bar client for the wgplex WireGuard engine"
  homepage "https://github.com/mrFokin/wgplex-app"

  depends_on formula: "mrfokin/tap/wgplex"
  depends_on macos: :ventura

  app "Wgplex.app"

  zap trash: "~/Library/Preferences/io.github.mrfokin.wgplex.plist"
end
