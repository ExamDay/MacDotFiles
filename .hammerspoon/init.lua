-- Install the Hammerspoon IPC module for command line access to Hammerspoon:
-- hs.ipc.cliInstall()
-- require("hs.ipc")

-- Open a new iTerm2 window with a hotkey and them focus it:
hs.hotkey.bind({"cmd","ctrl"}, "T", function()
  local app = hs.application.get("iTerm2")

  if app == nil then
    -- Not running: launch it (will create 1 default window automatically)
    hs.application.launchOrFocusByBundleID("com.googlecode.iterm2")
  else
    -- Already running: explicitly make a new window
    hs.osascript.applescript([[
      tell application "iTerm2"
        create window with default profile
        activate
      end tell
    ]])
  end
end)

-- Open a new iTerm2 window with a hotkey, then have it run the "journal"
-- command, and then focus it and make it fullscreen:
hs.hotkey.bind({"cmd","ctrl"}, "J", function()
	  local app = hs.application.get("iTerm2")
	  if app == nil then
		-- Not running: launch it (will create 1 default window automatically)
		hs.application.launchOrFocusByBundleID("com.googlecode.iterm2")
	  else
		-- Already running: explicitly make a new window and run the command
		hs.osascript.applescript([[
		tell application "iTerm2"
			create window with default profile
			tell current session of current window
				write text "journal"
			end tell
			activate
		end tell
		tell application "System Events" to tell process "iTerm2"
			-- set value of attribute "AXFullScreen" of window 1 to true
			-- Instead of fullscreen, set the hieght to 100% of the screen
			-- hieght and the width to 81 characters.
			set position of window 1 to {0, 0}
			set size of window 1 to {720, 1200}
		end tell
		]])
	  end
  end)

-- Open a new iTerm2 window with a hotkey, then have it run the "schedule"
-- command, and then focus it and make it fullscreen:
hs.hotkey.bind({"cmd","ctrl"}, "P", function()
	  local app = hs.application.get("iTerm2")
	  if app == nil then
		-- Not running: launch it (will create 1 default window automatically)
		hs.application.launchOrFocusByBundleID("com.googlecode.iterm2")
	  else
		-- Already running: explicitly make a new window and run the command
		hs.osascript.applescript([[
		tell application "iTerm2"
			create window with default profile
			tell current session of current window
				write text "schedule"
			end tell
			activate
		end tell
		tell application "System Events" to tell process "iTerm2"
			-- set value of attribute "AXFullScreen" of window 1 to true
			-- Instead of fullscreen, set the hieght to 100% of the screen
			-- hieght and the width to 81 characters.
			set position of window 1 to {0, 0}
			set size of window 1 to {720, 1200}
		end tell
		]])
	  end
  end)

