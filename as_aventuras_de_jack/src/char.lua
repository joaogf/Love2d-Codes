require("AnAL")
require("charBody")

local Char = {}
Char.__index = Char

function newChar(world, speed, charWidth, charHeight, rightImgFilename, leftImgFilename, deathImgFilename, winWidth, winHeight)
  local a = {}
  a.speed = speed
  a.death = false
  a.widthImg = charWidth
  a.heightImg = charHeight
  a.deathImg = love.graphics.newImage(deathImgFilename)
  a.rightImg = love.graphics.newImage(rightImgFilename)
  a.leftImg = love.graphics.newImage(leftImgFilename)
  a.charAnimationRight = newAnimation(a.rightImg, a.widthImg, a.heightImg, 0.2, 0)
  a.charAnimationLeft = newAnimation(a.leftImg, a.widthImg, a.heightImg, 0.2, 0)
  a.charDeathAnimation = newAnimation(a.deathImg, a.widthImg * 2, a.heightImg, 0.4, 2)
  a.charAnimation = a.charAnimationRight
  a.charAnimation:seek(2)
  a.winWidth = winWidth
  a.winHeight = winHeight
  a.lastdt = 0
  a.dir = "right"
  a.move = false
  a.ending = false
  a.charBody = newCharBody(world, 0, 500, charWidth, charHeight)
  a.deathSound = love.audio.newSource("sound/qubodup-crash.ogg", "static")
  a.victoryImg = nil
  return setmetatable(a, Char)
end

function Char:keypressed(key, scancode, isrepeat )
  if (self.death == false) then
    if (key == "right") then
      self.dir = key
      self.move = true
      self.charAnimation:update(self.lastdt * 20)
      self.charAnimation = self.charAnimationRight
    end
    if (key == "left") then
      self.dir = key
      self.move = true
      self.charAnimation:update(self.lastdt * 20)
      self.charAnimation = self.charAnimationLeft
    end
  end
end

function Char:keyreleased(key)
  
   if (self.death == false) then
     if (key == "right") then
        if (self.dir == "right") then
          --self.dir = nil
          self.move = false
          self.charBody.body:setLinearVelocity(0, 0)
        end
        self.charAnimation:seek(2)
     end
     if (key == "left") then
        if (self.dir == "left") then
          --self.dir = nil
          self.move = false
          self.charBody.body:setLinearVelocity(0, 0)
        end
        self.charAnimation:seek(1)
     end
  end
end

function Char:update(dt)
  self.lastdt = dt
  if (self.move == true or self.death == true) then
    if (self.dir == "right") then
      self.charBody.body:setLinearVelocity(self.speed, 0)
    elseif (self.dir == "left") then
      self.charBody.body:setLinearVelocity(-self.speed, 0)
    end 
    self.charAnimation:update(dt)
    if (self.charAnimation:getCurrentFrame() == 2 and self.death == true) then
      self.ending = true
    end
  end
end

function Char:isEnd()
  return self.ending
end

function Char:isDeath()
  return self.death
end

function Char:deathSoundIsPlaying()
  return self.deathSound:isPlaying()
end

function Char:setDeath()
  self.charAnimation = self.charDeathAnimation
  self.charAnimation:seek(1)
  self.death = true
  love.audio.play(self.deathSound)
  --self.dir = "none"
end

function Char:setVictory()
    self.victoryImg = love.graphics.newImage("img/hero_stage_clear2.png")
end

function Char:getX()
  return self.charBody:getX() - 26
end

function Char:shot()
  if (self.dir == "right") then
    self.charAnimation:seek(1)
  else
    self.charAnimation:seek(2)
  end
end

function Char:getY()
  return self.charBody:getY() - 45
end

function Char:draw()
  if (self.victoryImg == nil) then
    self.charAnimation:draw(self.getX(self), self.getY(self))
  else
    love.graphics.draw(self.victoryImg, self.getX(self), self.getY(self))
  end  
end