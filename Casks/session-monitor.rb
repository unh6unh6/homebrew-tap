cask "session-monitor" do
  version "0.1.0"
  sha256 "7242dc720a0b5999b6d7b771326ec12b29d50698e1339e4771adbfc55c37a480"

  url "https://github.com/unh6unh6/session-monitor/releases/download/v#{version}/SessionMonitor-#{version}.dmg"
  name "Session Monitor"
  desc "Menu bar monitor for the status of Claude Code sessions"
  homepage "https://github.com/unh6unh6/session-monitor"

  depends_on macos: :sonoma

  app "SessionMonitor.app"

  # Self-signed and not notarized (no paid Apple account), so Gatekeeper would block the first launch.
  # Clearing quarantine skips the "Open Anyway" step for people who chose to install from this tap.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "SessionMonitor.app"],
        chdir:          "{{appdir}}",
        writable_paths: ["{{appdir}}/SessionMonitor.app"]
  end

  uninstall quit: "io.github.unh6unh6.SessionMonitor"

  zap trash: [
    "~/.session-monitor",
    "~/Library/Application Support/SessionMonitor",
    "~/Library/Preferences/io.github.unh6unh6.SessionMonitor.plist",
  ]

  caveats <<~EOS
    Session Monitor shows Claude Code sessions reported by its Claude Code plugin.
    Install the plugin from inside Claude Code:

      /plugin marketplace add unh6unh6/session-monitor
      /plugin install session-monitor@session-monitor

    Then run /session-monitor:register [group] in a session to track it.
  EOS
end
