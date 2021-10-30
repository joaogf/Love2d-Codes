local Block = {}
Block.__index = Block

function newBlock(world, xBody, yBody, width, height, color)
  local a = {}
  a.body = love.physics.newBody(world, xBody, yBody, "static") 
  a.shape = love.physics.newRectangleShape(width, height) 
  a.fixture = love.physics.newFixture(a.body, a.shape); 
  a.color = color
  return setmetatable(a, Block)
end

function Block:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
  love.graphics.setColor(self.color) -- set the drawing color to green for the Block
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  love.graphics.setColor(255, 255, 255) -- set the drawing color to green for 
end