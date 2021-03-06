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
	
	while x < self.w do
		self.image:draw2(x, 0, 384, 768, 255,255,255, 200)
		x = x + 384
	end
	
	
end