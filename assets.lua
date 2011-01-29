local g = love.graphics
local images = {}

Assets = {}

function Assets.LoadImage(name)
	if images[name] == nil then
		local image = g.newImage('assets/images/' .. name)
		
		local width = image:getWidth()
		local height = image:getHeight()
		
		local powerwidth = math.pow(2, math.ceil(math.log(width)/math.log(2)))
		local powerheight = math.pow(2, math.ceil(math.log(height)/math.log(2)))
		
		assert(width == powerwidth, "Image " .. name .. " width=" .. width .." not power of 2")
		assert(height == powerheight, "Image " .. name .. " height=" .. height .." not power of 2")
		
		images[name] = image
	end

	return images[name]
end

function Assets.ClearImage(name)
	images[name] = nil
end