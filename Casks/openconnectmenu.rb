cask "openconnectmenu" do
  version "1.8"
  sha256 "034e35ac43b29e499a98c3571ee94a4f6d6daf887c189307b00ad0e24bd4c1a1"

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
    Before uninstalling, open the menu-bar icon and choose "Uninstall helper"
    so that macOS also forgets the background item.

    Upgrading openconnect (brew upgrade openconnect) changes its checksum: the
    app will ask you to approve the new binary again.
  EOS
end
