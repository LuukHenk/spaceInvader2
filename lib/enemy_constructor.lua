local constr = {}
constr.config_path = nil

function constr.setup()
	if constr.config_path == nil then
		error("Please set the level constructor config path first")
	end
	constr.level_structures = constr.config_path .. "enemies.json"
end
