debug = true

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load(arg)
	-- Creating Player
	player = {x = 240, y = 550, speed = 250, img = nil, score = 0, isAlive = true}
	player.img = love.graphics.newImage("/assets/aircraft.png")
	-- Creating Bullets
	canShoot = true
	canShootTimerMax = 0.2
	canShootTimer = canShootTimerMax

	bulletImg = love.graphics.newImage('assets/bullet.png')
	bulletSound = love.audio.newSource('assets/gunShot.wav')

	bullets = {}
	-- Creating Enemies
	enemyTimerMax = 0.5
	enemyTimer = enemyTimerMax

	enemyImg = love.graphics.newImage('assets/enemy.png')

	enemies = {}

	boomSound = love.audio.newSource('assets/boom.wav', 'stream')
end

function love.update(dt)
	-- Enemies
	enemyTimer = enemyTimer - dt
	if enemyTimer < 0 then
		enemyTimer = enemyTimerMax

		-- Create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)
		newEnemy = { x = randomNumber, y = -10, img = enemyImg }
		table.insert(enemies, newEnemy)
	end

	-- Bullets Timer
	canShootTimer = canShootTimer - dt
	if canShootTimer < 0 then
  		canShoot = true
	end

	-- Keyboard Commands
	-- Quit Game
	if love.keyboard.isDown('escape') then
		love.event.quit('quit')
	end
	-- Moving Player
	if love.keyboard.isDown('left', 'a') then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
		end
	end
	if love.keyboard.isDown('right', 'd') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	end
	if love.keyboard.isDown(' ') and canShoot then
		newBullet = { x = player.x + (player.img:getWidth()/2) - 4, y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		bulletSound:play()
		canShoot = false
		canShootTimer = canShootTimerMax
	end

	-- Moving Stuff
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		if bullet.y < 0 then
			table.remove(bullets, i)
		end
	end

	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (200 * dt)

		if enemy.y > 850 then -- remove enemies when they pass off the screen
			table.remove(enemies, i)
		end
	end

	-- Collision Detection
	for i, enemy in ipairs(enemies) do
		for n, bullet in ipairs(bullets) do
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				table.remove(enemies, i)
				table.remove(bullets, n)
				player.score = player.score + 1
			end
		end

		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight())
		and player.isAlive then
			table.remove(enemies, i)
			boomSound:play()
			player.isAlive = false
		end
	end

	-- Restart
	if not player.isAlive and love.keyboard.isDown('r') then
		bullets = {}
		enemies = {}

		player.score = 0
		player.isAlive = true

		canShootTimer = canShootTimerMax
		enemyTimer = enemyTimerMax

		player.x = 240
		player.y = 550
	end
end

function love.draw(dt)
	love.graphics.print("SCORE: ", 5, 10)
	love.graphics.print(player.score, 60, 10)

	if player.isAlive then
		love.graphics.draw(player.img, player.x, player.y)
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	end

	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end

	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
end