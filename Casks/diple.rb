cask "diple" do
  version "0.1.0"
  sha256 "5520701052504c62d10fe768471d54ec464072a0c3f3d79e3b9e75f50af1bf72"

  url "https://github.com/chagas42/diple/releases/download/v#{version}/Diple-#{version}.zip"
  name "Diple"
  desc "Pull requests waiting on you, in the MacBook notch"
  homepage "https://github.com/chagas42/diple"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on formula: "gh"

  app "Diple.app"


  uninstall quit: "com.chagas42.diple"

  zap trash: [
    "~/Library/Application Support/Diple",
    "~/Library/Preferences/com.chagas42.diple.plist",
    "~/.diple",
  ]

  caveats <<~EOS
    Diple borrows the token the GitHub CLI already holds, so run

      gh auth login

    once if you have not. There is no setup screen and nothing to paste.

    The build is signed ad-hoc rather than notarised, which needs a paid
    Apple Developer account, so macOS quarantines it. Clear the flag once:

      xattr -dr com.apple.quarantine /Applications/Diple.app

    Or right-click the app and choose Open the first time.
  EOS
end
