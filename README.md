# dev7a Homebrew tap

Homebrew cask definitions for dev7a’s macOS applications. [lnpctl](https://github.com/dev7a/lnpctl) is an experimental command-line tool for cleaning up macOS Local Network permissions, with prepared changes applied through macOS Recovery. [RDMALink](https://github.com/dev7a/rdmalink) is a desktop app that prepares a Thunderbolt 5 port on each of two Macs for RDMA over Thunderbolt by removing it from Thunderbolt Bridge and creating a link-local network service; it keeps undo notes so you can restore the original configuration.

## Install

Both casks install signed, notarized releases from the respective projects,
using versioned DMG downloads and pinned SHA-256 checksums.

| Application | Requirements | Install command |
| --- | --- | --- |
| lnpctl | Apple Silicon, macOS 26 or later | `brew install --cask dev7a/tap/lnpctl` |
| RDMALink | Apple Silicon, macOS 27 or later; Thunderbolt 5 for RDMA | `brew install --cask dev7a/tap/rdmalink` |

### lnpctl

The cask links the executable into Homebrew’s `bin` directory. Check the
installation with `lnpctl --version`. Installation does not change Local
Network permissions, set up Recovery, or install a background service.

**lnpctl is experimental.** It edits undocumented macOS settings using private APIs.
A mistake or a macOS update could damage settings or disrupt network access.
Try a disposable VM first, keep SIP enabled, and read the
[usage and Recovery guide](https://dev7a.github.io/lnpctl/guide/) before use.

The cask uses a stricter minimum than the executable’s macOS 15 deployment
target. The current release’s offline filesystem integration tests ran on
macOS 26.6.1; this does not mean every macOS 26 or newer release is validated.
See the project’s [validation record](https://github.com/dev7a/lnpctl/blob/main/docs/validation.md).

### RDMALink

The cask installs `RDMALink.app` into Applications. Open the app to get started.
RDMALink uses a private macOS interface to edit bridge membership and asks for
an administrator password once per change. Read the
[project documentation](https://github.com/dev7a/rdmalink) before preparing a port.

## Upgrade or uninstall

Update Homebrew’s package information first:

```sh
brew update
```

Then use the command for the application you want to upgrade or remove:

| Application | Upgrade | Uninstall |
| --- | --- | --- |
| lnpctl | `brew upgrade --cask dev7a/tap/lnpctl` | `brew uninstall --cask lnpctl` |
| RDMALink | `brew upgrade --cask dev7a/tap/rdmalink` | `brew uninstall --cask rdmalink` |

- **lnpctl:** Uninstalling preserves backups, prepared plans, and any Recovery
  launcher you created. Each backup retains its own staged executable;
  upgrading the cask does not upgrade existing backups.
- **RDMALink:** Put ports back from inside the app before uninstalling.
  Uninstalling removes the app but preserves the undo notes in
  `~/Library/Application Support/RDMALink`.

## Maintaining the tap

Cask updates are reviewed changes to the definitions in `Casks/`, not automatic
release pushes. Use the matching definition and release page:

| Application | Definition | Releases |
| --- | --- | --- |
| lnpctl | [Casks/lnpctl.rb](Casks/lnpctl.rb) | [lnpctl releases](https://github.com/dev7a/lnpctl/releases) |
| RDMALink | [Casks/rdmalink.rb](Casks/rdmalink.rb) | [RDMALink releases](https://github.com/dev7a/rdmalink/releases) |

1. Confirm the new release is published on the application’s release page.
2. Download its DMG and `SHA256SUMS`. Verify the DMG checksum, Developer ID
   signature, and stapled notarization ticket; compare `release.json` with the
   intended release tag and source commit.
3. Update `version` and `sha256` together in the corresponding cask. Keep a
   versioned release URL and an exact checksum; do not use `latest` downloads
   or `:no_check`.
4. Run `brew style --cask dev7a/tap/<cask>` and
   `brew audit --cask --online dev7a/tap/<cask>`, replacing `<cask>` with
   `lnpctl` or `rdmalink`.
5. On a test Mac, install the cask and verify its installation and removal:
   - **lnpctl:** Check `lnpctl --version` and `lnpctl --help`, then verify
     uninstall removes the executable link. Do not run cleanup or Recovery
     operations as an installation test.
   - **RDMALink:** Open the app and read the hub, then verify uninstall removes
     the app. Do not set up a port as an installation test.

`brew livecheck --cask dev7a/tap/<cask>` can report available releases; it does
not publish cask updates. Add future applications as separate definitions in
`Casks/` or `Formula/`, and document their requirements and installation here.

## License

The tap is [MIT licensed](LICENSE). See each application’s repository and
release for its license.
