require 'image.lua'
require 'animation.lua'

local g = love.graphics

Enemy = class('Enemy')

function Enemy:initialize(x, y)
	self.x = x
	self.y = y
	self.w = 200
	self.h = 180
	local img = Assets.LoadImage('texture01.png')
	self.idle = newAnimation(img, 300, 0, self.w, self.h, 0.2, 3)
	self.attack = newAnimation(img, 300, 180, self.w, self.h, 0.07, 7, 3)
	
	self.state = "idle"
end

function Enemy:checkPlayer()
	if player.dead then return end

	if Vector:new(self.x + self.w/2, self.y):distance(player:getPosition()) < 70 then
		player:kill()
	end
end

function Enemy:update(dt)

	local pos = player:getPosition()

	if pos.x < self.x and self.x - pos.x < 175 then
		self.state = "attack"
	else
		self.state = "idle"
	end
	
	if self.state == "idle" then
		self.idle:update(dt)
	elseif self.state == "attack" then
		self.attack:update(dt)
	end
end

function Enemy:draw()
	g.setColor(255,255,255,255)
	
	if self.state == "idle" then
		self.idle:draw(self.x, self.y - self.h + 20)
	elseif self.state == "attack" then
		self.attack:draw(self.x, self.y - self.h + 20)
	end
end