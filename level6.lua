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
	level:addPlatform(700, 520, 200)
	level:addPlatform(900, 430, 100)
	level:addPlatform(1000, 540, 200)
	level:addPlatform(1200, 450, 500)


	level.blocks = Group:new()
	level.blocks:add(Block:new(400, 100, 200, 100))
	level.blocks:add(Block:new(700, 100, 200, 100))
	level.blocks:add(Block:new(1000, 100, 200, 100))

	local img = Assets.LoadImage('texture02.png')
	level.postit = Image:new(img, 397, 507, 480, 475)
	
	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end