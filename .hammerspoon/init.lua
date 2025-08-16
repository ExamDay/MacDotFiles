hs.hotkey.bind({"cmd","ctrl"}, "T", function()
  local app = hs.application.get("iTerm2")

  if app == nil then
    -- Not running: launch it (will create 1 default window automatically)
    hs.application.launchOrFocusByBundleID("com.googlecode.iterm2")
  else
    -- Already running: explicitly make a new window
    hs.osascript.applescript([[
      tell application "iTerm2"
        activate
        create window with default profile
      end tell
    ]])
  end
end)
