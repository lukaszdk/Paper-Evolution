require 'line.lua'

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
	
	self:addLine(Vector:new(20, 300), Vector:new(520, 303))
	self:addLine(Vector:new(250, 600), Vector:new(1400, 603))
	
--	self:addLine(Vector:new(800, 560), Vector:new(800, 600), true)
	
	self.exit = Rect:new(Vector:new(1200, 540), Vector:new(60, 60), 0,255,0,128)
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


function Level:atExit(pos)	
	return self.exit:contains(pos)
end

function Level:erase(rect)

	self.activeLine = nil
	cut1 = nil
	cut2 = nil

	local rectTop, rectRight, rectBottom, rectLeft = rect:getBorders()
	
	self.removeLines = {}
	self.addLines = {}
	local i = 1
	
	local intersect = false
	
	for k, line in ipairs(self.lines) do
		
		
		if line.shape then
		
			local ip1 = rectLeft:intersect(line.l1)
			local ip2 = rectRight:intersect(line.l3)
		
			if rect:contains(ip1) and rect:contains(ip2)  then
				-- self.activeLine = line
				intersect = true
				
				
				if not self.cutting then
					cut1 = Line:new(Vector:new(ip1.x, ip1.y - 20), Vector:new(ip1.x, ip1.y + 20))
					cut2 = Line:new(Vector:new(ip2.x, ip2.y - 20), Vector:new(ip2.x, ip2.y + 20))
			
					self.addLines[i] = Line:new(line.op1, ip1)
					self.addLines[i+1] = Line:new(ip2, line.op2)
					self.removeLines[i] = line
					line.shape:setMask(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)

					i = i + 2				
				end
				
			end	
		end

--		local ip3 = rectTop:intersect(line.l2)
--		local ip4 = rectBottom:intersect(line.l4)
		
--		if rect:contains(ip3) and rect:contains(ip4)  then
--			self.activeLine = line
--		end	


	end
	
	if intersect then
		self.cutting = true
	else
		self.cutting = false
	end

end

function Level:addLine(p1, p2, wall)
	self.lines = self.lines or {}
	self.lines.size = self.lines.size or 0
	
	local line = {}

	local angle = math.atan2(p2.y-p1.y, p2.x-p1.x)	
	local l = p1:distance(p2)
	m = Vector:new(p1.x + l * math.cos(angle) * 0.5, p1.y + l * math.sin(angle) * 0.5)
	
	local angle1 = angle - math.pi/2
	local angle2 = angle + math.pi/2
	
	line.op1 = p1
	line.op2 = p2
		
	line.p1 = Vector:new( p1.x + 4 * math.cos(angle1), p1.y + 4 * math.sin(angle1))
	line.p2 = Vector:new( p2.x + 4 * math.cos(angle1), p2.y + 4 * math.sin(angle1))
	line.p3 = Vector:new( p2.x + 4 * math.cos(angle2), p2.y + 4 * math.sin(angle2))
	line.p4 = Vector:new( p1.x + 4 * math.cos(angle2), p1.y + 4 * math.sin(angle2))
	line.wall = wall or false
	
	line.l1 = Line:new(line.p1, line.p2)
	line.l2 = Line:new(line.p2, line.p3)
	line.l3 = Line:new(line.p4, line.p3)
	line.l4 = Line:new(line.p1, line.p4)
	
	line.body = p.newBody(world, m.x, m.y, 0, 0)

	local q1 = m - line.p1
	local q2 = line.p2 - m
	local q3 = m - line.p3
	local q4 = line.p4 - m
	
	line.shape = p.newPolygonShape(line.body, q1.x, q1.y, q2.x, q2.y, q3.x, q3.y, q4.x, q4.y) 
	
	line.shape:setData(line)
	
	self.lines[self.lines.size + 1] = line	
	self.lines.size = self.lines.size + 1
end

function Level:update(dt)
	world:update(dt)

	for k, line in ipairs(self.addLines) do	
		self:addLine(line.p1, line.p2)
	end
	
	for k, line in ipairs(self.removeLines) do	
		line.shape:destroy()
		line.body:destroy()
		line.shape = nil
		line.body = nil
	end
	
end

function Level:draw()
	g.setColor(0,0,0,255)
--	g.print("ip1, ip2 = " .. ip1.x .. ", " .. ip1.x .. " ; " .. ip2.x .. ", " .. ip2.y, 10, 10)

	for k, line in ipairs(self.lines) do
--		g.setColor(255,0,0,255)
--		g.polygon("fill", line.p1.x, line.p1.y, line.p2.x, line.p2.y, line.p3.x, line.p3.y, line.p4.x, line.p4.y)

		if line.shape then 
			g.setColor(0,0,0,255)
			g.polygon("fill", line.shape:getPoints())
		end

		
		g.setColor(0,0,255, 255)
		--line.l1:draw()
		--line.l2:draw()
		--line.l3:draw()
		--line.l4:draw()
		if cut1 then cut1:draw() end
		if cut2 then cut2:draw() end
		
		
		

--		g.setColor(255,0,0,255)
--		g.circle("fill", line.body:getX(), line.body:getY(), 4)
	end
	
	self.exit:draw()
	
end