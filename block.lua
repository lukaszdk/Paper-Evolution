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


	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
	self.shape:setData(self)
	self.dropped = false
end

function Block:drop()
	self.body:setMass(100, 100, 1, 1)
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
		self.vline2:draw2( self.body:getX(), 5, 10, self.y)
	end

	local x, y = self.body:getX() - self.w/2, self.body:getY() - self.h/2

	self.hline:draw2(x, y, self.w)
	self.hline:draw2(x, y+self.h, self.w)

	self.vline:draw2(x, y, 10, self.h)
	self.vline:draw2(x+self.w, y, 10, self.h)
end