cask "openconnectmenu" do
  version "2.3"
  sha256 "209c25f575300c6d1f5febc907bed1eb0b3f13ed365c7474dce28429c85c2ae4"

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
    OpenConnectMenu has no window. Its icon, a crossed-out padlock, is at the far left
    of the right-hand part of the menu bar. On first launch it opens System Settings so
    that you can allow its helper, then asks you to approve openconnect.

    Before uninstalling, open Settings… from the menu-bar icon, go to the General
    tab and click "Uninstall helper", so that macOS also forgets the background item.

    Upgrading openconnect (brew upgrade openconnect) changes its checksum: the
    app will ask you to approve the new binary again.
  EOS
end
