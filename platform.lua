require 'assets.lua'
require 'image.lua'

local g = love.graphics

Platform = class('Platform')

function Platform:initialize(x, y, w, h, mass)
	self.x = x
	self.y = y
	self.w = w
	self.h = h or 10
	self.mass = mass or 0
	self.wall = false
	
	local img = Assets.LoadImage('line.png')
	self.image = Image:new(img, 0,0,512,4)
	
	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
end

function Platform:destroy()
	self.shape:destroy()
	self.body:destroy()
	self.shape = nil
	self.body = nil
end

function Platform:cut(line, width)
	local pline = Line:new(Vector:new(self.x, self.y + self.h/2), Vector:new(self.x + self.w, self.y + self.h/2))
	local rect = Rect:new(Vector:new(self.x, self.y), Vector:new(self.w, self.h))
	
	local ip = pline:intersect(line)
	
	if rect:contains(ip) then	
		local w1 = ip.x - self.x - width/2
		local w2 = self.w - (ip.x - self.x)
		
		if w1 > 0 then
			p1 = Platform:new(self.x, self.y, w1, self.h)
		else
			p1 = nil
		end
		
		if w2 > 0 then
			p2 = Platform:new(ip.x + width/2, self.y, w2, self.h)
		else
			p2 = nil
		end
		
		return true, p1, p2
	end
	
	return false, nil, nil
end

function Platform:draw()
	if self.shape then
		local x, y, a = self.body:getX(), self.body:getY(), self.body:getAngle()
		self.image:draw(x, y, self.w, self.h, a)
	end
end
