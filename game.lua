require 'level.lua'
require 'player.lua'
require 'vector.lua'
require 'eraser.lua'
require 'camera.lua'
require 'background.lua'

local g = love.graphics
local k = love.keyboard
local m = love.mouse

Game = GameState:addState('Game')


function Game:enterState()
	self.background = Background:new(1600)

	self.level = Level:new(1600, 768)
	player = Player:new(Vector:new(100, 100))
	self.eraser = Eraser:new(Vector:new(200,200), Vector:new(40,40))
	self.camera = Camera:new(0, 0, self.level.w, self.level.h)
	
	m.setVisible(false)
end

function Game:exitState()
end

function Game:keypressed(key)
end

function Game:keyreleased(key)
end

function Game:update(dt)
	mouseX, mouseY = m.getPosition()
	
	self.eraser:setPosition(Vector:new(mouseX-self.camera:getTranslation().x, mouseY))
	self.eraser:update(dt)
	
	if self.eraser:hasCutLine() then
		local cutLine = self.eraser:getAndClearCutLine()
		self.level:erase(cutLine, 80)
	end
	
	
--	if m.isDown('r') or m.isDown('l') then
--		self.level:erase(self.eraser.rect)
--	end
	
	self.level:update(dt)
	player:update(dt)
	
	if player.dead then
		self:enterState()
	end
	
	if self.level:atExit(player:getPosition()) then
		self:enterState()
	end
end

function Game:draw()
	g.setBackgroundColor(255,255,255,255)
		
	self.camera:set(player:getPosition())
	self.background:draw()
	self.level:draw()
	player:draw()
	self.eraser:draw()
	self.camera:clear()
	
end

