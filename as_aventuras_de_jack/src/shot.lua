

local Shot = {}
Shot.__index = Shot

function newShot(world, x, y, dir)
  local a = {}
  a.body = love.physics.newBody(world, x, y, "dynamic")
  a.shape = love.physics.newRectangleShape(32, 32)
  a.fixture = love.physics.newFixture(a.body, a.shape, 1)
  a.fixture:setUserData("Shot")
  a.fixture:setCategory(3)
  a.fixture:setMask(3)
  if (dir == "right") then
    a.img = love.graphics.newImage("img/shot_right.png")
    a.animation = newAnimation(a.img, 64, 64, 0.05, 0)
  else
    a.img = love.graphics.newImage("img/shot_left.png")
    a.animation = newAnimation(a.img, 64, 64, 0.05, 0)
  end
  a.animation:seek(1)
  a.dir = dir
  a.explosion = false
  a.xExplosion = nil
  a.yExplosion = nil
  a.ending = false
  a.explosionSound = love.audio.newSource("sound/explosion.wav", "static")
  a.gunSound = love.audio.newSource("sound/tir.mp3", "static")
  love.audio.play(a.gunSound)
  return setmetatable(a, Shot)
end

function Shot:setExplosion()
  self.explosion = true
  self.animation = newAnimation(love.graphics.newImage("img/explosionframes.png"), 
    64, 64, 0.05, 0)
  self.xExplosion = self.body:getX() - 16
  self.yExplosion = self.body:getY() - 16
  self.body:destroy()
  love.audio.play(self.explosionSound)
end

function Shot:clean()
  self.shape = nil
  self.fixture = nil
  self.img = nil
  self.animation = nil
end

function Shot:isEnd()
  return self.ending
end

function Shot:update(dt)
  if (self.explosion == false) then
    if (self.dir == "right") then
      self.body:setLinearVelocity(400, -400)
    else
      self.body:setLinearVelocity(-400, -400)
    end
  else
    if (self.animation:getCurrentFrame() == 8) then
      self.ending = true
    end
  end
  self.animation:update(dt)
end

function Shot:draw()
 --love.graphics.rectangle("fill", self.body:getX(), self.body:getY(), 32, 32)
  if (self.explosion == false) then
    self.animation:draw(self.body:getX() - 16, self.body:getY() - 16)
  else
    self.animation:draw(self.xExplosion, self.yExplosion)
  end
end