require("menu_option")

local MenuGame = {}
MenuGame.__index = MenuGame

function newMenuGame()
  local a = {}
  a.fontName = "fonts/Pacifico.ttf"
  a.options = {}
  a.onColor = {128, 128, 0}
  a.offColor = {0, 128, 128}
  return setmetatable(a, MenuGame)
end

function MenuGame:setAllOptsOffColor()
    for i = 1, #self.options do
        self.options[i].color = self.offColor
    end
end

function MenuGame:mousePressed(mouseX, mouseY)
  for i = 1, #self.options do
    if (checkMousePosInQuad(mouseX, mouseY, self.options[i].x, self.options[i].y, 
        self.options[i].w, self.options[i].h)) then
      return i
    end
  end
  return -1
end

function MenuGame:mousePressedActions(screen, mouseX, mouseY)
  local clickedOpt = self.mousePressed(self, mouseX, mouseY)
  if (clickedOpt ~= -1) then
      screen.actions[clickedOpt](screen)
  end
end

function MenuGame:mouseMoved(mouseX, mouseY)
    local mouseOverIndex = self.mousePressed(self, mouseX, mouseY)
    self.setAllOptsOffColor(self)
    if (mouseOverIndex ~= -1) then
      self.options[mouseOverIndex].color = self.onColor
    end
end

function MenuGame:update(dt)
end

function MenuGame:addOption(x, y, w, h, text)
  self.options[#self.options + 1] = newMenuOption({0, 128, 128}, x, y, w, h, text)
end


function MenuGame:drawOption(option)
  love.graphics.setColor( 0, 0, 0)
  love.graphics.rectangle("fill", option.x - 1, option.y-1, option.w + 2, option.h + 2)
  love.graphics.setColor(option.color)
  love.graphics.rectangle("fill", option.x, option.y, option.w, option.h)
  love.graphics.setColor( 255, 255, 255)
  love.graphics.setFont(love.graphics.newFont(self.fontName, 15))
  love.graphics.print(option.text, option.x, option.y + 20 - 15)
end



function MenuGame:draw()
    for index = 1, #self.options do
      self.drawOption(self, self.options[index])
    end
end

