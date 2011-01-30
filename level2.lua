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
	level:addPlatform(1100, 400, 400)
	level:addPlatform(1300, 500, 300)

	level:addPlatform(900, 100, 10, 300, 0, true, true)
	level:addPlatform(650, 200, 10, 200, 0, true, true)


	level.walls = Group:new()
	level.walls:add(Wall:new(200, 350, 100, 10, math.pi/2, true))
	level.walls:add(Wall:new(250, 400, 850))
	level.walls:add(Wall:new(500, 300, 100))
	level.walls:add(Wall:new(1500, 400, 100))

	level.enemies = Group:new()
	level.enemies:add(Enemy:new(400, 300))
	level.enemies:add(Enemy:new(1400, 400))

	local img = Assets.LoadImage('texture02.png')
	level.postit = Image:new(img, 397, 6, 480, 475)
		
	music = music or a.newSource('assets/sounds/level1.wav')
	music:setVolume(0.8)
	music:setLooping(true)
	music:play()
	

end