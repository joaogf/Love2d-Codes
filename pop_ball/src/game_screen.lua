local GameScreen = {}
GameScreen.__index = GameScreen


function newGameScreen(player)
  local a = {}
  a.balls = nil
  a.lose = nil
  a.points = nil
  a.nextLevel = nil
  a.nextScreen = nil
  a.background = nil
  a.fontFilename = nil
  a.player = player
  return setmetatable(a, GameScreen)
end

function GameScreen:loadGame(numBalls, points, nextLevel, fontFilename, screenIndex)
  math.randomseed(os.time())
  self.actions = actions
  self.player.points = points
  self.nextLevel = nextLevel
  self.fontFilename = fontFilename
  self.balls = newBalls(numBalls)
  self.balls:initAllBalls()
  self.background = love.graphics.newImage("imgs/sky.png")
  self.nextScreen = screenIndex
end

function GameScreen:mousemoved(x, y)
  
end

function GameScreen:mousepressed(x, y)
  self.player.points = self.player.points + self.balls:checkClickBalls(x, y)
  if (self.player.points >= self.nextLevel) then
    self.balls:IncNumBalls()
    self.nextLevel = self.nextLevel + 10
  end
end

function GameScreen:getNextScreen()
  return self.nextScreen
end

function GameScreen:reinit()
    self.balls:reinit()
    self.player.points = 0
    self.nextLevel = 10
    self.player.reinit = false
end

function GameScreen:update(dt)
  self.player.lose = self.balls:updateBalls(dt)
  if (self.player.lose == true) then
    self.nextScreen = SCREEN_ID_GAME_OVER
    --Atualizar ranking
    local ranking = newRanking()
    ranking:updatePoints(self.player.points)
  end
end

function GameScreen:draw()
  if (self.player.reinit == true) then
    self.reinit(self)
  end
  love.graphics.draw(self.background, 0, 0)
  self.balls:drawBalls()
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(love.graphics.newFont(self.fontFilename, 15))
  love.graphics.print("PONTOS: " .. self.player.points, 650, 400)
  love.graphics.setColor(255, 255, 255, 255)
end
