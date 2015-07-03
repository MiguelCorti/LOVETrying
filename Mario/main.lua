debug = true

function love.load(arg)
	-- Loading Background
	background = { x1 = 800, x2 = 0, y = 450, width = 0, img = nil }
	background.img = love.graphics.newImage('assets/background.png')
	background.width = background.img:getWidth()

	-- Loading Mario
	marioFrames = {}
	marioFrames[0] = love.graphics.newImage('assets/mario01.png')
	marioFrames[1] = love.graphics.newImage('assets/mario02.png')
	marioFrames[2] = love.graphics.newImage('assets/mario03.png')
	marioFrames.counter = 0
	marioFrames.timer = 0
end

function love.update(dt)
	-- Background
	if background.x1 <= -love.graphics.getWidth() then background.x1 = 800 end
	if background.x2 <= -love.graphics.getWidth() then background.x2 = 800 end

	-- Mario Walking
	if love.keyboard.isDown('d') then
		marioFrames.timer = marioFrames.timer + dt
		--marioFrames.actual = marioFrames[marioFrames.counter]
		if love.keyboard.isDown('lshift') then
			background.x1 = background.x1 - 2
			background.x2 = background.x2 - 2
			if marioFrames.timer >= 0.1 then
				marioFrames.counter = marioFrames.counter + 1 
				marioFrames.timer = 0
			end
		else
			background.x1 = background.x1 - 1
			background.x2 = background.x2 - 1
			if marioFrames.timer >= 0.2 then
				marioFrames.counter = marioFrames.counter + 1 
				marioFrames.timer = 0
			end
		end

		if marioFrames.counter > 2 then marioFrames.counter = 0 end
	end

	-- Keyboard Commands
	-- Quit Game
	if love.keyboard.isDown('escape') then
		love.event.quit('quit')
	end
	
end

function love.draw(dt)
	love.graphics.draw(background.img, background.x1, background.y)
	love.graphics.draw(background.img, background.x2, background.y)

	love.graphics.draw(marioFrames[marioFrames.counter], 50, 390)
end