require 'assets.lua'
require 'image.lua'
require 'animation.lua'

local g = love.graphics
local a = love.audio
local m = love.mouse

Menu = GameState:addState('Menu')

function Menu:enterState()
	local img = Assets.LoadImage( 'titleScreen.jpg')
	self.bg = Image:new(img, 0,0, 1024, 768)
	self.time = 0
	self.goTime = 1
	
	local img2 = Assets.LoadImage( 'texture03.png')
	
	self.animation = newAnimation(img2, 3, 243, 120, 193, 0.1, 8)
	self.text = newAnimation(img2, 124, 436, 838, 113, 0.1, 3, 1)
	
	music2 = music2 or a.newSource('assets/sounds/intro.ogg')
	music2:setVolume(0.8)
	music2:setLooping(true)
	music2:play()
	
	m.setVisible(false)
	
	levelNumber = 1
end

function Menu:exitState()
	music2:stop()
end

function Menu:keypressed(key)
	if self.time < self.goTime then return end
	
	if key == 'escape' then
		love.event.push('q')
	else
--		gameState:gotoState('Game')
	end
end

function Menu:update(dt)

	self.time = self.time + dt

	if self.time > 0.2 then
		self.animation:update(dt)
		self.text:update(dt)
	end

	if self.time < self.goTime then return end

	local mouseDown = m.isDown('l') or m.isDown('r')

	if mouseDown then
		gameState:gotoState('Game')
	end	
end

function Menu:draw()
	self.bg:draw2(0,0)
	self.animation:draw(552,200)
	self.text:draw(123,290)
end

