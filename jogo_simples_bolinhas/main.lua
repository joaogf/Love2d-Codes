require("balls")

local lose = false
local nextLevel = 10
local points = 0
local balls = nil

function love.load()
  
  love.window.setTitle("Jogo de Bolinhas")
  balls = newBalls(3, 30)
  balls:initAllBalls()
  
end

function love.update()
  lose = balls:updateBalls()
end

function love.mousepressed(x, y, button, istouch)
  points = points + balls:checkClickBalls(x, y, points, nextLevel)
  
    if (points == nextLevel) then
      balls:IncNumBalls()
      nextLevel = nextLevel + 10
    end
  
  if (lose == true) then
    balls:reinit() 
    lose = false
    points = 0
  end
end


function love.draw()
  if (lose == false) then
    balls:drawBalls()
  else
    love.graphics.print("FIM DE JOGO", 350, 300)
  end
  
  
  love.graphics.print("PONTOS: " .. points, 700, 400)
end