

function drawQuad(mode, x, y, length)
  love.graphics.rectangle(mode, x, y, length, length)
end

--Função Callback draw e chamada em cada frame pelo love2d
function love.draw()
  
  --Desenhando retângulo
  
  --love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  
  -- o mode indica se o retângulo será preenchido ou não, os valores são "fill" ou "line"
  -- x é a posição x que o retângulo irá ficar na tela, essa posição e' a partir do topo esquerdo da tela
  -- y é a posição y que o retângulo irá ficar na tela, essa posição e' a partir do topo esquerdo da tela
  -- width é a largura do retângulo
  -- height é a altura do retângulo
  -- O raio do eixo x para cada canto redondo. não pode ser superior a metade da largura do retângulo.
  -- O raio do eixo y para cada canto redondo. não pode ser superior a metade da altura do retângulo.
  -- O número de segmentos usados para desenhar os cantos arredondados. A quantidade padrão será escolhido 
  -- se nenhum número  for dado.
  
  --Podemos desenhar o retângulo sem passar os três últimos parâmentros
  love.graphics.rectangle("fill", 20, 50, 60, 120)
  
  --Desenhando um retângulo sem preenchimento de cor
  love.graphics.rectangle("line", 150, 50, 60, 120)
  
  --Podemos escolher a cor do retângulo usando a função setColor
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 20, 180, 60, 120)
  love.graphics.rectangle("line", 150, 180, 60, 120)
  
  --Todos os retângulos ficaram vermelhos, devemos após desenhar os retângulos vermelhos
  --restaurar a a cor branca padrão
  love.graphics.setColor(255, 255, 255)
  
  --Utilizando os demais parâmentros podemos deixar o retângulo arredondado
  love.graphics.rectangle("fill", 20, 310, 60, 120, 10, 10)
  love.graphics.rectangle("line", 150, 310, 60, 120, 10, 10)
  
  --Podemos criar função para desenhar um quadrado utilizando a função de desenhar retângulo
  drawQuad("fill", 240, 50, 60)
  drawQuad("line", 240, 120, 60)
  
  --love.graphics.circle( mode, x, y, radius, segments )
  
  --Para desenhar circulos
  love.graphics.setColor(0, 0, 255)
  love.graphics.circle("fill", 300, 300, 50)
  love.graphics.circle("line", 300, 410, 50)
  love.graphics.setColor(255, 255, 255)
  
  --desenhando um poligono qualquer
  
  -----------------x1,y1,x2,y2,x3,y3
  local vertices = {400, 400, 500, 400, 450, 500}
  
  --love.graphics.polygon( mode, vertices )
 
  love.graphics.polygon('fill', vertices)
   
end