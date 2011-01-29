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
	
	local rectTop, rectRight, rectBottom, rectLeft = self.rect:getBorders()

	g.setColor(0,0,0,255)
	g.print("Top " .. rectTop.p1.x .. ", " .. rectTop.p1.y .. " ; " .. rectTop.p2.x .. ", " .. rectTop.p2.y, 10, 30)

--	rectTop:draw()
--	rectRight:draw()
--	rectBottom:draw()
--	rectLeft:draw()
	
end