require("free_fall")

local fallCircle = nil
local r = nil

function love.load()
  r = 30
  fallCircle = newFreeFall(9.80665, 0.0, 400.0, 0.0, 600.0, 0.001, 30)
end

function love.mousepressed(x, y, button, istouch)
  fallCircle:reInit()
end

function love.update(dx)
  fallCircle:update()
end

function love.draw()
  love.graphics.circle("fill", fallCircle:getX(), fallCircle:getY(), r)
end