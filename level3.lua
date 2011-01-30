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

	level:addPlatform(0, 400, 600)
	level:addPlatform(600, 500, 200)

	level:addPlatform(800, 400, 1000)

	level.blocks = Group:new()
	level.blocks:add(Block:new(600, 100, 200, 100))

	music = music or a.newSource('assets/sounds/level1.wav')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
end