local HomeMenuScreen = {}
HomeMenuScreen.__index = HomeMenuScreen


function newHomeMenuScreen()
  local a = {}
  a.nextScreen = SCREEN_ID_HOME_MENU
  a.font = nil
  a.jackFont = nil
  a.logoImg = nil
  a.homeMenuImg = nil
  a.back = nil
  a.music = nil
  a.iconAnimation = nil
  a.opts = nil
  a.curOpt = nil
  return setmetatable(a, HomeMenuScreen)
end

function HomeMenuScreen:unload()
  self.nextScreen = SCREEN_ID_HOME_MENU
  self.font = nil
  self.jackFont = nil
  self.logoImg = nil
  self.homeMenuImg = nil
  self.back = nil
  self.music = nil
  self.iconAnimation = nil
  self.opts = nil
  self.curOpt = nil
  love.audio.stop()
end

function HomeMenuScreen:printMainImg()
  love.graphics.draw(self.back, 0, 0)
  love.graphics.setFont(self.jackFont)
  love.graphics.setColor(0, 0, 0)
  love.graphics.print("As Aventuras de Jack", 130, 50)
  love.graphics.setColor(255, 213, 0)
  love.graphics.print("As Aventuras de Jack", 130, 55)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(self.font)
  love.graphics.draw(self.homeMenuImg, 200, 100)
end

function HomeMenuScreen:printOpts()
  local color = nil
  local colorShadow = nil
  local yDecrement = nil
  for i = 1, #self.opts, 1 do
    if (i == self.curOpt.index) then
      color = self.curOpt.color
      colorShadow = self.curOpt.shadow
      yDecrement = 3
    else
      color = {255, 255, 255}
      colorShadow = {0, 0, 0}
      yDecrement = 0
    end
    love.graphics.setColor(color)
    love.graphics.print(self.opts[i].txt, self.opts[i].x, self.opts[i].y)
    love.graphics.setColor(colorShadow)
    love.graphics.print(self.opts[i].txt, self.opts[i].x, self.opts[i].y + 5 - yDecrement)
  end
end

function HomeMenuScreen:printLogo()
  love.graphics.setColor(255, 255, 255)
  --TODO LOGO
end

function HomeMenuScreen:getNextScreen()
  return self.nextScreen
end

function HomeMenuScreen:initGame(screen)
  self.nextScreen = SCREEN_ID_GAME
end

function HomeMenuScreen:options()
end

function HomeMenuScreen:exit()
  love.event.quit()
end

function HomeMenuScreen:load()
  self.font = love.graphics.newFont("font/Thasadith-Regular.ttf", 30)
  self.jackFont = love.graphics.newFont("font/chintzy.ttf", 50)
  self.logoImg = love.graphics.newImage("img/logo_modelo_small.png")
  self.homeMenuImg = love.graphics.newImage("img/home_menu_img.png")
  self.back = love.graphics.newImage("img/CityDay.jpg")
  self.music = love.audio.newSource("sound/nch-adventure.mp3", "stream")
  self.iconAnimation = newAnimation(love.graphics.newImage("img/heroIcon.png"), 17, 32, 0.1, 2)
  self.opts = 
  {
    {txt = "Iniciar Jogo", x = 300, y = 400, func = self.initGame},
    {txt = "Opções", x = 300, y = 435, func = self.options},
    {txt = "Sair", x = 300, y = 465, func = self.exit}
  }
  self.curOpt =
  {
    index = 1,
    x = 280,
    y = 400,
    color = {255, 0, 0},
    shadow = {255, 213, 0}
  }
  self.music:setLooping(true)
  love.audio.play(self.music)
end

function HomeMenuScreen:update(dt)
  self.iconAnimation:update(dt)
end

function HomeMenuScreen:mousemoved(x, y)
  
end

function HomeMenuScreen:mousepressed(x, y)
   
end

function HomeMenuScreen:keypressed( key, scancode, isrepeat )
  
  if (key == "down") then
    self.curOpt.index = self.curOpt.index + 1
  elseif (key == "up") then
    self.curOpt.index = self.curOpt.index - 1
  elseif (key == "return") then
    self.opts[self.curOpt.index].func(self)
  end
  if (self.curOpt.index == 0) then
    self.curOpt.index = #self.opts
  elseif (self.curOpt.index > #self.opts) then
    self.curOpt.index = 1
  end
end

function HomeMenuScreen:keyreleased(key)
  
end

function HomeMenuScreen:draw()
  self.printMainImg(self)
  self.printOpts(self)
  self.printLogo(self)
  self.iconAnimation:draw(self.curOpt.x, self.curOpt.y + (self.curOpt.index - 1) * 35)
end

function HomeMenuScreen:beginContact(a, b, coll)
end
