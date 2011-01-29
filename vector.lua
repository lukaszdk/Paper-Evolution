require 'middleclass.lua'

Vector = class('Vector')

function Vector:initialize(x, y)
	self.x = x
	self.y = y
end

function Vector:set(x, y)
	self.x, self.y = x, y
end	

function Vector:get()
	return self.x, self.y
end

function Vector.__add(a, b)
	return Vector:new(a.x+b.x, a.y+b.y)
end

function Vector.__sub(a, b)
	return Vector:new(a.x-b.x, a.y-b.y)
end

function Vector.__mul(a, b)
	return Vector:new(a.x*b, a.y*b)
end


function Vector.__div(a, b)
	return Vector:new(a.x/b, a.y/b)
end

function Vector:isZero()
	return math.abs(self.x) < 0.0001 and math.abs(self.y) < 0.0001
end

function Vector:distance(v)
	return math.sqrt( (self.x - v.x)^2 + (self.y - v.y)^2 )	
end

function Vector:length()
	return math.sqrt(self.x^2 + self.y^2)
end

function Vector:normalize()
	local len = self:length()
	return (self / len)
end

function Vector:clamp(minX, maxX, minY, maxY)
	self.x = math.max(minX, math.min(self.x, maxX))
	self.y = math.max(minY, math.min(self.y, maxY))
end


