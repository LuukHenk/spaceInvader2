local json = require('cjson')

local constr = {}
constr.config_path = ""

function constr.setup()
	constr.level_structures = constr.config_path .. "levels.json"
	constr.default_background_path = constr.config_path .. "sprites/default.png"
	constr.default_soundtrack_path = constr.config_path .. "soundtracks/default.mp3"
end

function constr.construct()
	local levels = {}
	for level_id, level_config in pairs(read_json_file(constr.level_structures)) do
		levels[level_id] = construct_level(level_config)
	end
	return levels
end

function read_json_file(json_path)
	return json.decode(io.open(json_path, "r"):read "a")
end

function construct_level(config)
	local level = {}
	level.background = construct_background(config.background_path)
	level.soundtrack = construct_soundtrack(config.soundtrack_path)
	-- level.enemies	 = construct_enemies(config.enemies)
	return level
end

function construct_background(path)
	success, background = pcall(construct_image, path)
	if success ~= true then
		report_construct_failure(path, default_background_path)
		background = construct_image(default_background_path)
	end
	return background
end

function construct_soundtrack(path)
	audio_type = "stream"
	success, soundtrack = pcall(construct_audio_source, path, audio_type)
	if success ~= true then
		report_construct_failure(path, default_soundtrack_path)
		soundtrack = construct_audio_source(default_soundtrack_path, audio_type)
	end
	return soundtrack
end

function construct_image(path)
	return love.graphics.newImage(constr.config_path .. path)
end

function construct_audio_source(path, audio_type)
	return love.audio.newSource(constr.config_path .. path, audio_type)
end

function report_construct_failure(path, default_path)
	message = string.format(
		"Unable to find '%s', trying default path '%s'",
		game.config_path .. path,
		default_path
	)
	print(message)
end

return constr
