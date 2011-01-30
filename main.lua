require 'gamestate.lua'
require 'game.lua'
require 'menu.lua'
require 'endscreen.lua'

gameState = GameState:new()

function love.load()
	gameState:gotoState('Menu')
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