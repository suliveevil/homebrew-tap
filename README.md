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

## Updating the cask

`Casks/kaname.rb` is rendered by `scripts/publish_release.sh` in the main
[kaname](https://github.com/suliveevil/kaname) repository from `Distribution/kaname.rb`; do not
edit the version or sha256 here by hand. The cask is pushed only after the matching DMG and its
`.sha256` are attached to the GitHub release — pushing it earlier makes every install a 404. See
`docs/en/RELEASING.md` in that repository for the sequence and the
`brew audit --cask --strict suliveevil/tap/kaname` check.
