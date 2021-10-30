local Ball = {}
Ball.__index = Ball

function newBall(world, x, y, id)
  local a = {}
  --BodyType pode ser static, dynamic ou kinematic
  a.body = love.physics.newBody(world, x, y, "dynamic")
  a.body:setUserData(id)
  a.shape = love.physics.newCircleShape(35)
  a.fixture = love.physics.newFixture(a.body, a.shape, 1)
  a.fixture:setRestitution(1.0) 
  a.fixture:setCategory(2)
  a.fixture:setMask(2)
  a.fixture:setUserData("Ball")
  a.img = love.graphics.newImage("img/ball.png")
  return setmetatable(a, Ball)
end

function Ball:clean()
  self.body:destroy()
  self.shape = nil
  self.fixture = nil
  self.img = nil
end

function Ball:update()
  self.body:applyForce(math.random(-100, 100),0)
end

function Ball:draw()
  love.graphics.setColor(255, 0, 0)
  --love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  love.graphics.draw(self.img, self.body:getX() - 35, self.body:getY() - 35)
  love.graphics.setColor(255, 255, 255)
end

function Ball:getPoints()
  return 1
end