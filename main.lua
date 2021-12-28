game = require "lib/game"
game.config_path = "config/"

function love.load()

	-- Test vars
	test = true
	love.window.setFullscreen(true, 'desktop')
	screen = {}
	screen.width = love.graphics.getWidth()
	screen.height = love.graphics.getHeight()
	-- end test vars

	game.load_config()


end

function love.update(dt)
	if test == true then
		game.levels["level1"].soundtrack:play()
		test = false
	end
end

function love.draw()
	love.graphics.draw(game.levels["level1"].background)
end
