cask "diple" do
  version "1.29.1"
  sha256 "cc2f854d5492a82678b77199132759b0944738a45361c7efd23ac575a3a3c398"

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

  # Signed ad-hoc, not notarised: without this, macOS offers to move it to the Trash.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Diple.app"]
  end

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
  EOS
end
