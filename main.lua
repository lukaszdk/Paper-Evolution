require 'gamestate.lua'
require 'game.lua'

local gameState = GameState:new()

function love.load()
	gameState:gotoState('Game')
end

function love.keypressed(key)
	gameState:keypressed(key)
end

function love.keyreleased(key)
	gameState:keyreleased(key)
end

function love.update(dt)
	gameState:update(dt)
end

function love.draw()
	gameState:draw()
end