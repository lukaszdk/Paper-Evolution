require 'assets.lua'
require 'image.lua'

local g = love.graphics

Block = class('Block')

function Block:initialize(x, y, w, h)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.mass = 0
	
	local img = Assets.LoadImage('texture01.png')
	
	self.hline = Image:new(img, 7, 54, 277, 11)
	self.vline = Image:new(img, 18, 111, 10, 277)
	self.vline2 = Image:new(img, 73, 111, 10, 277)
	
	self.ahline = newAnimation(img, 7, 54, 277, 10, 0.2, 2, 1)
	self.avline = newAnimation(img, 18, 111, 10, 277, 0.2, 2, 2)
	self.avline2 = newAnimation(img, 73, 111, 10, 277, 0.2, 2, 2)
	

	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
	self.shape:setData(self)
	self.dropped = false
end

function Block:update(dt)
	self.ahline:update(dt)
	self.avline:update(dt)
	self.avline2:update(dt)
end

function Block:drop()
	self.body:setMass(0, 1, 1, 1)
	self.dropped = true
end

function Block:cut(line)
	local x = self.body:getX()

	local rect = Rect:new( Vector:new(x - 10, 5), Vector:new(10, self.y))

	g.setColor(255,0,0,255)
	rect:draw()
	
	local line2 = Line:new(Vector(x, 5), Vector:new(x, self.y))
	local ip = line:intersect(line2)

	if ((line.p1.x < x and line.p2.x >= x) or 
	   (line.p2.x < x and line.p1.x >= x)) and
	   	rect:contains(ip) then
		
		self:drop()
	end
end

function Block:draw()

	g.setColor(255,255,255,255)

	if self.dropped == false then
	--	self.vline2:draw2( self.body:getX(), 5, 10, self.y)
		self.avline2:draw(self.body:getX(), 5, 0, 1, self.y/277)
	end

	local x, y = self.body:getX() - self.w/2, self.body:getY() - self.h/2

	-- self.animation:draw(x, y, a, self.w / 277,  self.h / 9, 277/2, 9/2)
	-- self.animation:draw(x, y, a, self.w / 9,  self.h / 277, 9/2, 277/2)
	
	self.ahline:draw(x, y, 0, self.w / 277)
	self.ahline:draw(x, y+self.h, 0, self.w / 277)

--	self.hline:draw2(x, y, self.w)
--	self.hline:draw2(x, y+self.h, self.w)

	self.avline:draw(x, y+2, 0, 1, self.h/277)
	self.avline:draw(x+self.w, y+2, 0, 1, self.h/277)

--	self.vline:draw2(x, y, 10, self.h)
--	self.vline:draw2(x+self.w, y, 10, self.h)

end