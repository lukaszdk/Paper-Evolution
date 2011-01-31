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

	level:addPlatform(0, 300, 1175)

	level:addPlatform(700, 450, 500)
	level:addPlatform(600, 600, 1000)

	level.walls = Group:new()
	level.walls:add(Wall:new(1100, 375, 150, 10, math.pi/2, true))
	level.walls:add(Wall:new(600, 555, 100, 10, math.pi/2, true))

	level.walls:add(Wall:new(1175, 300, 425))
	
	
	level.enemies = Group:new()
	level.enemies:add(Enemy:new(1400+150, 300))
	level.enemies:add(Enemy:new(600+150, 450))
	
	local img1 = Assets.LoadImage('texture01.png')

	local loveImage = Image:new(img1, 7, 621, 122, 91)
	loveImage:set(200, 100)

	local signImage = Image:new(img1, 7, 717, 122, 91)
	signImage:set(1000, 100)
	
	local grocImage = Image:new(img1, 7, 813, 122, 91)
	grocImage:set(1400, 600)

	level.images = Group:new()
	level.images:add(loveImage)
	level.images:add(signImage)
	level.images:add(grocImage)
	
	local img = Assets.LoadImage('texture02.png')
	level.postit = Image:new(img, 397, 507, 480, 475)
	
	
	
--	level.blocks = Group:new()
--	level.blocks:add(Block:new(1200, 100, 200, 100))

	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end