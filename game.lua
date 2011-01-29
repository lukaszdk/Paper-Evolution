require 'level.lua'
require 'player.lua'
require 'vector.lua'
require 'eraser.lua'
require 'camera.lua'

local g = love.graphics
local k = love.keyboard
local m = love.mouse

Game = GameState:addState('Game')


function Game:enterState()
	self.level = Level:new(1600, 768)
	self.player = Player:new(Vector:new(100, 250))
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
	
	self.eraser:setPosition(Vector:new(mouseX, mouseY))
	
	self.level:erase(self.eraser.rect)
	
	self.level:update(dt)
	self.player:update(dt)
	
	if self.player.dead then
		self:enterState()
	end
	
	if self.level:atExit(self.player:getPosition()) then
		self:enterState()
	end
	
end

function Game:draw()
	g.setBackgroundColor(255,255,255,255)
	
	self.camera:set(self.player:getPosition())
	self.level:draw()
	self.player:draw()
	self.eraser:draw()
	self.camera:clear()
	
end

