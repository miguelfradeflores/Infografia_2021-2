local composer = require( "composer" )
 
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------



display.setDefault("background", unpack(fondo))
local backgroundGroup = display.newGroup()
backgroundGroup:toBack()
local enemyGroup = display.newGroup()

local background = display.newRect(0,0, cw*4, ch*2)
background.fill = { type="image", filename="sprites/nebula.png" }
background:toBack()
backgroundGroup:insert(background)


local enemyNumber = 0
local gunSpawnTime = 10
enemyMovementTime = 2000/math.random(5,6)
spawnTime = 1500/math.random(8,9)
numEnemies = math.random(25,40)
gunVelocity = 1200/math.random(1,3)


-- texto
local lifeText = 
{
    text = "" .. life ,
    x = wDiv*1,
	y = hDiv*0,
    font = native.systemFont,
    fontSize = hDiv-5
}
local lifeText = display.newText(lifeText )

lifeText.anchorX = 0
lifeText.anchorY = 0
lifeText:setFillColor( 1, 1,1 )
lifeText:toFront()
backgroundGroup:insert(lifeText)

local heart = display.newRect(wDiv * 0, hDiv*0, wDiv, hDiv)
heart.anchorX = 0
heart.anchorY = 0
heart.fill = { type="image", filename="sprites/heart.png" }
backgroundGroup:insert(heart)


local physics = require("physics")
physics.start()
physics.setGravity( 0, 0 )
--physics.setDrawMode( "hybrid" )
physics.setDrawMode( "normal" )


--btn


local widget = require( "widget" )


local function handleButtonMenuEvent( event )
 
	if ( "began" == event.phase ) then
		audio.play( clickSound, { channel=2, loops=0 } )
        audio.setVolume( 4, { channel=2 } )
	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
		audio.stop( 1 )
		gotoMenu()
		composer.removeScene( "game" )
    end
end
local function handleButtonRestartEvent( event )
 
	if ( "began" == event.phase ) then
		audio.play( clickSound, { channel=2, loops=0 } )
        audio.setVolume( 4, { channel=2 } )
	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
		composer.removeScene( "game" )
		audio.stop( 1 )
		gotoGame()
    end
end










--local gun = display.newCircle(wDiv*3+wDiv/2,hDiv*5 + hDiv/2,wDiv/8);



local function destroyTower()
    --print( "Transition 1 completed on object: " .. tostring( obj ) )
	life = life-1
    if life == 0 then
		audio.stop( 1 )

        gotoLoose()
    end
	lifeText.text ="" .. life
    --obj.alpha = 0
end


local gun1 = nil
local gun2 = nil
local gun3 = nil
local gun4 = nil


local function onGunCollision1( self, event )
 
    if ( event.phase == "began" ) then
        print( "gun1 collision "  )
		audio.play( hitSound, { channel=2, loops=0 } )
        audio.setVolume( 1, { channel=2 } )

        self:removeSelf()
        event.other:removeSelf()
		gun1= nil
            --elseif ( event.phase == "ended" ) then
    --   print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end

local function onGunCollision2( self, event )
 
    if ( event.phase == "began" ) then
        print( "gun2 collision "  )
		audio.play( hitSound, { channel=2, loops=0 } )
        audio.setVolume( 1, { channel=2 } )
        self:removeSelf()
        event.other:removeSelf()
		gun2= nil
            --elseif ( event.phase == "ended" ) then
    --   print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end

local function onGunCollision3( self, event )
 
    if ( event.phase == "began" ) then
        print( "gun3 collision "  )
		audio.play( hitSound, { channel=2, loops=0 } )
        audio.setVolume( 1, { channel=2 } )
        self:removeSelf()
        event.other:removeSelf()
		gun3= nil
            --elseif ( event.phase == "ended" ) then
    --   print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end

local function onGunCollision4( self, event )
 
    if ( event.phase == "began" ) then
        print( "gun4 collision "  )
		audio.play( hitSound, { channel=2, loops=0 } )
        audio.setVolume( 1, { channel=2 } )
        self:removeSelf()
        event.other:removeSelf()
		gun4= nil
            --elseif ( event.phase == "ended" ) then
    --   print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end
local firstGun1 = true
local firstGun2 = true
local firstGun3 = true
local firstGun4 = true



local function onRadiousCollision1( self, event )


    if ( event.phase == "began" ) then
        print( "radious collision "	)

		if firstGun1 == true then
			audio.play( bulletSound, { channel=3, loops=0 } )
       		audio.setVolume( 0.2, { channel=3 } )
			transition.to( gun1, { time=gunVelocity, delay=0, x = event.other.x, y = event.other.y } )
			firstGun1 = false
		end
    end
end

local function onRadiousCollision2( self, event )


    if ( event.phase == "began" ) then
        print( "radious collision2 "	)

		if firstGun2 == true then
			audio.play( bulletSound, { channel=3, loops=0 } )
       		audio.setVolume( 0.2, { channel=3 } )
			transition.to( gun2, { time=gunVelocity, delay=0, x = event.other.x, y = event.other.y } )
			firstGun2 = false
		end
    end
end

local function onRadiousCollision3( self, event )


    if ( event.phase == "began" ) then
        print( "radious collision3 "	)

		if firstGun3 == true then
			audio.play( bulletSound, { channel=3, loops=0 } )
       		audio.setVolume( 0.2, { channel=3 } )
			transition.to( gun3, { time=gunVelocity, delay=0, x = event.other.x, y = event.other.y } )
			firstGun3 = false
		end
    end
end

local function onRadiousCollision4( self, event )


    if ( event.phase == "began" ) then
        print( "radious collision4 "	)

		if firstGun4 == true then
			audio.play( bulletSound, { channel=3, loops=0 } )
       		audio.setVolume( 0.2, { channel=3 } )
			transition.to( gun4, { time=gunVelocity, delay=0, x = event.other.x, y = event.other.y } )
			
			firstGun4 = false
		end
    end
end

local function onTowerCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( "tower collision"  )
		audio.play( towerSound, { channel=2, loops=0 } )
        audio.setVolume( 8, { channel=2 } )
		destroyTower()
		if enemyGroup.numChildren > 1 then
			event.other:removeSelf()
		end


            --elseif ( event.phase == "ended" ) then
    --   print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	currScene = composer.getSceneName( "current" )

	



end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase



    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.removeScene( "menu" )

		local menuBtn = widget.newButton(
            {
                width = wDiv,
                height = hDiv,
                id = "MenuBtn",
                --label = "Default",
                --shape = "circle",
                defaultFile = "sprites/home.png",
                overFile = "sprites/homePressed.png",
                onEvent = handleButtonMenuEvent
            }
        )
		menuBtn.anchorX = 0
		menuBtn.anchorY = 0

		menuBtn.x = wDiv*10
		menuBtn.y = hDiv*0

		local restartBtn = widget.newButton(
            {
                width = wDiv,
                height = hDiv,
                id = "RestartBtn",
                --label = "Default",
                --shape = "circle",
                defaultFile = "sprites/restart.png",
                overFile = "sprites/restartPressed.png",
                onEvent = handleButtonRestartEvent
            }
        )
		restartBtn.anchorX = 0
		restartBtn.anchorY = 0

		restartBtn.x = wDiv*9
		restartBtn.y = hDiv*0

		backgroundGroup:insert(menuBtn)
		backgroundGroup:insert(restartBtn)

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        
--[[
for i = 0, numLinesW, 1 do
	local lineaVertical = display.newLine(wDiv * i, 0, wDiv * i, ch)
	lineaVertical.strokeWidth = 2
	lineaVertical:setStrokeColor(0)
    sceneGroup:insert(lineaVertical)
end

for i = 0, numLinesH, 1 do
	local lineaHorizontal = display.newLine(0, hDiv * i, cw, hDiv * i)
	lineaHorizontal.strokeWidth = 2
	lineaHorizontal:setStrokeColor(0)
    sceneGroup:insert(lineaHorizontal)

end
--]]

local verticesPath = {
	wDiv*0, hDiv*2,
	wDiv*2, hDiv*2,
	wDiv*2, hDiv*0,
	wDiv*6, hDiv*0,
	wDiv*6, hDiv*4,
	wDiv*8, hDiv*4,
	wDiv*8, hDiv*2,
	wDiv*11, hDiv*2,
	wDiv*11, hDiv*3,
	wDiv*9, hDiv*3,
	wDiv*9, hDiv*5,
	wDiv*5, hDiv*5,
	wDiv*5, hDiv*1,
	wDiv*3, hDiv*1,
	wDiv*3, hDiv*3,
	wDiv*0, hDiv*3,


}




local pathDraw = display.newPolygon(wDiv*0, hDiv*4, verticesPath)
pathDraw.anchorX = 0
pathDraw.anchorY = 0
--pathDraw:setFillColor(unpack(path))

pathDraw.fill.effect = "generator.checkerboard"
pathDraw.fill.effect.color1 = { unpack(path)}
pathDraw.fill.effect.color2 = { unpack(path2) }
pathDraw.fill.effect.xStep = 8
pathDraw.fill.effect.yStep = 8
--]]


backgroundGroup:insert(pathDraw)


local machine1 = display.newRect(wDiv * 3, hDiv*5, wDiv, hDiv)
machine1.anchorX = 0
machine1.anchorY = 0
--machine1:setFillColor(unpack(fondo))
machine1.fill = { type="image", filename="sprites/enemy1.png" }
--machine1:setFillColor(unpack(machine))
physics.addBody( machine1, "static", {radius=hDiv*2, isSensor=true} )
machine1.collision = onRadiousCollision1
machine1:addEventListener( "collision" )
backgroundGroup:insert(machine1)

local machine2 = display.newRect(wDiv * 4, hDiv*5, wDiv, hDiv)
machine2.anchorX = 0
machine2.anchorY = 0
machine2.fill = { type="image", filename="sprites/enemy1.png" }
--machine2:setFillColor(unpack(machine))
physics.addBody( machine2, "static", {radius=hDiv*2, isSensor=true} )
machine2.collision = onRadiousCollision2
machine2:addEventListener( "collision" )
backgroundGroup:insert(machine2)

local machine3 = display.newRect(wDiv * 6, hDiv*7, wDiv, hDiv)
machine3.anchorX = 0
machine3.anchorY = 0
machine3.fill = { type="image", filename="sprites/enemy1.png" }
--machine3:setFillColor(unpack(machine))
physics.addBody( machine3, "static", {radius=hDiv*2, isSensor=true} )
machine3.collision = onRadiousCollision3
machine3:addEventListener( "collision" )
backgroundGroup:insert(machine3)

local machine4 = display.newRect(wDiv * 7, hDiv*7, wDiv, hDiv)
machine4.anchorX = 0
machine4.anchorY = 0
machine4.fill = { type="image", filename="sprites/enemy1.png" }
--machine4:setFillColor(unpack(machine))
physics.addBody( machine4, "static", {radius=hDiv*2, isSensor=true} )
machine4.collision = onRadiousCollision4
machine4:addEventListener( "collision" )
backgroundGroup:insert(machine4)

local portal = display.newRect(wDiv * 0, hDiv*6, wDiv, hDiv)
portal.anchorX = 0
portal.anchorY = 0
portal.fill = { type="image", filename="sprites/portal.png" }
--portal:setFillColor(unpack(portalColor))
backgroundGroup:insert(portal)

local tower = display.newRect(wDiv * 10, hDiv*6, wDiv, hDiv)
tower.anchorX = 0
tower.anchorY = 0
tower.fill = { type="image", filename="sprites/tower.png" }
--tower:setFillColor(unpack(towerColor))
physics.addBody( tower,"static", { density=1.0, friction=0, bounce=0 } )
tower.collision = onTowerCollision
tower:addEventListener( "collision" )
backgroundGroup:insert(tower)

sceneGroup:insert(backgroundGroup)

local function throwGun(xEnemy, yEnemy)

	local gun = display.newCircle(wDiv*3+wDiv/2,hDiv*5 + hDiv/2,wDiv/8);
	gunNumber = math.random(1,4)
	gun.fill = { type="image", filename="sprites/bullet" .. gunNumber .. ".png" }

	physics.addBody( gun,"static", { density=1, friction=0, bounce=0 } )
	
		-- remove the "isBullet" setting below to see the brick pass through cans without colliding!
	gun.isBullet = true
	gun.collision = onGunCollision
	gun:addEventListener( "collision" )
	
		

	transition.to( gun, { time=enemyTime, delay=0, x = xEnemy, y = yEnemy + hDiv/2 } )

	--guns:applyForce( 1200, 0, gun.x, gun.y )
    --guns:insert(gun)

end

local function spawnEnemies()
	local enemyI = display.newCircle(wDiv/8,hDiv*6,hDiv/2)
	enemyI.anchorX = 0
	enemyI.anchorY = 0
	enemyNumber = math.random(2,4)
	enemyI.fill = { type="image", filename="sprites/enemy" .. enemyNumber .. ".png" }
	--enemyI:setFillColor(unpack(enemyColor))

    physics.addBody( enemyI,"dynamic", { density=1.0, friction=0.3, bounce=0, radius=hDiv/2 } )
    --enemyI.collision = onGunCollision
    --enemyI:addEventListener( "collision" )
	enemyGroup:insert(enemyI)
	local areEnemies = true


	return enemyI

end

local function areThereEnemies(  )
	if enemyGroup.numChildren < 1  and enemyGroup ~= nil then
		audio.stop( 1 )
		gotoWin()
	end
	
end

local function enemyMovement( )
	thisenemy = spawnEnemies()
	--print(enemyGroup.numChildren);
	transition.to( thisenemy, { time=enemyMovementTime*2, x=(wDiv)*2, y=(hDiv*6) } )
	transition.to( thisenemy, { time=enemyMovementTime*2, delay=enemyMovementTime*2, x=(wDiv)*2, y=(hDiv*4)} )
	transition.to( thisenemy, { time=enemyMovementTime*3, delay=enemyMovementTime*4, x=(wDiv)*5, y=(hDiv*4) } )
	transition.to( thisenemy, { time=enemyMovementTime*4, delay=enemyMovementTime*7, x=(wDiv)*5, y=(hDiv*8) } )
	transition.to( thisenemy, { time=enemyMovementTime*3, delay=enemyMovementTime*11, x=(wDiv)*8, y=(hDiv*8) } )
	transition.to( thisenemy, { time=enemyMovementTime*2, delay=enemyMovementTime*14, x=(wDiv)*8, y=(hDiv*6) } )
	transition.to( thisenemy, { time=enemyMovementTime*2, delay=enemyMovementTime*16, x=(wDiv)*10, y=(hDiv*6) } )
end




--for i = 1,numEnemies,1 



--[[
	local enemyII = display.newCircle(wDiv/8,hDiv*6,hDiv/2)
	enemyII.anchorX = 0
	enemyII.anchorY = 0
	enemyII:setFillColor(unpack(enemyColor))

	enemyGroup:insert(enemyII)
--]]

sceneGroup:insert(enemyGroup)

local enemyListener = function() return enemyMovement() end

-- enemyMovement( enemyGroup[enemyGroup.numChildren - 0] )
--enemyMovement( enemyGroup[enemyGroup.numChildren - 2] )

local function createGun1()
	if gun1 == nil then

		gun1 = display.newCircle(wDiv*3+wDiv/2,hDiv*5 + hDiv/2,wDiv/8);
		gunNumber1 = math.random(1,3)
		gun1.fill = { type="image", filename="sprites/bullet" .. gunNumber1 .. ".png" }
	
	physics.addBody( gun1,"static", { density=1, friction=0, bounce=0 } )
				-- remove the "isBullet" setting below to see the brick pass through cans without colliding!
	gun1.isBullet = true
	gun1.collision = onGunCollision1
	gun1:addEventListener( "collision" )
	sceneGroup:insert(gun1)

	firstGun1 = true

	end
	
end

local function createGun2()
	if gun2 == nil then

		gun2 = display.newCircle(wDiv*4+wDiv/2,hDiv*5 + hDiv/2,wDiv/8);
		gunNumber2 = math.random(1,3)
		gun2.fill = { type="image", filename="sprites/bullet" .. gunNumber2 .. ".png" }
	
	physics.addBody( gun2,"static", { density=1, friction=0, bounce=0 } )
				-- remove the "isBullet" setting below to see the brick pass through cans without colliding!
	gun2.isBullet = true
	gun2.collision = onGunCollision2
	gun2:addEventListener( "collision" )
	sceneGroup:insert(gun2)

	firstGun2 = true

	end
	
end

local function createGun3()
	if gun3 == nil then

		gun3 = display.newCircle(wDiv*6+wDiv/2,hDiv*7 + hDiv/2,wDiv/8);
		gunNumber3 = math.random(1,3)
		gun3.fill = { type="image", filename="sprites/bullet" .. gunNumber3 .. ".png" }
	
	physics.addBody( gun3,"static", { density=1, friction=0, bounce=0 } )
				-- remove the "isBullet" setting below to see the brick pass through cans without colliding!
	gun3.isBullet = true
	gun3.collision = onGunCollision3
	gun3:addEventListener( "collision" )
	sceneGroup:insert(gun3)

	firstGun3 = true

	end
	
end

local function createGun4()

	if gun4 == nil then

		gun4 = display.newCircle(wDiv*7+wDiv/2,hDiv*7 + hDiv/2,wDiv/8);
		gunNumber4 = math.random(1,3)
		gun4.fill = { type="image", filename="sprites/bullet" .. gunNumber4 .. ".png" }
	
	physics.addBody( gun4,"static", { density=1, friction=0, bounce=0 } )
				-- remove the "isBullet" setting below to see the brick pass through cans without colliding!
	gun4.isBullet = true
	gun4.collision = onGunCollision4
	gun4:addEventListener( "collision" )
	sceneGroup:insert(gun4)

	firstGun4 = true

	end
	
end

local function createGuns( )
	createGun1()
	createGun2()
	createGun3()
	createGun4()
end

timer.performWithDelay( spawnTime,enemyListener,numEnemies  ,"enemyTimer"  )
timer.performWithDelay( gunSpawnTime,createGuns,-1  ,"gunCreaterTimer"  )
timer.performWithDelay( spawnTime+3,areThereEnemies,-1  ,"areEnemiesTimer"  )







    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
	print( "((destroying game's view))" )
    timer.cancel("enemyTimer");
	timer.cancel("areEnemiesTimer");
	timer.cancel("gunCreaterTimer");

end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene