cask "lnpctl" do
  version "0.1.4"
  sha256 "dd199bc41fa231e8b90dc04cf0e2419bdfebd5d4c8f6b2064596bba5573dddd3"

  url "https://github.com/dev7a/lnpctl/releases/download/v#{version}/lnpctl-#{version}-macos-arm64.dmg",
      verified: "github.com/dev7a/lnpctl/"
  name "lnpctl"
  desc "Experimental Local Network permission cleanup tool"
  homepage "https://dev7a.github.io/lnpctl/"

  livecheck do
    url "https://github.com/dev7a/lnpctl"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  binary "lnpctl"

  caveats <<~EOS
    Experimental: edits undocumented macOS settings using private APIs.
    Read https://dev7a.github.io/lnpctl/guide/ before use and keep SIP enabled.
    Applying prepared changes requires macOS Recovery.
    Uninstalling keeps your backups and any Recovery launcher you created.
  EOS
end
