local json = require('cjson')

local constructor = {}
local default_background_path = "sprites/default.png"
local default_soundtrack_path = "soundtracks/default.mp3"

function constructor.construct_game_levels(levels_path)
	local levels = {}
	for level_id, level_config in pairs(read_json_file(levels_path)) do
		levels[level_id] = construct_single_level(level_config)
	end
	return levels
end

function construct_single_level(config)
	local level = {}
	level.background = construct_background(config.background_path)
	level.soundtrack = construct_soundtrack(config.soundtrack_path)
	return level
end

function construct_background(path)
	success, background = pcall(construct_image, path)
	if success ~= true then
		report_construct_failure(path, default_background_path)
		default_success, background = pcall(
			construct_image(default_background_path)
		)
		if default_success ~= true then
			love.errhand("Failed to load default background")
		end
	end
	return background
end

function construct_soundtrack(path)
	success, soundtrack = pcall(construct_audio_source, path, "stream")
	if success ~= true then
		report_construct_failure(path, default_soundtrack_path)
		soundtrack = construct_audio_source(default_soundtrack_path, "stream")
	end
	return soundtrack
end

function construct_image(path)
	return love.graphics.newImage(game.config_path .. path)
end

function construct_audio_source(path, audio_type)
	return love.audio.newSource(game.config_path .. path, audio_type)
end

function report_construct_failure(path, default_path)
	message = string.format(
		"Unable to find '%s', trying default path '%s'",
		game.config_path .. path,
		default_path
	)
	print(message)
end

function read_json_file(json_path)
	return json.decode(io.open(json_path, "r"):read "a")
end


return constructor
