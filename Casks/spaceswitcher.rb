cask "spaceswitcher" do
  version "0.4.1"
  sha256 "c2787891822b13292500a73593b722cab2dd23bec0650b70b6e83ba7fa3806d0"

  url "https://github.com/unh6unh6/SpaceSwitcher/releases/download/v#{version}/SpaceSwitcher-#{version}.dmg"
  name "SpaceSwitcher"
  desc "Name desktops (Spaces) and switch between them with Option+E"
  homepage "https://github.com/unh6unh6/SpaceSwitcher"

  depends_on macos: :sonoma

  app "SpaceSwitcher.app"

  # Self-signed and not notarized (no paid Apple account), so Gatekeeper would block the first launch.
  # Clearing quarantine skips the "Open Anyway" step for people who chose to install from this tap.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "SpaceSwitcher.app"],
        chdir:          "{{appdir}}",
        writable_paths: ["{{appdir}}/SpaceSwitcher.app"]
  end

  uninstall quit: "io.github.unh6unh6.SpaceSwitcher"

  zap trash: [
    "~/Library/Application Support/SpaceSwitcher",
    "~/Library/Preferences/io.github.unh6unh6.SpaceSwitcher.plist",
  ]
end
