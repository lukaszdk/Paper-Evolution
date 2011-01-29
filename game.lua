require 'level.lua'
require 'player.lua'
require 'vector.lua'


local g = love.graphics
local k = love.keyboard

Game = GameState:addState('Game')


function Game:enterState()
	self.level = Level:new(1024, 768)
	self.player = Player:new(Vector:new(100, 250))
end

function Game:exitState()
end

function Game:keypressed(key)
end

function Game:keyreleased(key)
end

function Game:update(dt)
	self.level:update(dt)
	self.player:update(dt)
end

function Game:draw()
	g.setBackgroundColor(255,255,255,255)
	
	self.level:draw()
	self.player:draw()
end

