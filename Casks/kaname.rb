# Homebrew cask for Kaname. Users install with:
#   brew tap suliveevil/tap
#   brew install --cask kaname
#
# The DMG URL and asset name must match scripts/build_release.sh exactly.
#
cask "kaname" do
  version "2.3.0"
  sha256 "0cdcc82ca13b0a61235c0508e931d99bbe064e3bb665ec2548f17a561234938d"

  url "https://github.com/suliveevil/kaname/releases/download/v#{version}/Kaname-#{version}.dmg",
      verified: "github.com/suliveevil/kaname/"
  name "Kaname"
  desc "Context-aware keyboard shortcut hints and search for the active macOS app"
  homepage "https://github.com/suliveevil/kaname"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 14.0, matching LSMinimumSystemVersion in scripts/Info.plist.
  depends_on macos: ">= :sonoma"

  # Apple Silicon is the only supported configuration. The DMG built by
  # scripts/build_release.sh is universal (x86_64 + arm64), but Intel is untested, so
  # the cask rejects Intel Macs at install time by choice rather than shipping an
  # unsupported configuration. This is a deliberate support decision, not a statement
  # about the binary's architectures.
  depends_on arch: :arm64

  app "Kaname"

  # Kaname is an LSUIElement menu bar app: replacing the bundle while the old process
  # still runs leaves it holding a deleted binary and the event tap. `login_item` is
  # best effort (the app registers through SMAppService, while Homebrew uses the
  # legacy AppleScript login-item API); a leftover entry is removed in System
  # Settings → General → Login Items.
  uninstall quit: "com.suliveevil.kaname",
            login_item: "Kaname"

  caveats <<~EOS
    Kaname is signed with a local certificate and is not notarized by Apple, so
    macOS blocks its first launch. Either approve it once in
    System Settings → Privacy & Security ("Open Anyway"), or install with:
      brew install --cask --no-quarantine kaname
    The latter skips Gatekeeper's first-launch check for this package only, and
    `brew upgrade` without the flag will quarantine it again.
  EOS

  zap trash: [
    "~/Library/Application Support/Kaname",
    "~/Library/Caches/com.suliveevil.kaname",
    "~/Library/Preferences/com.suliveevil.kaname.plist",
    "~/Library/Saved Application State/com.suliveevil.kaname.savedState",
  ]
end
