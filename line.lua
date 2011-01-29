local g = love.graphics

Line = class('Line')

function Line:initialize(p1, p2)
	self.p1 = p1
	self.p2 = p2
end

function Line:intersect(line)
	local x1, y1, x2, y2 = self.p1.x, self.p1.y, self.p2.x, self.p2.y
	local x3, y3, x4, y4 = line.p1.x, line.p1.y, line.p2.x, line.p2.y
	
	local d = ((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4))
	
	local x = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4 - y3*x4)) / d
	local y = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4 - y3*x4)) / d

	return Vector:new(x,y)
end

function Line:draw()
	g.setColor(255,0,0,255)
	g.line(self.p1.x, self.p1.y, self.p2.x, self.p2.y)
end