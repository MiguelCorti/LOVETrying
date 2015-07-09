function love.load()
	-- Background
	background = { x1 = 800, x2 = 0, y = 450, width = 0, img = nil }
	background.img = love.graphics.newImage('assets/background.png')
	background.width = background.img:getWidth()

	-- Angel
	angel = {walkingFrames = {} }

	angelWalkCounter = 0
	angelWalkTimer = 0
	angel.walkingFrames[0] = love.graphics.newImage('assets/angel00.png')
	angel.walkingFrames[1] = love.graphics.newImage('assets/angel01.png')
	angel.walkingFrames[2] = love.graphics.newImage('assets/angel02.png')
	angel.walkingFrames[3] = love.graphics.newImage('assets/angel03.png')
	angel.walkingFrames[4] = love.graphics.newImage('assets/angel04.png')
	angel.walkingFrames[5] = love.graphics.newImage('assets/angel05.png')
	angel.walkingFrames[6] = love.graphics.newImage('assets/angel06.png')
	angel.walkingFrames[7] = love.graphics.newImage('assets/angel05.png')
	angel.walkingFrames[8] = love.graphics.newImage('assets/angel04.png')

end

function love.update(dt)
	-- Background
	if background.x1 <= -love.graphics.getWidth() then background.x1 = 800 end
	if background.x2 <= -love.graphics.getWidth() then background.x2 = 800 end

	if love.keyboard.isDown('d') then
		background.x1 = background.x1 - 1
		background.x2 = background.x2 - 1
		
		angelWalkTimer = angelWalkTimer + dt

		if angelWalkTimer >= 0.2 then
			angelWalkCounter = angelWalkCounter + 1
			angelWalkTimer = 0
		end

		if angelWalkCounter >= 8 then
			angelWalkCounter = 3
		end
	end

	if not love.keyboard.isDown('d') then
		angelWalkCounter = 0
	end
end

function love.draw()
	love.graphics.draw(background.img, background.x1, background.y)
	love.graphics.draw(background.img, background.x2, background.y)

	love.graphics.draw(angel.walkingFrames[angelWalkCounter], 50, 352)
end

