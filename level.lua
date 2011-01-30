require 'assets.lua'
require 'line.lua'
require 'platform.lua'
require 'enemy.lua'
require 'group.lua'
require 'wall.lua'
require 'image.lua'

local g = love.graphics
local p = love.physics
local a = love.audio

Level = class('Level')

function Level:initialize()
--[[	self.w = w
	self.h = h
	self.player = Vector:new(20, 170)
	
	world = p.newWorld(0, 0, w, h)

	world:setGravity(0, 100)
	world:setMeter(64)

	world:setCallbacks(collisionBegin, collisionPersist, collisionEnd, nil)

	self:addPlatform(0, 300, 500)
	self:addPlatform(1100, 400, 400)
	self:addPlatform(1300, 500, 300)

	self:addPlatform(900, 100, 10, 300, 0, true, true)
	self:addPlatform(650, 200, 10, 200, 0, true, true)


	self.walls = Group:new()
	self.walls:add(Wall:new(200, 350, 100, 10, math.pi/2, true))
	self.walls:add(Wall:new(250, 400, 850))
	self.walls:add(Wall:new(500, 300, 100))
	self.walls:add(Wall:new(1500, 400, 100))


	self.enemies = Group:new()
	self.enemies:add(Enemy:new(400, 300))
	self.enemies:add(Enemy:new(1400, 400))

	local img = Assets.LoadImage('texture02.png')
	self.postit = Image:new(img, 397, 6, 480, 475)
		
	music = a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
	]]--
	
	local img = Assets.LoadImage('texture01.png')
	self.exitImage = Image:new(img, 7, 526, 122, 91)

	local img3 = Assets.LoadImage('texture03.png')
	
	self.retryImage = Image:new(img3, 3, 653, 66, 66)
	self.timeLine1 = Image:new(img3, 3, 817, 800, 69)
	self.timeLine2 = Image:new(img3, 3, 817+74, 800, 69)
	
	self.arrow = Image:new(img3, 3, 720, 66, 66)

--	self.exit = Rect:new(Vector:new(1200, 540), Vector:new(60, 60), 0,255,0,128)
end

function Level:addPlatform(x, y, w, h, mass, wall, vertical)
	self.platforms = self.platforms or {}
	self.platforms.size = self.platforms.size or 0
	self.platforms.size = self.platforms.size + 1
	
	self.platforms[ self.platforms.size ] = Platform:new(x,y,w, h, mass, wall, vertical)	
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
	return pos.x-100 > self.w	
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

	if self.blocks then
		self.blocks:call('cut', line)
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

	if self.enemies then
		self.enemies:call('checkPlayer')
		self.enemies:update(dt)
	end
	
	if self.walls then
		self.walls:update(dt)
	end
end

function Level:postitClose(pos)
	local r = Rect:new(Vector:new(g.getWidth()/2 + self.postit.w/2 - 60, g.getHeight()/2 - self.postit.h/2 + 20), Vector:new(50, 50))
	
	return r:contains(pos)
end

function Level:drawPostit()
	self.postit:draw2(g.getWidth()/2 - self.postit.w/2, g.getHeight()/2 - self.postit.h/2)
end

function Level:drawRetry(x)
	self.retryImage:draw2(30+x, 45)
end

function Level:retryTest(pos, x)
	local r = Rect:new(Vector:new(30 + x, 45), Vector:new(self.retryImage.w, self.retryImage.h))
	return r:contains(pos)	
end

function Level:draw()
	g.setColor(0,0,0,255)
		
	self.exitImage:draw2(self.w - 150, 50)
		
	if self.images then
		self.images:call('draw2')
	end
		
	for k, platform in ipairs(self.platforms) do
		platform:draw()
	end
	
	if self.walls then
		self.walls:draw()
	end
	
	if self.enemies then
		self.enemies:draw()
	end
	
	if self.blocks then
		self.blocks:draw()
	end
	
	if self.arrowX then
		self.arrow:draw2(self.arrowX, g.getHeight() - 150, self.arrow.w, self.arrow.h, 255, 255, 255, 100)
	end
	
	self.timeLine1:draw2(0, g.getHeight() - self.timeLine1.h - 3, 800, self.timeLine1.h, 255, 255, 255, 100)
	self.timeLine2:draw2(800, g.getHeight() - self.timeLine2.h - 3, 800, self.timeLine2.h, 255, 255, 255, 100)
	
--	self.exit:draw()	
end