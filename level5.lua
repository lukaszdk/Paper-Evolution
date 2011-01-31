local p = love.physics
local a = love.audio


function LoadLevel(level)
	level.w = 1600
	level.h = 768
	level.player = Vector:new(20, 270)
	
	world = p.newWorld(0, 0, level.w, level.h)

	world:setGravity(0, 100)
	world:setMeter(64)

	world:setCallbacks(collisionBegin, collisionPersist, collisionEnd, nil)

	level:addPlatform(0, 400, 400)
	level:addPlatform(400, 510, 200)
	level:addPlatform(600, 420, 100)
	level:addPlatform(700, 530, 200)
	level:addPlatform(900, 450, 100)
	level:addPlatform(1000, 560, 200)
	level:addPlatform(1200, 470, 500)

	local img1 = Assets.LoadImage('texture01.png')

	local loveImage = Image:new(img1, 7, 621, 122, 91)
	loveImage:set(200, 100)

	local signImage = Image:new(img1, 7, 717, 122, 91)
	signImage:set(1000, 100)
	
	local grocImage = Image:new(img1, 7, 813, 122, 91)
	grocImage:set(1400, 600)

	level.images = Group:new()
	level.images:add(loveImage)
--	level.images:add(signImage)
	level.images:add(grocImage)

	level.blocks = Group:new()
	level.blocks:add(Block:new(400, 100, 200, 100))
	level.blocks:add(Block:new(700, 100, 200, 100))
	level.blocks:add(Block:new(1000, 100, 200, 100))

	local img = Assets.LoadImage('texture02.png')
	level.postit = Image:new(img, 397, 507, 480, 475)
	
	local img = Assets.LoadImage('texture04.png')
	level.postit = Image:new(img, 3, 503, 480, 498)
	
	
	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end