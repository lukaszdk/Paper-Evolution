require 'assets.lua'
require 'image.lua'

local g = love.graphics
local a = love.audio
local m = love.mouse

Menu = GameState:addState('Menu')

function Menu:enterState()
	local img = Assets.LoadImage( 'titleScreen.jpg')
	self.bg = Image:new(img, 0,0, 1024, 768)
	
	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
	
	m.setVisible(false)
	
	levelNumber = 2
end

function Menu:exitState()
	music:stop()
	music = nil
end

function Menu:keypressed(key)
	if key == 'escape' then
		love.event.push('q')
	else
		gameState:gotoState('Game')
	end
end

function Menu:update(dt)
	local mouseDown = m.isDown('l') or m.isDown('r')

	if mouseDown then
		gameState:gotoState('Game')
	end
end

function Menu:draw()
	self.bg:draw2(0,0)
end

