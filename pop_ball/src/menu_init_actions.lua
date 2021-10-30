require("screen_ids")

initMenuActions = {}

function init_menu_start_game(screenMenu)
  screenMenu.nextScreen = SCREEN_ID_GAME
end

function init_menu_exit(screenMenu)
  love.event.quit()
end

function init_menu_ranking(screenMenu)
  screenMenu.nextScreen = SCREEN_ID_RANKING
end


initMenuActions[1] = init_menu_start_game
initMenuActions[2] = init_menu_ranking
initMenuActions[3] = init_menu_exit