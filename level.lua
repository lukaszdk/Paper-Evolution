require 'line.lua'
require 'platform.lua'
require 'enemy.lua'
require 'group.lua'

local g = love.graphics
local p = love.physics

Level = class('Level')

function Level:initialize(w, h)
	self.w = w
	self.h = h
	
	world = p.newWorld(0, 0, w, h)

	world:setGravity(0, 100)
	world:setMeter(64)

	world:setCallbacks(collisionBegin, collisionPersist, collisionEnd, nil)

	self:addPlatform(20, 300, 600)
	self:addPlatform(250, 400, 1150)
	self:addPlatform(800, 500, 600)


	self.enemies = Group:new()
	self.enemies:add(Enemy:new(400, 300))

	self.exit = Rect:new(Vector:new(1200, 540), Vector:new(60, 60), 0,255,0,128)
end

function Level:addPlatform(x, y, w)
	self.platforms = self.platforms or {}
	self.platforms.size = self.platforms.size or 0
	self.platforms.size = self.platforms.size + 1
	
	self.platforms[ self.platforms.size ] = Platform:new(x,y,w)	
end

function collisionBegin(a, b, contact)
	
	if a and a.collisionBegin then
		a:collisionBegin(b,contact)
	end

	if b and b.collisionBegin then
		b:collisionBegin(a,contact)
	end
	
end

function collisionPersist(a, b, contact)
	if a and a.collisionPersist then
		a:collisionPersist(b,contact)
	end

	if b and b.collisionPersist then
		b:collisionPersist(a,contact)
	end
end

function collisionEnd(a, b, contact)
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

function Level:erase(line, width)
	width = width or 40
	self.remove = self.remove or {}	
	self.add = self.add or {}
	local i = 1
	local j = 1

	for k, platform in ipairs(self.platforms) do
		if platform.shape then		
			local cut, p1, p2 = platform:cut(line, width)

			if cut then
				platform.shape:setMask(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
				self.remove[j] = platform
				self.add[i] = p1
				self.add[i+1] = p2
				i = i + 2
				j = j + 1
			end
		end
	end
end

function Level:update(dt)
	world:update(dt)
	
	if self.remove then
		for k, platform in ipairs(self.remove) do
			platform:destroy()
		end
		
		self.remove = nil
	end

	if self.add then
		for k, platform in ipairs(self.add) do
			self.platforms.size = self.platforms.size + 1
			self.platforms[ self.platforms.size ] = platform
		end
		
		self.add = nil
	end
	
	for k, platform in ipairs(self.platforms) do
		platform:update(dt)
	end

	self.enemies:call('checkPlayer')
	self.enemies:update(dt)
end

function Level:draw()
	g.setColor(0,0,0,255)
		
	for k, platform in ipairs(self.platforms) do
		platform:draw()
	end
	
	self.enemies:draw()
	self.exit:draw()	
end