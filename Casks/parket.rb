cask "parket" do
  bundle_id = "com.parket.app"
  codesign_requirement = '=designated => identifier "com.parket.app"'

  version "0.7.0"
  sha256 "e11742e2d1220279741a8f2bc0de31f7902502a86c46a9bb5c9962411abd684b"

  url "https://github.com/basuev/parket/releases/download/v#{version}/parket.zip"
  name "parket"
  desc "Minimal dwm-like tiling window manager"
  homepage "https://github.com/basuev/parket"

  depends_on macos: :sonoma
  depends_on arch: :arm64

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
                     args: ["--force", "--sign", "-", "--requirements", codesign_requirement, app_path]
    else
      system_command "/bin/cp", args: ["-R", staged_app, app_path]
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", app_path]
      system_command "/usr/bin/codesign",
                     args: ["--force", "--sign", "-", "--requirements", codesign_requirement, app_path]
      system "open", "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
    end
  end

  uninstall quit: bundle_id

  zap trash: "~/.config/parket"
end
