local g = love.graphics

Rect = class('Rect')

function Rect:initialize(position, size,r,g,b,a)
	self.position = position
	self.size = size
	self.r = r
	self.g = g
	self.b = b
	self.a = a
end

function Rect:draw()
	r = self.r or 0
	g1 = self.g or 0
	b = self.b or 0
	a = self.a or 255
	
	g.setColor(r,g1,b,a)
	g.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Rect:contains(point)
	local p = self.position
	local s = self.size

	if point.x >= p.x and point.x <= p.x + s.x and point.y >= p.y and point.y <= p.y + s.y then
		return true
	else
		return false
	end
end