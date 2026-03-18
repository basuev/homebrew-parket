cask "parket" do
  version "0.6.0"
  sha256 "73fd2eadcfc8aecaf6df7b37b8c70af683dd270fdab2fd779f39af5ae54636be"

  url "https://github.com/basuev/parket/releases/download/v#{version}/parket.zip"
  name "parket"
  desc "minimal dwm-like tiling window manager for macOS"
  homepage "https://github.com/basuev/parket"

  postflight do
    app_path = "/Applications/parket.app"
    staged_app = "#{staged_path}/parket.app"

    if Dir.exist?(app_path)
      system_command "/bin/cp",
                     args: ["#{staged_app}/Contents/MacOS/parket",
                            "#{app_path}/Contents/MacOS/parket"]
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

  uninstall delete: "/Applications/parket.app"

  zap trash: []
end
