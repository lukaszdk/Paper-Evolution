require 'assets.lua'
require 'image.lua'

local g = love.graphics
local a = love.audio

Menu = GameState:addState('Menu')

function Menu:enterState()
	local img = Assets.LoadImage( 'titleScreen.jpg')
	self.bg = Image:new(img, 0,0, 1024, 768)
	
	music = music or a.newSource('assets/sounds/level1.wav')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end

function Menu:exitState()
	music:stop()
	music = nil
end

function Menu:keypressed(key)
	gameState:gotoState('Game')
end


function Menu:update(dt)

end

function Menu:draw()
	self.bg:draw2(0,0)
end

