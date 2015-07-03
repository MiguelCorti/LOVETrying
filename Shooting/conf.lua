-- Configuration
function love.conf(t)
	t.title = "Scrolling Shooter" -- The title of the window the game is in (string)
	t.version = "0.9.2"         -- The LÖVE version this game was made for (string)
	t.window.height = 700
	t.window.width = 480

	-- For Windows debugging
	t.console = true
end