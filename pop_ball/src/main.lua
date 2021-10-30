require("ctrl_screen")
require("game_screen")
require("game_over_screen")
require("ranking_screen")
require("menu_screen")
require("menu_init_actions")
require("ranking_actions")
require("game_over_actions")


local player = {}
player.points = 0
player.lose = false
player.reinit = false

function love.load()
  love.window.setTitle("Jogo de Bolinhas")
  music = love.audio.newSource("sound/blast_off.mp3", "stream")
  music:setLooping(true)
  love.audio.play(music)
  
  menuScreen = newMenuScreen()
  gameScreen = newGameScreen(player)
  gameOverScreen = newGameOverScreen(player)
  ctrlScreen = newCtrlScreen()
  rankingScreen = newRankingScreen()
  
  menuScreen:loadMenu({
      {320, 400, 150, 40, "Iniciar o Jogo"},
      {320, 450, 150, 40, "Ranking de Pontos"},
      {320, 500, 150, 40, "Sair do Jogo"}
      }, initMenuActions, 5, SCREEN_ID_MENU)
  gameScreen:loadGame(5, 0, 10, "fonts/Pacifico.ttf", SCREEN_ID_GAME)
  gameOverScreen:loadGameOver(GameOverActions, "fonts/Pacifico.ttf", SCREEN_ID_GAME_OVER)
  rankingScreen:loadRanking(RankingActions, SCREEN_ID_RANKING)
  
  ctrlScreen:addScreen(menuScreen)
  ctrlScreen:addScreen(gameScreen)
  ctrlScreen:addScreen(gameOverScreen)
  ctrlScreen:addScreen(rankingScreen)
end

function love.update(dt)
  ctrlScreen:update(dt)
end

function love.mousemoved(x, y, dx, dy, istouch)
  ctrlScreen:mousemoved(x, y)
end

function love.mousepressed(x, y, button, istouch)
  ctrlScreen:mousepressed(x, y)
end

function love.draw()
  ctrlScreen:draw()
end