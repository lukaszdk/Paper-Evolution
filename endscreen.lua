require 'assets.lua'
require 'image.lua'

local g = love.graphics
local a = love.audio
local m = love.mouse

EndScreen = GameState:addState('EndScreen')

function EndScreen:enterState()
	local img = Assets.LoadImage( 'endScreen.jpg')
	self.bg = Image:new(img, 0,0, 1024, 768)
	
	music2 = music2 or a.newSource('assets/sounds/intro.ogg')
	music2:setVolume(0.8)
	music2:setLooping(true)
	music2:play()	
end

function EndScreen:exitState()
	music2:stop()

end

function EndScreen:keypressed(key)
	gameState:gotoState('Menu')
end


function EndScreen:update(dt)
	local mouseDown = m.isDown('l') or m.isDown('r')

	if mouseDown then
		gameState:gotoState('Menu')
	end
end

function EndScreen:draw()
	self.bg:draw2(0,0)
end

