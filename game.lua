require 'level.lua'
require 'player.lua'
require 'vector.lua'
require 'eraser.lua'
require 'camera.lua'
require 'background.lua'
require 'assets.lua'
require 'block.lua'

local g = love.graphics
local k = love.keyboard
local m = love.mouse
local f = love.filesystem

Game = GameState:addState('Game')

levelNumber = 1

function Game:enterState()
	cursor = Assets.LoadImage('cursor.png')

	self.background = Background:new(1600)
	self.level = Level:new()

	f.load('level' .. levelNumber .. '.lua')()	
	LoadLevel(self.level)

	player = Player:new(self.level.player)
	self.eraser = Eraser:new(Vector:new(200,200), Vector:new(40,40))
	self.camera = Camera:new(0, 0, self.level.w, self.level.h)
	
	m.setVisible(false)
	
	mouseX, mouseY = m.getPosition()
	self.eraser:setPosition(Vector:new(mouseX-self.camera:getTranslation().x, mouseY))
	
	self.intro = self.level.postit ~= nil
end

function Game:exitState()
end

function Game:keypressed(key)

	if key == 'escape' then
		gameState:gotoState('Menu')
	end
end

function Game:keyreleased(key)
end

function Game:update(dt)

	if self.intro then
		mouseX, mouseY = m.getPosition()
		local mDown = m.isDown('l') or m.isDown('r')
	
		if mDown and self.level:postitClose(Vector:new(mouseX, mouseY)) then
			self.intro = false
			return
		end
	end
	
	if self.intro then return end

	mouseX, mouseY = m.getPosition()
	
	self.eraser:setPosition(Vector:new(mouseX-self.camera:getTranslation().x, mouseY))
	self.eraser:update(dt)
	
	if self.eraser:hasCutLine() then
		local cutLine = self.eraser:getAndClearCutLine()
		self.level:erase(cutLine, 80)
	end
		
	self.level:update(dt)
	player:update(dt)
	
	if player.dead then
		self:enterState()
	end
	
	if self.level:atExit(player:getPosition()) then
		levelNumber = levelNumber + 1
		self:enterState()
	end
	
	local mDown = m.isDown('l') or m.isDown('r')
	
	if self.level:retryTest(Vector:new(mouseX-self.camera:getTranslation().x, mouseY), -self.camera:getTranslation().x) and mDown then
		self:enterState()
	end

end

function Game:draw()
	g.setBackgroundColor(255,255,255,255)
		
	self.camera:set(player:getPosition())
	self.background:draw()

	self.level:draw()
	player:draw()
	
	if not self.intro then
		self.level:drawRetry(-self.camera:getTranslation().x)
		self.eraser:draw()
	end

	self.camera:clear()

	if self.intro then
		g.setColor(0,0,0, 200)
		g.rectangle("fill", 0, 0, g.getWidth(), g.getHeight())
		
		g.setColor(255,255,255,255)
		self.level:drawPostit()
	
		g.draw(cursor, mouseX, mouseY)	
	end
	
end

