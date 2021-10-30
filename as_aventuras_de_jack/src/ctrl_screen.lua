

local CtrlScreen = {}
CtrlScreen.__index = CtrlScreen

function newCtrlScreen()
  local a = {}
  a.screens = {}
  a.screenIndex = SCREEN_ID_HOME_MENU
  return setmetatable(a, CtrlScreen)
end

function CtrlScreen:firstLoad()
  self.screens[self.screenIndex]:load()
end

function CtrlScreen:addScreen(screen, key)
  self.screens[key] = screen
end

function CtrlScreen:update(dt)
  self.screens[self.screenIndex]:update(dt)
  local index = self.screens[self.screenIndex]:getNextScreen()
  if (index ~= self.screenIndex) then
    self.screens[self.screenIndex]:unload()
    self.screens[index]:load()
  end
  self.screenIndex = index
  self.screens[index].nextScreen = index
end

function CtrlScreen:mousemoved(x, y)
  self.screens[self.screenIndex]:mousemoved(x, y)
end

function CtrlScreen:mousepressed(x, y)
   self.screens[self.screenIndex]:mousepressed(x, y)
end

function CtrlScreen:keypressed( key, scancode, isrepeat )
  self.screens[self.screenIndex]:keypressed(key, scancode, isrepeat)
end

function CtrlScreen:keyreleased(key)
  self.screens[self.screenIndex]:keyreleased(key)
end

function CtrlScreen:draw()
    self.screens[self.screenIndex]:draw()
end

function CtrlScreen:beginContact(a, b, coll)
    self.screens[self.screenIndex]:beginContact(a, b, coll)
end