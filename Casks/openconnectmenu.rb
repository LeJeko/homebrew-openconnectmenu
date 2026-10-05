cask "openconnectmenu" do
  version "2.1.1"
  sha256 "b0ac784659ea236046a2f544d1ae09f6ded43117050ccc8a9054d83cc771b6b2"

  url "https://github.com/LeJeko/OpenConnectMenu/releases/download/v#{version}/OpenConnectMenu-#{version}.pkg"
  name "OpenConnectMenu"
  desc "Menu-bar client for openconnect VPN connections"
  homepage "https://github.com/LeJeko/OpenConnectMenu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "openconnect"
  depends_on macos: :ventura

  pkg "OpenConnectMenu-#{version}.pkg"

  uninstall launchctl: "ch.jeko.OpenConnectMenu.helper",
            quit:      "ch.jeko.OpenConnectMenu",
            pkgutil:   "ch.jeko.OpenConnectMenu.pkg"

  zap trash: [
    "/Library/Application Support/OpenConnectMenu",
    "/Library/Logs/OpenConnectMenu.log",
    "~/Library/Preferences/ch.jeko.OpenConnectMenu.plist",
  ]

  caveats <<~EOS
    Before uninstalling, open Settings… from the menu-bar icon, go to the General
    tab and click "Uninstall helper", so that macOS also forgets the background item.

    Upgrading openconnect (brew upgrade openconnect) changes its checksum: the
    app will ask you to approve the new binary again.
  EOS
end
