local level_constructor = require "lib/level_constructor"
local game = {}
game.levels = {}
game.player = {}
game.config_path = nil

function game.load_config()
	-- Load the full game configuration
	-- Returns true when it is done
	if game.config_path == nil then
		error("Please set the game config path first")
	end

	level_constructor.config_path = game.config_path
	level_constructor.setup()
	game.levels = level_constructor.construct()

	-- local player_config = game.config_path .. "player.json"
	-- local enemy_types = game.config_path .. "enemy_types.json"
	return true
end
return game
