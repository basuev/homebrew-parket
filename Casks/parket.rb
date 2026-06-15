cask "parket" do
  bundle_id = "com.parket.app"
  codesign_requirement = '=designated => identifier "com.parket.app"'

  version "0.7.2"
  sha256 "1b51826a4808c499dab89694b2671670a93d251ec5d58c78aa955981be678523"

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
