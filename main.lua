game = require "lib/game"
game.config_path = "config/"

function love.load()
	game.load_config()

	test = true
end

function love.update(dt)
	if test == true then
		game.levels["level1"].soundtrack:play()
		test = false
	end
end

function love.draw()
end
