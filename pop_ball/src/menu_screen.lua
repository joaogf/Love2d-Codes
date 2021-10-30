require("menu")
require("balls")
local MenuScreen = {}
MenuScreen.__index = MenuScreen


function newMenuScreen()
  local a = {}
  a.menu = nil
  a.optText = {}
  a.balls = {}
  a.background = nil
  a.balloonImg = nil
  a.frame = nil
  a.actions = nil
  a.nextScreen = nil
  return setmetatable(a, MenuScreen)
end

function MenuScreen:loadMenu(options, actions, numBalls, screenIndex)
  self.menu = newMenuGame()
  for i = 1, #options do
    self.menu:addOption(options[i][1], options[i][2], options[i][3], options[i][4], options[i][5])
  end
  self.actions = actions
  self.balls = newBalls(numBalls)
  self.balls:initAllBalls()
  self.background = love.graphics.newImage("imgs/sky.png")
  self.balloonImg = love.graphics.newImage("imgs/balao.png")
  self.frame = love.graphics.newImage("imgs/moldura.png")
  self.nextScreen = screenIndex
end

function MenuScreen:mousemoved(x, y)
  self.menu:mouseMoved(x, y)
end

function MenuScreen:mousepressed(x, y)
  self.menu:mousePressedActions(self, x, y)
end

function MenuScreen:getNextScreen()
  return self.nextScreen
end

function MenuScreen:update(dt)
    self.menu:update(dt)
    self.balls:updateBalls(dt)
end

function MenuScreen:drawBallonsImg()
  love.graphics.draw(self.balloonImg, 0, 0, 0.5, 0.4, 0.4)
  love.graphics.draw(self.balloonImg, 400, 200, 0.0, 0.4, 0.4)
end

function MenuScreen:drawPopBallName()
  
  local initX = 300
  local yPos = 80
  
  love.graphics.draw(self.frame, initX - 40, 10, 0.2, 0.4, 0.2)
  
  love.graphics.setFont(love.graphics.newFont(self.menu.fontName, 40))
  love.graphics.setColor(255, 0, 0, 255) -- vermelho
  love.graphics.print("P", initX, yPos)
  
  love.graphics.setColor(0, 0, 255, 255) --azul
  love.graphics.print("O", initX + 40, yPos)
  
  love.graphics.setColor(0,255,127) -- spring gren
  love.graphics.print("P", initX + 80, yPos)
  
  love.graphics.setColor(25,25,112) -- midnight blue
  love.graphics.print("B", initX + 120, yPos)
  
  love.graphics.setColor(255,105,180) -- hotpink
  love.graphics.print("A", initX + 160, yPos)
  
  love.graphics.setColor(0,100,0) -- dark gren
  love.graphics.print("L", initX + 200, yPos)
  
  love.graphics.setColor(210,105,30) -- chocolate
  love.graphics.print("L", initX + 240, yPos)
  
  love.graphics.setColor(255, 255, 255, 255)
end

function MenuScreen:draw()
    love.graphics.draw(self.background, 0, 0)
    self.drawBallonsImg(self)
    self.drawPopBallName(self)
    self.menu:draw()
    self.balls:drawBalls()
end
