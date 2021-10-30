require("screen_ids")

RankingActions = {}

function raking_back_to_start_menu(screenMenu)
  screenMenu.nextScreen = SCREEN_ID_MENU
end

RankingActions[1] = raking_back_to_start_menu