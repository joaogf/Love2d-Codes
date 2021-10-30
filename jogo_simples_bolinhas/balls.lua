require("free_fall")
require("util")

local Balls = {}
Balls.__index = Balls

function newBalls(numBalls, rBall)
  
  local a = {}
  
  a.numBalls = numBalls
  a.rBall = rBall
  a.balls = nil
  
  return setmetatable(a, Balls)
  
end

function Balls:initBall(index)
  self.balls[index] = newFreeFall(0.1, 0.0, math.random(0 + self.rBall, 800 - self.rBall), 
    0.0, 600.0, 0.001, self.rBall)
end

function Balls:initAllBalls()
  self.balls = {}
  for index = 1, self.numBalls do
    self.initBall(self, index)
  end
end

function Balls:updateBalls()
  local lose = false
  for index = 1, self.numBalls do
    self.balls[index]:update()
    if (self.balls[index]:isEnding()) then
      lose = true
    end
  end
  return lose
end

function Balls:checkClickBalls(x, y)
  
  local points = 0
  
  for index = 1, self.numBalls do
    if (checkMousePosIn(x, y, self.balls[index]:getX(), self.balls[index]:getY(), 
        self.rBall) == true) then
      self.initBall(self, index)
      points = points + 1
    end
  end
  
  return points
end

function Balls:IncNumBalls()
  self.numBalls = self.numBalls + 1
  self.initBall(self, self.numBalls)
end

function Balls:reinit()
    self.numBalls = 3
    self.initAllBalls(self)
end

function Balls:drawBalls()
  for index = 1, self.numBalls do
    love.graphics.circle("fill", self.balls[index]:getX(), self.balls[index]:getY(), self.rBall)
  end
end

