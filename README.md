# dev7a Homebrew tap

Install the signed, notarized [lnpctl](https://github.com/dev7a/lnpctl) release with Homebrew.
Requires Apple Silicon and macOS 26 or later.

The cask uses a stricter minimum than the executable's macOS 15 deployment
target. The current release's offline filesystem integration tests ran on
macOS 26.6.1; this does not mean every macOS 26 or newer release is validated.
See the project's [validation record](https://github.com/dev7a/lnpctl/blob/main/docs/validation.md).

```sh
brew install --cask dev7a/tap/lnpctl
lnpctl --version
```

**lnpctl is experimental.** It edits undocumented macOS settings using private APIs.
A mistake or a macOS update could damage settings or disrupt network access.
Try a disposable VM first, keep SIP enabled, and read the
[usage and Recovery guide](https://dev7a.github.io/lnpctl/guide/) before use.

The cask downloads the official DMG, verifies its pinned SHA-256 checksum, and
links the executable into Homebrew's `bin` directory. Installation does not
change Local Network permissions, set up Recovery, or install a background service.

## RDMALink

Install the signed, notarized [RDMALink](https://github.com/dev7a/rdmalink)
release with Homebrew. Requires Apple Silicon and macOS 27 or later.

```sh
brew install --cask dev7a/tap/rdmalink
```

RDMALink prepares one Thunderbolt 5 port on each of two Macs for RDMA over
Thunderbolt: it takes the port out of Thunderbolt Bridge and gives it a
link-local service, keeping an undo note so it can put everything back. It
uses a private macOS interface to edit bridge membership and asks for an
administrator password once per change. Uninstalling the cask removes the app
only; the undo notes in `~/Library/Application Support/RDMALink` stay, so put
ports back from inside the app first.

The cask downloads the official DMG, verifies its pinned SHA-256 checksum and
installs `RDMALink.app` into Applications.

## Upgrade or uninstall

```sh
brew update
brew upgrade --cask dev7a/tap/lnpctl
brew uninstall --cask lnpctl
brew upgrade --cask dev7a/tap/rdmalink
brew uninstall --cask rdmalink
```

Uninstalling removes the Homebrew installation only. It preserves backups,
prepared plans, and any Recovery launcher you created. Each backup retains its
own staged executable; upgrading the cask does not upgrade existing backups.

## Maintaining the cask

Updates are reviewed changes to `Casks/lnpctl.rb` and `Casks/rdmalink.rb`, not automatic release pushes. The same steps apply to RDMALink, whose releases are at [dev7a/rdmalink](https://github.com/dev7a/rdmalink/releases); its installation test is opening the app and reading the hub, never setting up a port.

1. Confirm the new release is published at [dev7a/lnpctl](https://github.com/dev7a/lnpctl/releases).
2. Download its DMG and `SHA256SUMS`. Verify the DMG checksum, Developer ID
   signature, and stapled notarization ticket; compare `release.json` with the
   intended release tag and source commit.
3. Update `version` and `sha256` together. Keep a versioned release URL and an
   exact checksum; do not use `latest` downloads or `:no_check`.
4. Run `brew style --cask dev7a/tap/lnpctl` and
   `brew audit --cask --online dev7a/tap/lnpctl`.
5. On a test Mac, install the cask, check `lnpctl --version` and `lnpctl --help`,
   and verify uninstall removes the executable link. Do not run cleanup or
   Recovery operations as an installation test.

`brew livecheck --cask dev7a/tap/lnpctl` can report available releases; it does
not publish cask updates.

## License

The tap is [MIT licensed](LICENSE). The downloaded lnpctl release includes its
own MIT license.
