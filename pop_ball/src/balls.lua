require("free_fall")
require("util")
require("AnAL")

local Balls = {}
Balls.__index = Balls

local id = 0
local ID_LIMIT = 10

local function getId()
  id = id + 1
  if (id == ID_LIMIT) then
    id = 1
  end
  return id
end


function newBalls(numBalls)
  local a = {}
  
  a.numBalls = numBalls
  a.initNumBalls = numBalls
  a.rBall = 64
  a.balls = nil
  a.animImg = love.graphics.newImage("imgs/explosionframes.png")
  a.animMap = {}
  
  return setmetatable(a, Balls)
  
end

function Balls:initBall(index, numBall, y)
  self.balls[index] = newFreeFall(0.1, 0.0, math.random(0 + self.rBall, 800 - self.rBall),
    math.random(-200, 0), 600.0, 0.001, self.rBall)
  self.balls[index].image = love.graphics.newImage("imgs/ball" .. numBall .. ".png")
  self.balls[index].sound = love.audio.newSource("sound/explosion.wav", "static")
end

function Balls:initAllBalls()
  self.balls = {}
  for index = 1, self.numBalls do
    self.initBall(self, index, math.random(1, 5))
  end
end

function Balls:updateBalls(dt)
  local lose = false
  
  for index = 1, self.numBalls do
    self.balls[index]:update()
    if (self.balls[index]:isEnding()) then
      self.initBall(self, index, math.random(1, 5))
      lose = true
    end
  end
  
  for index = 1, #self.animMap do
    self.animMap[index].anim:update(dt)
  end
  
  return lose
end

function Balls:checkClickBalls(x, y)
  local points = 0
  
  for index = 1, self.numBalls do
    if (checkMousePosIn(x, y, self.balls[index]:getX(), 
        self.balls[index]:getY(), self.rBall) == true) then
      
      points = points + 1
      
      local indexAnim = getId()
      self.animMap[indexAnim] = {}
      self.animMap[indexAnim].anim = newAnimation(self.animImg, 64, 64, 0.1, 0)
      self.animMap[indexAnim].anim:setMode("once")
      self.animMap[indexAnim].x = self.balls[index]:getX()
      self.animMap[indexAnim].y = self.balls[index]:getY()
      
      self.initBall(self, index, math.random(1, 5))
      
      love.audio.play(self.balls[index].sound)
    end
  end
  return points
end

function Balls:IncNumBalls()
  self.numBalls = self.numBalls + 1
  self.initBall(self, self.numBalls, math.random(1, 5))
end

function Balls:reinit()
  self.numBalls = self.initNumBalls
  self.initAllBalls(self)
end

function Balls:drawBalls()
  for index = 1, self.numBalls do
    love.graphics.draw(self.balls[index].image, self.balls[index]:getX(),
      self.balls[index]:getY())
  end
  
  for index = 1, #self.animMap do
    if (self.animMap[index].anim:isPlaying()) then
      self.animMap[index].anim:draw(self.animMap[index].x, self.animMap[index].y)
    end
  end
  
  love.graphics.setColor(255, 255, 255, 255)
end