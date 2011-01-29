require 'rect.lua'
require 'assets.lua'
require 'image.lua'

local g = love.graphics
local m = love.mouse

Eraser = class('Eraser')

function Eraser:initialize(position, size)
	self.rect = Rect:new(position, size, 200,200,200,255)
	self.pos = position
	
	local img = Assets.LoadImage('texture01.png')
	self.image = Image:new(img, 7, 431, 180, 136)
	
--	self.prevPos = position

--	self.prevDir = Vector:new(0,0)
--	self.dir = Vector:new(0,0)
	
	self.erasing = false
end

function Eraser:setPosition(position)
	self.rect.position = position
	self.pos = position

	--[[
	if self.pos:distance(position) > 0 then	
		self.prevPos = self.pos
		self.pos = position
	
		self.prevDir = self.dir
		self.dir = (self.pos - self.prevPos):normalize()
	end
	
	]]--
end

function Eraser:update(dt)
	
	local mouseDown = m.isDown('l') or m.isDown('r')

	if mouseDown and not self.erasing then
		self.p1 = self.pos
		self.erasing = true
	elseif not mouseDown and self.erasing then
		self.p2 = self.pos
		self.erasing = false
	end

--[[
	if mouseDown then
		if not self.erasing then
			self.points = {}
			self.points[1] = self.pos
			self.points.index = 1
			self.erasing = true
		else
			if (self.dir.y < 0 and self.prevDir.y > 0) or (self.dir.y > 0 and self.prevDir.y < 0) then
				self.points[self.points.index+1] = self.pos
				self.points.index = self.points.index+1
			end
		end
	else
		if self.erasing then
			self.points[self.points.index+1] = self.pos
			self.points.index = self.points.index+1
			self.erasing = false
		end
	end
	
	]]--
end

function Eraser:hasCutLine()
	return self.p1 and self.p2
end

function Eraser:getAndClearCutLine()
	local p1 = self.p1
	local p2 = self.p2
	
	assert(p1)
	assert(p2)
	
	self.p1 = nil
	self.p2 = nil
	
	self.cp1 = p1
	self.cp2 = p2

	return Line:new(p1, p2)
end

function Eraser:draw()
	g.setColor(0,0,0,255)

--	self.rect:draw()
--	g.rectangle("fill", self.rect.position.x - self.rect.size.x, self.rect.position.y - self.rect.size.y, self.rect.size.x, self.rect.size.y)
	
	self.image:draw(self.pos.x + 60, self.pos.y - 25)
--	g.setColor(255,0,0,255)
--	g.circle("fill", self.pos.x, self.pos.y, 4, 32)
	
	if self.cp1 and self.cp2 then
		g.setColor(255,0,0,255)
--		g.line(self.cp1.x, self.cp1.y, self.cp2.x, self.cp2.y)
	end
	
	if self.points then	
		local p = self.points[1]
		g.setColor(255,0,0,255)
	
		for i = 2, self.points.index-1 do 
			local q = self.points[i]
			g.line(p.x, p.y, q.x, q.y)
			p = q
		end
	end	
end