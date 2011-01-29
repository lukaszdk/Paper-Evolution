require 'vector.lua'

local p = love.physics
local g = love.graphics

Player = class('Player')

function Player:initialize(position)
	
	self.mass = 12
	self.radius = 15
	self.force = 30

	if world then
		self.body = p.newBody(world, position.x, position.y, self.mass, 0) --place the body in the center of the world, with a mass of 15
	  	self.shape = p.newCircleShape(self.body, 0, 0, self.radius) --the ball has a radius of 20
		self.shape:setData(self)
	end
	
end

function Player:collisionBegin(o,c)

	local n = Vector:new(c:getNormal())

	if math.abs(n.x) > 0.98 and self.walking then
		self.force = -self.force
	end

end

function Player:collisionPersist(o,c)
	self.body:applyForce(self.force, 0)
	self.walking = true
end


function Player:collisionEnd(o,c)
	self.walking = false
end

function Player:update(dt)
end

function Player:draw()
	g.setColor(0,0,255,255)
	g.circle("fill", self.body:getX(), self.body:getY(), self.radius)
end