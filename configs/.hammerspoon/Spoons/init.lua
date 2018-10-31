#!/usr/bin/env lua

mash = {"⌘", "⌥", "⌃"}


local function toggleApplication(name)
  local app = hs.application.find(name)
  if not app or app:isHidden() then
    hs.application.launchOrFocus(name)
  elseif hs.application.frontmostApplication() ~= app then
    app:activate()
  else
    app:hide()
  end
end

hs.hotkey.bind(mash, "c", function() toggleApplication("Google Chrome") end)
hs.hotkey.bind(mash, "d", function() toggleApplication("Dash") end)
hs.hotkey.bind(mash, "f", function() toggleApplication("Finder") end)
hs.hotkey.bind(mash, "g", function() toggleApplication("SourceTree") end)
hs.hotkey.bind(mash, "m", function() toggleApplication("Mail") end)
hs.hotkey.bind(mash, "p", function() toggleApplication("System Preferences") end)
hs.hotkey.bind(mash, "s", function() toggleApplication("Spotify") end)
hs.hotkey.bind(mash, "t", function() toggleApplication("Terminal") end)

hs.grid.setGrid'3x3'
hs.grid.setMargins("0,0")
hs.window.animationDuration = 0

function getWin()
  return hs.window.focusedWindow()
end

--- arrows: move window
hs.hotkey.bind(mash, "left", function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind(mash, "right", function() hs.grid.pushWindowRight() end)
hs.hotkey.bind(mash, "up", function() hs.grid.pushWindowUp() end)
hs.hotkey.bind(mash, "down", function() hs.grid.pushWindowDown() end)

--- ikjl: resize window
hs.hotkey.bind(mash, "i", function() hs.grid.resizeWindowShorter() end)
hs.hotkey.bind(mash, "k", function() hs.grid.resizeWindowTaller() end)
hs.hotkey.bind(mash, "j", function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind(mash, "l", function() hs.grid.resizeWindowWider() end)

--- 234: resize grid
hs.hotkey.bind(mash, "2", function() hs.grid.setGrid('2x2'); hs.alert.show('Grid set to 2x2'); end)
hs.hotkey.bind(mash, "3", function() hs.grid.setGrid('3x3'); hs.alert.show('Grid set to 3x3'); end)
hs.hotkey.bind(mash, "4", function() hs.grid.setGrid('4x4'); hs.alert.show('Grid set to 4x4'); end)

--- /: move window to next screen
hs.hotkey.bind(mash, "/", function() local win = getWin(); win:moveToScreen(win:screen():next()) end)

--- ,: snap window to grid
hs.hotkey.bind(mash, ",", function() hs.grid.snap(getWin()) end)

--- space: maximize window
hs.hotkey.bind(mash, "space", function() hs.grid.maximizeWindow() end)

--- .: minimize window
hs.hotkey.bind(mash, ".", function() hs.grid.set(getWin(), '0,0 1x1'); end)

hs.hotkey.bind(mash, "r", function() hs.reload(); end)
hs.hotkey.bind(mash, "w", function() hs.eventtap.keyStrokes('¯\\_(ツ)_/¯'); end)
hs.hotkey.bind(mash, "a", function() hs.caffeinate.lockScreen(); end)
hs.alert("Hammerspoon config loaded")

