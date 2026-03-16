cask "tatami" do
  version "0.4.0"
  sha256 "36fbaa9440567c4c50de70c8374f7729c131c87c3e172f119d3503988e87ef8d"

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
