local Ranking = {}
Ranking.__index = Ranking

function newRanking()
  local a = {}
  a.filename = "FileGames/save.popSave"
  a.fontName = "fonts/Pacifico.ttf"
  return setmetatable(a, Ranking)
end

function Ranking:updatePoints(points)
  local indexVec = 1
  local vecPoints = {}
  
  for line in love.filesystem.lines(self.filename) do
    vecPoints[indexVec] = tonumber(line)
    indexVec = indexVec + 1
  end
  
  table.sort(vecPoints)
    
  if (points > vecPoints[1]) then
    vecPoints[1] = points
    local i = 1
    while (i < #vecPoints and vecPoints[i] > vecPoints[i + 1]) do
     vecPoints[i], vecPoints[i + 1] = vecPoints[i + 1], vecPoints[i] 
     i = i + 1
    end
  end

  local file = io.open (self.filename, "w")
  io.output(file)
  for i = #vecPoints, 1, -1 do
    io.write(vecPoints[i], '\n')
  end
  io.close()
  
end

function Ranking:draw(initX, initY, w, h)
  local lineNum = 0
  local distance = h
  
  love.graphics.setFont(love.graphics.newFont(self.fontName, 30))
  
  love.graphics.print("Melhores Pontuações:", initX - 30, initY - 60)
  
  for line in love.filesystem.lines(self.filename) do
    love.graphics.setColor( 0, 0, 0)
    love.graphics.rectangle("fill", initX - 1, initY - 1 + distance * lineNum, w, h)
    love.graphics.setColor(0, 128, 128)
    love.graphics.rectangle("fill", initX, initY + distance * lineNum, w, h)
    love.graphics.setColor( 255, 255, 255)
    love.graphics.print(line, initX, initY + distance * lineNum - h / 2)
    lineNum = lineNum + 1
  end
end