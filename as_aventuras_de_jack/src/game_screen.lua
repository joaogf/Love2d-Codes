require('block')
require('blockImg')
require('char')
require('ball')
require('shot')


local GameScreen = {}
GameScreen.__index = GameScreen


local colorGreen = {0 / 255, 255/ 255, 127 / 255, 0.9}
local colorBlue = {0,120,180}
local colorPurple = {148,0,211}

function newGameScreen(stages, player, callback)
  local a = {}
  a.stages = stages
  a.cntStage = 1
  a.numRandomBalls = nil
  a.curBalls = nil
  a.blocksConf = nil
  a.blocks = {}
  a.nextScreen = SCREEN_ID_GAME
  a.world = nil
  a.ground = nil
  a.leftSide = nil
  a.rightSide = nil
  a.upSide = nil
  a.balls = {}
  a.shot = nil
  a.char = nil
  a.callback = callback
  a.background = nil
  a.music = nil
  a.stageClear = nil
  a.victoryOst = nil
  a.font = nil
  a.optFont = nil
  a.player = player
  return setmetatable(a, GameScreen)
end

function GameScreen:unload()
  self.numRandomBalls = nil
  self.curBalls = nil
  self.blocksConf = nil
  self.blocks = {}
  sefl.nextScreen = SCREEN_ID_GAME
  self.world = nil
  self.ground = nil
  self.leftSide = nil
  self.rightSide = nil
  self.upSide = nil
  self.balls = {}
  self.shot = nil
  self.char = nil
  self.background = nil
  self.music = nil
  self.stageClear = nil
  self.victoryOst = nil
  self.font = nil
  self.optFont = nil
end

function GameScreen:beginContact(a, b, coll)
  if (a:getUserData() == "Char" and b:getUserData() == "Ball") then
    self.char:setDeath()
  end
  if (a:getUserData() == "Shot" or b:getUserData() == "Shot") then
    if (self.shot ~= nil) then
      self.shot:setExplosion()
    end
    if (a:getUserData() == "Ball") then
      a:getBody():destroy()
      self.balls[a:getBody():getUserData()] = nil
      self.curBalls = self.curBalls - 1
    elseif (b:getUserData() == "Ball") then
      b:getBody():destroy()
      self.player:incrementPoints(self.balls[b:getBody():getUserData()]:getPoints())
      self.balls[b:getBody():getUserData()] = nil
      self.curBalls = self.curBalls - 1
    end
  end
end


function GameScreen:load()
  self.stageClear = false
  love.physics.setMeter(64)
  math.randomseed(os.time())
  self.world = love.physics.newWorld(0, 9.81 * 64)
  self.world:setCallbacks(self.callback)
  self.ground = newBlock(self.world, 800 / 2, 600-90/2, 800, 10, colorGreen)
  self.leftSide = newBlock(self.world, 0, 600 / 2, 15, 600, colorGreen)
  self.rightSide = newBlock(self.world, 800, 600 / 2, 15, 600, colorGreen)
  self.upSide = newBlock(self.world, 800 / 2, 0, 800, 15, colorGreen)
  self.balls = {}
  self.numRandomBalls = self.stages[self.cntStage].numRandomBalls
  self.curBalls = self.numRandomBalls
  self.blocksConf = self.stages[self.cntStage].blocksConf
  for i = 1, self.numRandomBalls, 1 do
    self.balls["Ball" .. i] = newBall(self.world, math.random(100, 600), math.random(50, 100), "Ball" .. i)
  end
  self.char = newChar(self.world, 150, 53, 98, "img/heroR2.png", "img/heroL2.png"
    , "img/death.png", love.graphics.getWidth(), love.graphics.getHeight())
  
  
  for i = 1, #self.blocksConf, 1 do
    self.blocks[i] = newBlockImg(self.world, self.blocksConf[i][1] , 
      self.blocksConf[i][2], self.blocksConf[i][3], "img/block1.png")
  end
  
  self.shot = nil
  self.nextScreen = SCREEN_ID_GAME
  self.background = love.graphics.newImage(self.stages[self.cntStage].background)
  
  self.music = love.audio.newSource(self.stages[self.cntStage].music, "stream")
  self.victoryOst = love.audio.newSource(self.stages[self.cntStage].victory, "stream")
  self.music:setLooping(true)
  self.victoryOst:setLooping(false)
  love.audio.play(self.music)
  
  self.font = love.graphics.newFont("font/SquaresBoldFree.otf", 40)
  self.optFont = love.graphics.newFont("font/pixlkrud.ttf", 30)
  
end

function GameScreen:keypressed( key, scancode, isrepeat )
  self.char:keypressed(key, scancode, isrepeat)
end

function GameScreen:keyreleased(key)
  self.char:keyreleased(key)
  if (key == 'a') then
    if (self.shot == nil) then
      if (self.char.dir == "right") then
        self.shot = newShot(self.world, self.char:getX() + 16, self.char:getY() + 32, self.char.dir)
      else
        self.shot = newShot(self.world, self.char:getX() - 16, self.char:getY() + 32, self.char.dir)
      end
      self.char:shot()
    end
  end
end

function GameScreen:mousemoved(x, y)
  
end

function GameScreen:mousepressed(x, y)

end

function GameScreen:getNextScreen()
  return self.nextScreen
end

function GameScreen:reinit()
end

function GameScreen:updateStageClear(dt)
  for key,ball in pairs(self.balls) do
    ball:update()
  end
  if (self.shot ~= nil) then
    self.shot:update(dt)
  end
  
  if (self.victoryOst:isPlaying() == false) then
    self.load(self, self.nextScreen, self.callback)
  end
end

function GameScreen:gameUpdate(dt)
  if (self.char:isDeath() == false) then
    self.world:update(dt)
    for key,ball in pairs(self.balls) do
      ball:update()
    end
    if (self.shot ~= nil) then
      self.shot:update(dt)
    end
  elseif (self.char:deathSoundIsPlaying() == false 
              and self.char:isEnd()
              and self.player:getLife() > 0) then
    love.timer.sleep(1)
    self.player:downLife()
    love.audio.stop()
    self.load(self, self.nextScreen, self.callback)
  end
  if (self.char:isEnd() == false) then
    self.char:update(dt)
  end
  
  if (self.curBalls == 0 and self.cntStage < #self.stages) then
    self.cntStage = self.cntStage + 1
    love.audio.stop()
    self.char:setVictory()
    love.audio.play(self.victoryOst)
    self.stageClear = true
  end
end

function GameScreen:update(dt)
  if (self.stageClear == false) then
    self.gameUpdate(self, dt)
  else
    self.updateStageClear(self, dt)
  end
end

function GameScreen:draw()
  love.graphics.draw(self.background, 0, 0)
  self.ground:draw()
  self.leftSide:draw()
  self.rightSide:draw()
  self.upSide:draw()
  for i = 1, #self.blocks, 1 do
    self.blocks[i]:draw()
  end
  for key,ball in pairs(self.balls) do
    ball:draw()
  end
  self.char:draw()
  if (self.shot ~= nil) then
      self.shot:draw()
      if (self.shot:isEnd()) then
        self.shot:clean()
        self.shot = nil
      end
  end
  if (self.stageClear == true) then
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Fase Completada", (800 - 40 * 10) / 2, (600 - 40) / 2)
    love.graphics.setColor(255, 213, 0)
    love.graphics.print("Fase Completada", (800 - 40 * 10) / 2, (600 - 35) / 2)
    love.graphics.setColor(255, 255, 255)
  end
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 8, 560, 785, 50)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.player:getPlayerLifeImg(), 12, 560)
  love.graphics.setColor(255, 213, 0)
  love.graphics.setFont(self.optFont)
  love.graphics.print("X " .. self.player:getLife(), 50, 570)
  love.graphics.print("Pontos.", 150, 570)
  love.graphics.setColor(colorGreen)
  love.graphics.print(self.player:getPoints(), 265, 570)
  love.graphics.setColor(255, 255, 255)
  
end