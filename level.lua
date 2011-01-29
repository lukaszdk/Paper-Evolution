
local g = love.graphics
local p = love.physics

Level = class('Level')

function Level:initialize(w, h)

	self.w = w
	self.h = h

	world = p.newWorld(0, 0, w, h)

	world:setGravity(0, 100)
	world:setMeter(64)
	
	world:setCallbacks(CollisionBegin, CollisionPersist, CollisionEnd, nil)
	
	self:addLine(Vector:new(20, 300), Vector:new(420, 303))
	self:addLine(Vector:new(450, 600), Vector:new(900, 603))
	
	self:addLine(Vector:new(800, 560), Vector:new(800, 600))
	
end

function CollisionBegin(a, b, contact)
	
	if a and a.collisionBegin then
		a:collisionBegin(b,contact)
	end

	if b and b.collisionBegin then
		b:collisionBegin(a,contact)
	end
	
end

function CollisionPersist(a, b, contact)
	if a and a.collisionPersist then
		a:collisionPersist(b,contact)
	end

	if b and b.collisionPersist then
		b:collisionPersist(a,contact)
	end
end

function CollisionEnd(a, b, contact)
	if a and a.collisionEnd then
		a:collisionEnd(b,contact)
	end

	if b and b.collisionEnd then
		b:collisionEnd(a,contact)
	end
end


function Level:addLine(p1, p2)
	self.lines = self.lines or {}
	self.lines.size = self.lines.size or 0
	
	local line = {}

	local angle = math.atan2(p2.y-p1.y, p2.x-p1.x)	
	local l = p1:distance(p2)
	m = Vector:new(p1.x + l * math.cos(angle) * 0.5, p1.y + l * math.sin(angle) * 0.5)
	
	local angle1 = angle - math.pi/2
	local angle2 = angle + math.pi/2
		
	line.p1 = Vector:new( p1.x + 4 * math.cos(angle1), p1.y + 4 * math.sin(angle1))
	line.p2 = Vector:new( p2.x + 4 * math.cos(angle1), p2.y + 4 * math.sin(angle1))
	line.p3 = Vector:new( p2.x + 4 * math.cos(angle2), p2.y + 4 * math.sin(angle2))
	line.p4 = Vector:new( p1.x + 4 * math.cos(angle2), p1.y + 4 * math.sin(angle2))
	
	line.body = p.newBody(world, m.x, m.y, 0, 0)

	local q1 = m - line.p1
	local q2 = line.p2 - m
	local q3 = m - line.p3
	local q4 = line.p4 - m
	
	line.shape = p.newPolygonShape(line.body, q1.x, q1.y, q2.x, q2.y, q3.x, q3.y, q4.x, q4.y) 
	
	self.lines[self.lines.size + 1] = line	
	self.lines.size = self.lines.size + 1
end

function Level:update(dt)
	world:update(dt)
end

function Level:draw()
	

	for k, line in ipairs(self.lines) do
--		g.setColor(255,0,0,255)
--		g.polygon("fill", line.p1.x, line.p1.y, line.p2.x, line.p2.y, line.p3.x, line.p3.y, line.p4.x, line.p4.y)

	
		g.setColor(0,0,0,255)
		g.polygon("fill", line.shape:getPoints())

		g.setColor(255,0,0,255)
		g.circle("fill", line.body:getX(), line.body:getY(), 4)
	end
end