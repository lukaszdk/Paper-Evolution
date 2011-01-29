require 'assets.lua'
require 'image.lua'
require 'animation.lua'

local g = love.graphics

Platform = class('Platform')

function Platform:initialize(x, y, w, h, mass, vertical)
	self.x = x
	self.y = y
	self.w = w
	self.h = h or 10
	self.mass = mass or 0
	self.wall = vertical or false
	self.vertical = vertical or false
	
	local img = Assets.LoadImage('texture01.png')
	
	if not self.vertical then
		self.animation = newAnimation(img, 7, 1, 277, 10, 0.2, 2, 1)
	else
		self.animation = newAnimation(img, 73, 111, 10, 277, 0.2, 2, 2)
	end
	
	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
	self.shape:setData(self)
	
	if not self.vertical then
		self.line = Line:new(Vector:new(self.x, self.y + self.h/2), Vector:new(self.x + self.w, self.y + self.h/2))
	else
		self.line = Line:new(Vector:new(self.x + self.w/2, self.y), Vector:new(self.x + self.w/2, self.y + self.h))
	end

	self.rect = Rect:new(Vector:new(self.x, self.y), Vector:new(self.w, self.h))
end

function Platform:destroy()
	self.shape:destroy()
	self.body:destroy()
	self.shape = nil
	self.body = nil
end

function Platform:cut(line, width)
	if self.shape == nil then return end
	
	local ip = self.line:intersect(line)
	
	lineRect = Rect:new(Vector:new(line.p1.x, line.p1.y), Vector:new(line.p2.x - line.p1.x, line.p2.y - line.p1.y))
		
	if self.rect:intersect(lineRect) then
		self.ip = ip
		
		p1 = nil
		p2 = nil
		
		if not self.vertical then	
			local w1 = ip.x - self.x - width/2
			
			if w1 > 8 then
				p1 = Platform:new(self.x, self.y, w1, self.h, self.mass, self.wall, self.vertical)
			end
		else
			local w1 = ip.y - self.y - width/2
			
			if w1 > 8 then
				p1 = Platform:new(self.x, self.y, self.w, w1, self.mass, self.wall, self.vertical)
			end		
		end
		
		if not self.vertical then
			local w2 = self.w - (ip.x - self.x) - width/2
			
			if w2 > 8 then
				p2 = Platform:new(ip.x + width/2, self.y, w2, self.h, self.mass, self.wall, self.vertical)
			end
		else
			local w2 = self.h - (ip.y - self.y) - width/2
		
			if w2 > 8 then
				p2 = Platform:new(self.x, ip.y + width/2, self.w, w2, self.mass, self.wall, self.vertical)
			end
		end
		
		return true, p1, p2
	end
	
	return false, nil, nil
end

function Platform:update(dt)
	self.animation:update(dt)
end

function Platform:draw()
	if self.shape then
		local x, y, a = self.body:getX(), self.body:getY(), self.body:getAngle()
			
		g.setColor(255,255,255,255)
	
		if not self.vertical then
			self.animation:draw(x, y, a, self.w / 277,  self.h / 9, 277/2, 9/2)
		else
			self.animation:draw(x, y, a, self.w / 9,  self.h / 277, 9/2, 277/2)
		end

--		self.rect:draw()
--		self.line:draw()
--		if self.ip then g.circle("fill", self.ip.x , self.ip.y, 4, 32) end
		

--		if lineRect then lineRect:draw() end
	end
end
