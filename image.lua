
Image = class('Image')

local g = love.graphics

function Image:initialize(image, x, y, w, h, sx, sy, mirror)
	self.image = image
	self.w = w
	self.h = h
	self.sx = sx or 1
	self.sy = sy or 1
	self.mirror = mirror or false

	self.quad = g.newQuad(x, y, w, h, image:getWidth(), image:getHeight())
end

function Image:draw(x,y,w,h,angle)
	w = w or self.w
	h = h or self.h
	angle = angle or 0
	
	self.image:setFilter('nearest', 'nearest')
	g.setColor(255,255,255,255)
	g.drawq(self.image, self.quad, x, y, 0, w / self.w, h / self.h, self.w/2, self.h/2)
end

function Image:drawRotate(x,y,angle)
	self.image:setFilter('linear', 'linear')
	g.setColor(255,255,255,255)


	if self.mirror then
		g.drawq(self.image, self.quad, x, y, angle,  self.sx, self.sy, self.w, self.h/2)
		g.drawq(self.image, self.quad, x, y, angle, -self.sx, self.sy, self.w, self.h/2)
	else
		g.drawq(self.image, self.quad, x, y, angle, self.sx, self.sy, 1, self.w/2, self.h/2)
	end
end