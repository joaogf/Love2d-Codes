require('game_screen')
require('ctrl_screen')
require('screen_ids')
require('player')
require('home_menu_screen')

local player = newPlayer(3, 0)

function beginContact(a, b, coll)
  ctrlScreen:beginContact(a, b, coll)
end

local callbacks = 
{
  callback1 = beginContact
}

local stages =
{
    {numRandomBalls = 5, blocksConf = {}, background = "img/back1.png", music = "sound/n-c-h-tense.mp3", victory = "sound/3OpenSurgescorejingle-C.mp3"},
    {numRandomBalls = 5, blocksConf = {{200, 300, 128}, {600, 300, 128}}, background = "img/back1.png", music = "sound/n-c-h-tense.mp3", victory = "sound/3OpenSurgescorejingle-C.mp3"},
    {numRandomBalls = 10, blocksConf = {{200, 300, 128}, {600, 300, 128}}, background = "img/back1.png", music = "sound/n-c-h-tense.mp3", victory = "sound/3OpenSurgescorejingle-C.mp3"}

}

function love.load()
    ctrlScreen = newCtrlScreen()
    gameScreen = newGameScreen(stages, player, callbacks.callback1)
    homeMenuScreen = newHomeMenuScreen()
    ctrlScreen:addScreen(gameScreen, SCREEN_ID_GAME)
    ctrlScreen:addScreen(homeMenuScreen, SCREEN_ID_HOME_MENU)
    ctrlScreen:firstLoad()
end

function love.keypressed( key, scancode, isrepeat )
  ctrlScreen:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key)
  ctrlScreen:keyreleased(key)
end

function love.mousepressed(x, y, button, istouch)
  ctrlScreen:mousepressed(x, y)
end

function love.mousemoved(x, y, dx, dy, istouch)
  ctrlScreen:mousemoved(x, y)
end

function love.update(dt)
  ctrlScreen:update(dt)
end

function love.draw()
   ctrlScreen:draw()
end


