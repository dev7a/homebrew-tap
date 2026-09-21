cask "rdmalink" do
  version "0.3.3"
  sha256 "703dd6edf509eae668647412c3ba03391268f0e3ae519d73c6f9eef5c831f260"

  url "https://github.com/dev7a/rdmalink/releases/download/v#{version}/RDMALink-#{version}.dmg"
  name "RDMALink"
  desc "Prepares a Thunderbolt 5 port for RDMA between two Macs"
  homepage "https://github.com/dev7a/rdmalink"

  livecheck do
    url "https://github.com/dev7a/rdmalink"
    strategy :github_latest
  end

  # The app is built for macOS 27 only and ships arm64 only: RDMA over
  # Thunderbolt needs Thunderbolt 5, and macOS 27 runs on Apple silicon.
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "RDMALink.app"

  # The undo notes in Application Support are what puts a port back; they are
  # deliberately not zapped. Restore from inside the app before uninstalling.
  zap trash: [
    "~/Library/Preferences/com.dev7a.RDMALink.plist",
    "~/Library/Saved Application State/com.dev7a.RDMALink.savedState",
  ]

  caveats <<~EOS
    RDMALink changes this Mac's network settings: it takes one Thunderbolt
    port out of Thunderbolt Bridge and gives it a link-local service, using
    a private macOS interface. It asks for an administrator password once
    per change and keeps an undo note in ~/Library/Application Support/RDMALink.
    Put ports back from inside the app before uninstalling; uninstalling
    keeps the notes.
  EOS
end
