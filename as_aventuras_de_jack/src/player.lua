local Player = {}
Player.__index = Player

function newPlayer(life, points)
  local a = {}
  a.life = life
  a.points = points
  a.heroLifeImg = love.graphics.newImage("img/hero_life.png")
  return setmetatable(a, Player)
end

function Player:getPlayerLifeImg()
  return self.heroLifeImg
end

function Player:incrementPoints(increment)
  self.points = self.points + increment
end

function Player:getPoints()
  return self.points
end

function Player:getLife()
  return self.life
end

function Player:downLife()
  self.life = self.life - 1
end