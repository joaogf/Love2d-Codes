require("menu_screen")

local CtrlScreen = {}
CtrlScreen.__index = CtrlScreen

function newCtrlScreen()
  local a = {}
  a.screens = {}
  a.screenIndex = SCREEN_ID_MENU
  return setmetatable(a, CtrlScreen)
end

function CtrlScreen:addScreen(screen)
  self.screens[#self.screens + 1] = screen
end

function CtrlScreen:update(dt)
  self.screens[self.screenIndex]:update(dt)
  local index = self.screens[self.screenIndex]:getNextScreen()
  self.screenIndex = index
  self.screens[index].nextScreen = index
end

function CtrlScreen:mousemoved(x, y)
  self.screens[self.screenIndex]:mousemoved(x, y)
end

function CtrlScreen:mousepressed(x, y)
   self.screens[self.screenIndex]:mousepressed(x, y)
end

function CtrlScreen:draw()
    self.screens[self.screenIndex]:draw()
end