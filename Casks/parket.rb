cask "parket" do
  bundle_id = "com.parket.app"
  codesign_requirement = '=designated => identifier "com.parket.app"'

  version "0.8.3"
  sha256 "0432fb22fdbc15a2d79f3b69e99aca900af55ed39e5065ca2b8144d0413940f4"

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
