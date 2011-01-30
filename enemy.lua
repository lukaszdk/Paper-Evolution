require 'image.lua'
require 'animation.lua'

local g = love.graphics
local a = love.audio

Enemy = class('Enemy')

function Enemy:initialize(x, y)
	self.x = x
	self.y = y
	self.w = 200
	self.h = 180
	local img = Assets.LoadImage('texture01.png')
	self.idle = newAnimation(img, 300, 0, self.w, self.h, 0.2, 3)
	self.attack = newAnimation(img, 300, 180, self.w, self.h, 0.07, 7, 3)
	self.dir = "left"
	self.state = "idle"
	self.time = 0

	self.eatSound = a.newSource('assets/sounds/eat.wav')
	self.eatSound:setVolume(0.3)
	self.eatSound:setLooping(true)
end

function Enemy:checkPlayer()
	if player.dead then return end

	local pos = player:getPosition()

	if Vector:new(self.x, self.y):distance(player:getPosition()) < 70 and pos.y >= self.y - self.h + 20 and pos.y <= self.y then
		player:kill()
	end
end

function Enemy:update(dt)
	self.time = self.time + dt

	local pos = player:getPosition()

	if pos.x > self.x then
		self.dir = "right"
	else
		self.dir = "left"
	end

	if self.stopSound and self.stopSound < self.time then
		self.eatSound:stop()
	end

	if self.dir ==  "left" then
	
		if pos.x < self.x and math.abs(pos.x-self.x) < 400 and pos.y >= self.y - self.h + 20 and pos.y <= self.y then
			self.state = "attack"
			
			if self.eatSound:isStopped() then
				self.eatSound:play()
				self.stopSound = self.time + 0.6
			end
		else
			self.state = "idle"
		end
	elseif self.dir == "right" then
	
		if pos.x > self.x and math.abs(pos.x-self.x) < 400 and pos.y >= self.y - self.h + 20 and pos.y <= self.y then
			self.state = "attack"
			
			if self.eatSound:isStopped() then
				self.eatSound:play()
				self.stopSound = self.time + 0.6
			end
		else
			self.state = "idle"
			--eatSound:stop()
		end
	end

	if self.state == "idle" then
		self.idle:update(dt)
	elseif self.state == "attack" then
		self.attack:update(dt)
	end
end

function Enemy:draw()
	g.setColor(255,255,255,255)
	
	if self.dir == "left" then	
		if self.state == "idle" then
			self.idle:draw(self.x - 150, self.y - self.h + 20)
		elseif self.state == "attack" then
			self.attack:draw(self.x - 150, self.y - self.h + 20)
		end
	elseif self.dir == "right" then
		if self.state == "idle" then
			self.idle:draw(self.x + 150, self.y - self.h + 20, 0, -1, 1)
		elseif self.state == "attack" then
			self.attack:draw(self.x + 150, self.y - self.h + 20, 0, -1, 1)
		end	
	end
	
	g.setColor(255,0,0,255)
--	g.circle("fill", self.x, self.y, 4, 32)
--	g.line(self.x, self.y, self.x + self.w, self.y)
	
--	g.line(self.x - 10, self.y, self.x + 10, self.y)
--	g.line(self.x - 10, self.y - self.h + 20, self.x + 10, self.y - self.h + 20)

	
end