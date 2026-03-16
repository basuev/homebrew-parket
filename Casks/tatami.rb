cask "tatami" do
  version "0.4.1"
  sha256 "05b8a6b4bd0778c8e7642a397d04ed351182475a7d6d0cbddc04ab8e1dd88385"

  url "https://github.com/basuev/tatami/releases/download/v#{version}/tatami.zip"
  name "tatami"
  desc "minimal dwm-like tiling window manager for macOS"
  homepage "https://github.com/basuev/tatami"

  app "tatami.app"

  postflight do
    system "open", "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
  end

  zap trash: []
end
