require 'vector.lua'

local p = love.physics
local g = love.graphics

Player = class('Player')

function Player:initialize(position)
	
	self.mass = 12
	self.radius = 15
	self.force = 24
	self.dead = false
	self.atExit = false

	if world then
		self.body = p.newBody(world, position.x, position.y, self.mass, 0) --place the body in the center of the world, with a mass of 15
	  	self.shape = p.newCircleShape(self.body, 0, 0, self.radius) --the ball has a radius of 20
		self.shape:setData(self)
	end
	
end

function Player:getPosition()
	return Vector:new(self.body:getX(), self.body:getY())
end

function Player:collisionBegin(o,c)
	if o.wall then
		self.force = -self.force
	end

end

function Player:collisionPersist(o,c)

	vx, vy = self.body:getLinearVelocity()

	if vx < 70 then
		self.body:applyForce(self.force, 0)
	end

--	self.body:applyImpulse(self.force, 0)

end


function Player:collisionEnd(o,c)
end

function Player:update(dt)
	if self.body:getY() - self.radius >= g.getHeight() then
		self:die()
	end
end

function Player:die()
	self.dead = true
end

function Player:draw()
	g.setColor(0,0,0,255)
--	if vx then g.print("vx " .. vx, 10, 10) end

	g.setColor(0,0,255,255)
	g.circle("fill", self.body:getX(), self.body:getY(), self.radius)
end