require 'vector.lua'

local p = love.physics
local g = love.graphics

Player = class('Player')

function Player:initialize(position)
	
	self.mass = 12
	self.radius = 15
	self.force = 50
	self.dead = false
	self.atExit = false
	self.w = 150
	self.h = 150
	self.time = 0

	if world then
		self.body = p.newBody(world, position.x + self.w/2, position.y+ self.w/2, self.mass, 0) --place the body in the center of the world, with a mass of 15
	  	self.shape = p.newRectangleShape(self.body, 0, 0, 30, 80)
		
		--self.shape = p.newCircleShape(self.body, 0, 0, self.radius) --the ball has a radius of 20
		self.shape:setData(self)
		self.shape:setFriction(0.1)
	end
	
	local img = Assets.LoadImage('texture01.png')
	self.walk = newAnimation(img, 500, 540, self.w, self.h, 0.2, 8, 3)
end

function Player:kill()
	self.dead = true
end

function Player:getPosition()
	return Vector:new(self.body:getX(), self.body:getY())
end

function Player:collisionBegin(o,c)
	if o and o.wall and self.lastCollision ~= o then
		self.lastCollision = o
		self.force = -self.force
	end
end

function Player:collisionPersist(o,c)
	vx, vy = self.body:getLinearVelocity()

	if math.abs(vx) < 130 then
		self.body:applyForce(self.force, 0)
	end
end


function Player:collisionEnd(o,c)
end

function Player:update(dt)
	if self.body:getY() - self.radius >= g.getHeight() then
		self:die()
	end
	
	self.walk:update(dt)
	
	self.time = self.time + dt
end

function Player:die()
	self.dead = true
end

function Player:draw()
	local pos = self:getPosition()

	g.setColor(255,255,255,255)

	if self.force > 0 then
		self.walk:draw(pos.x - self.w/2, pos.y - self.h/2, 0, 1, 1)
	else
		self.walk:draw(pos.x + self.w/2, pos.y - self.h/2, 0, -1, 1)
	end
	
	g.setColor(0,0,255,255)
--	g.polygon("fill", self.shape:getPoints())
	
--	g.circle("fill", pos.x, pos.y, 4, 32)
	
end