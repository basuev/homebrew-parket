cask "tatami" do
  version "0.5.0"
  sha256 "74418d1cffb4a577c5499f2da321af2f9754333a66ca649fb9bd9d8ec7e858db"

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
