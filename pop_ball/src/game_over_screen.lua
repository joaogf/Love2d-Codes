local GameOverScreen = {}
GameOverScreen.__index = GameOverScreen


function newGameOverScreen(player)
  local a = {}
  a.fontFilename = nil
  a.background = nil
  a.player = player
  a.menu = nil
  a.actions = nil
  return setmetatable(a, GameOverScreen)
end

function GameOverScreen:loadGameOver(actions, fontFilename, screenIndex)
  self.fontFilename = fontFilename
  self.background = love.graphics.newImage("imgs/sky.png")
  self.nextScreen = screenIndex
  self.menu = newMenuGame()
  self.menu:addOption(350, 400, 150, 40, "Voltar ao Jogo")
  self.menu:addOption(350, 450, 150, 40, "Voltar ao Menu Inicial")
  self.actions = actions
end

function GameOverScreen:mousemoved(x, y)
   self.menu:mouseMoved(x, y)
end

function GameOverScreen:mousepressed(x, y)
  self.menu:mousePressedActions(self, x, y)
end

function GameOverScreen:getNextScreen()
  return self.nextScreen
end

function GameOverScreen:update(dt)

end

function GameOverScreen:draw()
    love.graphics.draw(self.background, 0, 0)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.setFont(love.graphics.newFont(self.fontFilename, 20))
    love.graphics.print("PONTOS: " .. self.player.points, 650, 400)
    love.graphics.print("FIM DE JOGO", 350, 300)
    love.graphics.setColor(255, 255, 255, 255)
    self.menu:draw()
end
