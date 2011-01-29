require 'middleclass.lua'
require 'Stateful.lua'

GameState = class('GameState'):include(Stateful)

function GameState:keypressed(key)
end

function GameState:keyreleased(key)
end

function GameState:update(dt)
end

function GameState:draw()
	love.graphics.print("GameState:Draw", 10, 10)
end
