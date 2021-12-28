local constructor = require "lib/constructor"

local game = {}
game.levels = {}
game.player = {}
game.config_path = "."

function game.load_config()
	local json_level_structures = game.config_path .. "levels.json"
	game.levels = constructor.construct_game_levels(json_level_structures)
	local player_config = game.config_path .. "player.json"
end
return game
