local g = love.graphics

Rect = class('Rect')

function Rect:initialize(position, size, r,g,b,a)
	
--	assert(size.x ~= 0)
--	assert(size.y ~= 0)

	self.position = position
	self.size = size
	
	if self.size.x < 0 then
		self.position.x = self.position.x - self.size.x
		self.size.x = -self.size.x
	end
	
	if self.size.y < 0 then
		self.position.y = self.position.y + self.size.y
		self.size.y = -self.size.y
	end
	
	self.r = r or 0
	self.g = g or 0
	self.b = b or 0
	self.a = a or 255
end

function Rect:draw()
	g.setColor(self.r, self.g, self.b, self.a)
	g.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Rect:getCorners()
	assert(self.size.x > 0)
	assert(self.size.y > 0)
	p1 = self.position
	p2 = self.position + Vector:new(self.size.x, 0)
	p3 = self.position + self.size
	p4 = self.position + Vector:new(0, self.size.y)
	
	return p1, p2, p3, p4
end

function Rect:getBorders()
	local p1, p2, p3, p4 = self:getCorners()
	
	return	Line:new(p1, p2), 
			Line:new(p2, p3),
			Line:new(p4, p3),
			Line:new(p1, p4)
end

function Rect:intersect(rect)

	local ax1, ay1, ax2, ay2 = self.position.x, self.position.y, self.position.x + self.size.x, self.position.y + self.size.y
	local bx1, by1, bx2, by2 = rect.position.x, rect.position.y, rect.position.x + rect.size.x, rect.position.y + rect.size.y
	
	return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
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
