cask "tatami" do
  version "0.5.3"
  sha256 "2b9323175feab31384599f6a3762eb2c6f6f9f8cf026ab323bc496e9fc5eddfd"

  url "https://github.com/basuev/tatami/releases/download/v#{version}/tatami.zip"
  name "tatami"
  desc "minimal dwm-like tiling window manager for macOS"
  homepage "https://github.com/basuev/tatami"

  postflight do
    app_path = "/Applications/tatami.app"
    staged_app = "#{staged_path}/tatami.app"

    if Dir.exist?(app_path)
      system_command "/bin/cp",
                     args: ["#{staged_app}/Contents/MacOS/tatami",
                            "#{app_path}/Contents/MacOS/tatami"]
      system_command "/bin/cp",
                     args: ["#{staged_app}/Contents/Info.plist",
                            "#{app_path}/Contents/Info.plist"]
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", app_path]
      system_command "/usr/bin/codesign",
                     args: ["--force", "--sign", "-", app_path]
    else
      system_command "/bin/cp", args: ["-R", staged_app, app_path]
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", app_path]
      system_command "/usr/bin/codesign",
                     args: ["--force", "--sign", "-", app_path]
      system "open", "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
    end
  end

  uninstall delete: "/Applications/tatami.app"

  zap trash: []
end
