# suliveevil/homebrew-tap

Homebrew tap for [Kaname](https://github.com/suliveevil/kaname) — context-aware keyboard
shortcut hints and search for the active macOS app.

```sh
brew tap suliveevil/tap
brew install --cask kaname
```

Requires macOS 14 or later on Apple Silicon. Kaname is signed with a local certificate and is
not notarized by Apple, so macOS blocks its first launch: approve it once in
**System Settings → Privacy & Security** ("Open Anyway"), or strip the attribute with
`xattr -dr com.apple.quarantine /Applications/Kaname.app`. Homebrew 7 removed `--no-quarantine`,
and every `brew upgrade` downloads a copy that is quarantined again.
