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

	level:addPlatform(0, 300, 500)
--	level:addPlatform(1100, 400, 400)
--	level:addPlatform(1400, 500, 300)
	level:addPlatform(250, 400, 200)
	level:addPlatform(200, 500, 1100)
	level:addPlatform(1100, 600, 500)

	level:addPlatform(900, 400+3, 10, 100, 0, true, true)
	level:addPlatform(1100, 400+3, 10, 100, 0, true, true)

	level.walls = Group:new()
	level.walls:add(Wall:new(200, 350, 100, 10, math.pi/2, true))

	level.walls:add(Wall:new(650, 350, 100, 10, math.pi/2, true))


	level.walls:add(Wall:new(450, 400, 650))
	level.walls:add(Wall:new(500, 300, 100))
	level.walls:add(Wall:new(1300, 500, 400))

	level.enemies = Group:new()
	level.enemies:add(Enemy:new(400+150, 300))
	level.enemies:add(Enemy:new(1300+50, 500))

	local img = Assets.LoadImage('texture04.png')
	level.postit = Image:new(img, 3, 3, 480, 498)

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


		
	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
	

end