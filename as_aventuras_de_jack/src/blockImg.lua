local BlockImg = {}
BlockImg.__index = BlockImg

function newBlockImg(world, xBody, yBody, width, img)
  local a = {}
  a.img = love.graphics.newImage(img)
  a.body = love.physics.newBody(world, xBody, yBody, "static")
  a.shape = love.physics.newRectangleShape(width, a.img:getHeight()) 
  a.fixture = love.physics.newFixture(a.body, a.shape); 
  a.width = width
  return setmetatable(a, BlockImg)
end

function BlockImg:draw()
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  local initX = self.body:getX() - self.img:getWidth() / 2 * (self.width / self.img:getWidth())
  for i = 0, self.width - self.img:getWidth(), self.img:getWidth() do
    love.graphics.draw(self.img, initX + i , self.body:getY() - self.img:getHeight() / 2) 
  end
end