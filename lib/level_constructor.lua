local json = require('cjson')
-- local enemy_constructor = require "lib/enemy_constructor"

local constr = require "lib/constr_base"

function constr.setup()
	-- Function sets the default paths
	constr.level_structures = constr.config_path .. "levels.json"
	constr.default_background_path = constr.config_path .. "sprites/default.png"
	constr.default_soundtrack_path = constr.config_path .. "soundtracks/default.mp3"
end

function constr.construct()
	-- Construct all the levels and returns them in table format
	local levels = {}
	for level_id, level_config in pairs(read_json_file(constr.level_structures)) do
		levels[level_id] = construct_level(level_config)
	end
	return levels
end

function construct_level(config)
	-- Constructs all the elements of a single level and returns them as a table
	local level = {}
	level.background = construct_background(config.background_path)
	level.soundtrack = construct_soundtrack(config.soundtrack_path)
	-- level.enemies	 = construct_enemies(config.enemies)
	return level
end

function construct_background(path)
	-- Tries to construct the given background, uses default if failure
	-- Returns a love image
	success, background = pcall(construct_image, path)
	if success ~= true then
		report_construct_failure(path, default_background_path)
		background = construct_image(default_background_path)
	end
	return background
end

function construct_soundtrack(path)
	-- Tries to construct the given soundtrack, uses default if failure
	-- Returns a love audio
	audio_type = "stream"
	success, soundtrack = pcall(construct_audio_source, path, audio_type)
	if success ~= true then
		report_construct_failure(path, default_soundtrack_path)
		soundtrack = construct_audio_source(default_soundtrack_path, audio_type)
	end
	return soundtrack
end

return constr
