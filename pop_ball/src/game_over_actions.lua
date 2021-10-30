require("screen_ids")

GameOverActions = {}

function game_over_back_to_game(screenMenu)
  screenMenu.nextScreen = SCREEN_ID_GAME
  screenMenu.player.lose = false
  screenMenu.player.reinit = true
end

function game_over_back_to_start_menu(screenMenu)
  screenMenu.nextScreen = SCREEN_ID_MENU
  screenMenu.player.lose = false
  screenMenu.player.reinit = true
end

GameOverActions[1] = game_over_back_to_game
GameOverActions[2] = game_over_back_to_start_menu