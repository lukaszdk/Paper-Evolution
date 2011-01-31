
local g = love.graphics

Wall = class('wall')

function Wall:initialize(x, y, w, h, a, wall)
	self.x = x
	self.y = y
	self.w = w
	self.h = h or 10
	self.a = a or 0
	self.mass = 0
	self.wall = wall or false

	local img = Assets.LoadImage('texture01.png')
	self.animation = newAnimation(img, 7, 54, 277, 11, 0.2, 2, 1)

	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.body:setAngle(self.a)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
	self.shape:setData(self)
end

function Wall:update(dt)
	self.animation:update(dt)
end
function Wall:draw()
	local x, y, a = self.body:getX(), self.body:getY(), self.body:getAngle()
	g.setColor(0,0,255,200)
	self.animation:draw(x, y, a, self.w / 277,  self.h / 11, 277/2, 11/2)
end

