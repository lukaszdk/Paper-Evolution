require 'image.lua'

local p = love.physics
local a = love.audio


function LoadLevel(level)
	level.w = 1600
	level.h = 768
	level.player = Vector:new(20, 170)
	
	world = p.newWorld(0, 0, level.w, level.h)

	world:setGravity(0, 100)
	world:setMeter(64)

	world:setCallbacks(collisionBegin, collisionPersist, collisionEnd, nil)

	level:addPlatform(0, 400, 1300)

	level:addPlatform(200, 550, 200)
	level:addPlatform(500, 550, 1100)
--	level:addPlatform(1300, 600, 300)

	level.walls = Group:new()
	level.walls:add(Wall:new(1000, 500, 100, 10, math.pi/2, true))
--	level.walls:add(Wall:new(250, 400, 850))
	level.walls:add(Wall:new(1300, 400, 100))
	level.walls:add(Wall:new(400, 550, 100))

	level.enemies = Group:new()
	level.enemies:add(Enemy:new(1200+150, 400))
	level.enemies:add(Enemy:new(300+150, 550))

	local img = Assets.LoadImage('texture01.png')

	local loveImage = Image:new(img, 7, 621, 122, 91)
	loveImage:set(200, 100)

	local signImage = Image:new(img, 7, 717, 122, 91)
	signImage:set(1000, 100)
	
	local grocImage = Image:new(img, 7, 813, 122, 91)
	grocImage:set(1400, 600)

	level.images = Group:new()
	level.images:add(loveImage)
	level.images:add(signImage)
	level.images:add(grocImage)
	
	local img = Assets.LoadImage('texture02.png')
	level.postit = Image:new(img, 397, 6, 480, 475)

--	level.arrowX = 30
	
	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
	

end