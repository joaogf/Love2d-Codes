local CharBody = {}
CharBody.__index = CharBody

function newCharBody(world, x, y, w, h)
  local a = {}
  a.body = love.physics.newBody(world, x, y, "dynamic")
  a.shape = love.physics.newRectangleShape(w, h)
  a.fixture = love.physics.newFixture(a.body, a.shape, 1)
  a.fixture:setUserData("Char")
  a.fixture:setCategory(3)
  a.fixture:setMask(3)
  return setmetatable(a, CharBody)
end

function CharBody:getX()
  return self.body:getX()
end

function CharBody:getY()
  return self.body:getY()
end