local json = require('cjson')

local constr = {}
constr.config_path = nil

function constr.setup()
	-- Setup the constructor
	if constr.config_path == nil then error("Missing constructor config path") end
end

function read_json_file(json_path)
	-- Opens a file and decodes the json format.
	-- Returns a table containing the json data
	return json.decode(io.open(json_path, "r"):read "a")
end

function construct_image(path)
	-- Construct and returns a love image with the given path.
	return love.graphics.newImage(constr.config_path .. path)
end

function construct_audio_source(path, audio_type)
	-- Construct and returns a love audio with the given path.
	-- Audio type can be 'stream' or 'static'
	return love.audio.newSource(constr.config_path .. path, audio_type)
end

function report_construct_failure(path, default_path)
	-- Formats and prints an invalid constructor path
	message = string.format(
		"Unable to find '%s', trying default path '%s'",
		game.config_path .. path,
		default_path
	)
	print(message)
end

return constr
