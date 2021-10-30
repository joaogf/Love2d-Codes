require("ranking")

local RankingScreen = {}
RankingScreen.__index = RankingScreen


function newRankingScreen()
  local a = {}
  a.background = nil
  a.nextScreen = nil
  a.actions = nil
  a.menu = nil
  a.ranking = nil
  return setmetatable(a, RankingScreen)
end

function RankingScreen:loadRanking(actions, screenIndex)
  self.nextScreen = screenIndex
  self.background = love.graphics.newImage("imgs/sky.png")
  self.menu = newMenuGame()
  self.menu:addOption(320, 400, 150, 40, "Voltar ao Menu Inicial")
  self.ranking = newRanking()
  self.actions = actions
  
end

function RankingScreen:update(dt)

end

function RankingScreen:mousemoved(x, y)
  self.menu:mouseMoved(x, y)
end

function RankingScreen:mousepressed(x, y)
  self.menu:mousePressedActions(self, x, y)
end

function RankingScreen:getNextScreen()
  return self.nextScreen
end

function RankingScreen:draw()
    love.graphics.draw(self.background, 0, 0)
    self.menu:draw()
    self.ranking:draw(320, 100, 150, 40)
end


