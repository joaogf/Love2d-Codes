function checkMousePosIn(mouseX, mouseY, centerX, centerY, r)
  
  local distance = math.sqrt(math.pow(mouseX - centerX, 2) + 
    math.pow(mouseY - centerY, 2))
  
  if (distance <= r) then
    return true
  end
  
  return false
  
end

function checkMousePosInQuad(mouseX, mouseY, objX, objY, objW, objH)
  if (not (mouseY >= objY and mouseY <= objY + objH)) then
    return false
  end
  if (not (mouseX >= objX and mouseX <= objX + objW)) then
    return false
  end
  return true
end