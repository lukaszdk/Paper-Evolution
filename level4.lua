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

	level:addPlatform(0, 300, 600)
--	level:addPlatform(600, 500, 200)

	level:addPlatform(700, 400, 500)
	level:addPlatform(1400, 400, 500)
	level:addPlatform(1200, 500, 200)


	level:addPlatform(600, 0, 10, 250, 0, true, true)


	
	level.walls = Group:new()
	level.walls:add(Wall:new(5, 250, 100, 10, math.pi/2, true))
	
	
	level.blocks = Group:new()
	level.blocks:add(Block:new(1200, 100, 200, 100))

	music = music or a.newSource('assets/sounds/level.ogg')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end