require 'vector.lua'

local g = love.graphics

Camera = class('Camera')

function Camera:initialize(x, y, w, h)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.translation = Vector:new(0,0)
end

function Camera:set(position)
	position = position or Vector:new(0,0)
	
	local x = math.max(-self.w+g.getWidth(), math.min((g.getWidth())/2 - position.x, 0))
	local y = math.max(-self.h+g.getHeight(), math.min((g.getHeight())/2 - position.y, 0))
	
	g.push()
	g.scale(self.s)
	g.translate(x, y)
	
	self.translation = Vector:new(x,y)
end

function Camera:getTranslation()
	return self.translation
end

function Camera:clear()
	g.pop()
end