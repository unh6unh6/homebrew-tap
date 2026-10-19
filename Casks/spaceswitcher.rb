cask "spaceswitcher" do
  version "0.7.0"
  sha256 "20d59be1a94d5ed3e45e246e13555f60b33c20a7810f31074aa1bcab26a84214"

  url "https://github.com/unh6unh6/space-switcher/releases/download/v#{version}/SpaceSwitcher-#{version}.dmg"
  name "SpaceSwitcher"
  desc "Name desktops (Spaces) and switch between them with Option+E"
  homepage "https://github.com/unh6unh6/space-switcher"

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
