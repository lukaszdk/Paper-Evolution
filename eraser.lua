require 'rect.lua'

local g = love.graphics

Eraser = class('Eraser')

function Eraser:initialize(position, size)
	self.rect = Rect:new(position, size, 200,200,200,255)
end

function Eraser:setPosition(position)
	self.rect.position = position
end

function Eraser:draw()
	self.rect:draw()
end