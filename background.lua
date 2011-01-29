require 'assets.lua'
require 'image.lua'

local g = love.graphics

Background = class('Background')

function Background:initialize(w)
	local img = Assets.LoadImage('texture02.png')
	self.image = Image:new(img, 3, 3, 384, 768)
	self.w = w
end

function Background:draw()
	local x = 0
	
	g.setColor(255,255,255,255)
	
	while x < self.w do
		self.image:draw(x, 768/2)
		x = x + 384
	end
end