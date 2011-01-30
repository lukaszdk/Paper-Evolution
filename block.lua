require 'assets.lua'
require 'image.lua'

local g = love.graphics

Block = class('Block')

function Block:initialize(x, y, w, h)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.mass = 4
	
	local img = Assets.LoadImage('texture01.png')
	
	self.hline = Image:new(img, 7, 1, 277, 10)
	self.vline = Image:new(img, 73, 111, 10, 277)

	self.body = love.physics.newBody(world, self.x + self.w / 2, self.y + self.h/2, self.mass, 0)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, self.w, self.h, 0)
	self.shape:setData(self)
end

function Block:draw()

	g.setColor(255,255,255,255)

	local x, y = self.body:getX() - self.w/2, self.body:getY() - self.h/2

	self.hline:draw2(x, y, self.w)
	self.hline:draw2(x, y+self.h, self.w)

	self.vline:draw2(x, y, 10, self.h)
	self.vline:draw2(x+self.w, y, 10, self.h)
end