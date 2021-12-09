local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight


local backGroup = display.newGroup()
local midGroup = display.newGroup( )
local frontGroup = display.newGroup()
local floorGroup = display.newGroup()
local rectangleShape
local soundtrack = audio.loadSound( "soundtrack/09 LIVING IN A LAZY PARALLEL WORLD (LOOP).mp3" )
local sprintEffect = audio.loadSound( "soundtrack/V3_SE_508.wav" )


local personaje, bg
local floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8, floor9, floor10, floor11, floor12
local wallL,wall2,wall3
local physics = require "physics"

physics.start()
print(physics.getGravity())
physics.setGravity(0, 9.8)
print( cw,ch )
--physics.setDrawMode( "hybrid" )


local estados = {
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.107, anchorY=0.115, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.197, anchorY=0.115, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.287, anchorY=0.115, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.377, anchorY=0.230, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.467, anchorY=0.230, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.557, anchorY=0.230, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.647, anchorY=0.230, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.737, anchorY=0.230, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=6.3, yScale=1.455, anchorX=0.827, anchorY=0.230, time = 2000, onComplete = setContralador}
}

local options = {
	width = 165,
	height = 224,
	numFrames = 9
}

local cuadro 
local piso 
local doubleJump 
local controlador 

function setContralador( e )
    controlador = true
    print( "Accion completada" )
end

-- local options2 = {
-- 	width = 300,
-- 	height = 300,
-- 	numFrames = 8
-- }

local personaje_spritesheet = graphics.newImageSheet( "sprites/dr".. character .. ".png",  options )

local sequence = {
	{
		name="de_pie",
		frames = {1,2,1,2,1,2,1,2,1,2,1,2},
		loopCount = 20,
		time = 4000, 
		sheet = personaje_spritesheet
	},
	{
		name="caminar",
		frames = {7,8},
		loopCount = 0,
		time = 350, 
		sheet = personaje_spritesheet
	},
	{
		name="saltar",
		frames = {4},
		loopCount = 0,
		time = 1000, 
		sheet = personaje_spritesheet
	},
	{
		name="caer",
		frames = {9},
		loopCount = 0,
		time = 1000, 
		sheet = personaje_spritesheet
	}
}

local arr_r = display.newImageRect( frontGroup, "sprites/arrow_r.png", 25,40)
arr_r.x = 70; arr_r.y = ch*9/10

local controlador2 = display.newImageRect(frontGroup, "sprites/arrow_l.png", 25,40)
controlador2.x = 20; controlador2.y = ch*9/10

local buttonA = display.newImageRect( frontGroup,"buttons/button_A.png", 30,30)
buttonA.x = cw-40; buttonA.y = ch*17/20


local function nextScreen1 (event)
  composer.gotoScene( "gameOver" , {
    effect = "fade",
    time = 500,
    params = {
            t = character,
            l = life
    }
    })
end
local function nextScreen (event)
    composer.gotoScene( "gameOver" )
end

function moverDerecha(e)
	if e.phase == "began" then
		personaje.xScale = 0.3
		personaje:setSequence( "caminar" )
		personaje:play( )
		timer.performWithDelay(100, function()
				personaje.x = personaje.x + 5
			end, -1, "movimiento")
	elseif e.phase == "moved" then 
 	
	elseif e.phase == "ended" then
		personaje.xScale = 0.3
		personaje:pause()
		personaje:setSequence( "de_pie" )
		personaje:play()
		timer.cancel("movimiento")
	end
	return true
end

function moverIzquierda(e)
	if e.phase == "began" then
		personaje.xScale = -0.3
		personaje:setSequence( "caminar" )
		personaje:play( )
		timer.performWithDelay(100, function()
				personaje.x = personaje.x - 5
			end, -1, "movimiento")
		
	elseif e.phase == "moved" then 

 	
	elseif e.phase == "ended" then
		personaje.xScale = -0.3
		personaje:pause()
		personaje:setSequence( "de_pie" )
		personaje:play()
		--personaje:setFrame( 1 )
		timer.cancel("movimiento")
 	end
	return true
end

function saltar(e)
	if e.phase == "began" then
		personaje:setSequence( "saltar" )
		transition.to(personaje, {y=personaje.y-40, time = 300})
		transition.to(personaje, {y=personaje.y, delay = 300,time = 400})
		
		
	elseif e.phase == "moved" then 
	--	personaje.x = personaje.x + 5

	elseif e.phase == "ended" then

		timer.performWithDelay(1100, personaje:pause()
				, -1, "movimiento")
		personaje:setSequence( "de_pie" )
		personaje:play()
		--personaje:setFrame( 1 )
		timer.cancel("movimiento")
 	end
	return true
end

function globalCollision( event)
	if (event.object2.name == "floor1" and event.object1.name == "personaje" )   or 
	   (event.object1.name == "floor1" and event.object2.name == "personaje" )   or
	   (event.object2.name == "floor2" and event.object1.name == "personaje" )   or 
		(event.object1.name == "floor2" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor3" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor3" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor4" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor4" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor5" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor5" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor6" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor6" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor7" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor7" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor8" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor8" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor9" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor9" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor10" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor10" and event.object2.name == "personaje" )  or
		(event.object2.name == "floor11" and event.object1.name == "personaje" )  or 
		(event.object1.name == "floor11" and event.object2.name == "personaje" ) then
		doubleJump = 0
	end
end

function death1( event)
	if 	(event.object2.name == "floor12" and event.object1.name == "personaje" )   or 
	  	(event.object1.name == "floor12" and event.object2.name == "personaje" ) then
		audio.stop(1) 
		Runtime:removeEventListener("enterFrame",verify)
		timer.performWithDelay( 1000, nextScreen )
	end
end

function teclas(e)
	if e.phase == "down" then
		print("tecla oprimida", e.keyName)
		if e.keyName == "right" then
			personaje.xScale = 0.3
			personaje:setSequence( "caminar" )
			personaje:play( )
			timer.performWithDelay(100, function()
				personaje.x = personaje.x + 8
			end, -1, "movimiento")
	
		elseif e.keyName == "left" then
			personaje.xScale = -0.3
			personaje:setSequence( "caminar" )
			personaje:play( )
			timer.performWithDelay(100, function()
				personaje.x = personaje.x - 8

				--[[
				if personaje.x <= 0 then 
					bg:translate(cw,0)
					bg2:translate(cw,0)
					personaje.x = cw- 20

				end]]--


			end, -1, "movimiento")

		elseif e.keyName == "space" then
			--personaje:scale( -1, -1 )
			--personaje:rotate( 180 )
			if doubleJump < 1 then 
				audio.play(sprintEffect, {channel=3} )
				personaje:setSequence( "saltar" )
				personaje:play( )
		--elseif e.keyName == "x" then
				transition.to(personaje, {y=personaje.y-40, time = 300})
		    	transition.to(personaje, {y=personaje.y, delay = 300,time = 400})
			--personaje:setSequence( "atacar")
			--personaje:play()
				doubleJump = doubleJump + 1
			else
				audio.pause(3)
			end
			print(doubleJump)
		end

	elseif e.phase == "up" then
		print("tecla levantada", e.keyName)
		
		personaje:pause()
		personaje:setSequence( "de_pie" )
		personaje:play()
		--personaje:setFrame( 1 )
		timer.cancel("movimiento")

	end

end

function verify(e)
	--print(personaje:getLinearVelocity())
	local vx, vy = personaje:getLinearVelocity()
	if vy > 15 and personaje.y > ch/32*20 then
		personaje.rotation = -90
		personaje:setSequence( "caer" )
		personaje:play()
	end
end


function sceneMovement( e )
	--print(personaje:getLinearVelocity())
        	if controlador == true and personaje.x >= cw/4*3 then
                --[[
                if cuadro == 6 then
                    controlador = true
                    cuadro = 0
                    background.touch = changePage
                    background:addEventListener( "touch", background )
                end
                ]]--
                Runtime:removeEventListener("enterFrame",sceneMovement)
                cuadro = cuadro +1
                controlador = false
             --   transition.cancel()
                transition.to( bg,estados[cuadro])
                controlador = true
                print( cuadro)
            end
	return true
end


local function setRuntimes (event)
Runtime:addEventListener( "enterFrame", sceneMovement )
Runtime:addEventListener( "enterFrame", floorMovement )
end

local function setFall (event)
Runtime:addEventListener( "enterFrame", verify )
end


local function setVerify (event)
    Runtime:addEventListener( "enterFrame", verify )
	Runtime:addEventListener( "enterFrame", sceneMovement )
	Runtime:addEventListener( "enterFrame", floorMovement )
	Runtime:addEventListener( "key", teclas ) 
	Runtime:addEventListener( "collision", death1)
	Runtime:addEventListener( "collision", globalCollision)

end
function floorMovement( e )
	--print(personaje:getLinearVelocity())
        	if controlador == true and personaje.x >= cw/4*3 then
        		Runtime:removeEventListener("enterFrame",floorMovement)
        		if piso == 0  then
        		    transition.to(personaje, { x= cw/2 - ch/40*22, y=ch/2-60 , time=2000})
        			transition.to(wallL, { x= -cw , time=2000})
        			transition.to(floor2, { x= cw/2 - ch/40*23 , y=ch/2 ,time=1800})
					transition.to(floor1, { x=cw/2 + 10 , y=ch/32*21 +5 ,time=1800})
					transition.to(floor3, { y=ch/32*17 -2 ,time=1800})
					transition.to(floor4, { y=ch/32*18 -2,time=1800})
					transition.to(floor5, { x=cw/2 - ch/40*26 + cw/13*3,y=ch/32*19 -2,time=1800})
					transition.to(floor6, { x=cw/2 - ch/40*21.8 + cw/13*3,y=ch/32*20 -2,time=1800})
					transition.to(floor7, { x=cw/2 - ch/40*21.1 + cw/13*4,y=ch/32*21 -2,time=1800})
					controlador = true
					piso = 1
					
        		elseif piso == 1 then
        			transition.to(personaje, { x= cw/2 - ch/40*22, y=ch/32*17,  time=2000})
					transition.to(floor2, { y=ch/32*21 +5 ,time=1800})
					transition.to(floor3, { y=ch/32*21 +5 ,time=1800})
					transition.to(floor4, { y=ch/16*17,time=1800})
					transition.to(floor5, { y=ch/16*17,time=1800})
					transition.to(floor6, { y=ch/16*17,time=1800})
					transition.to(floor7, { y=ch/16*17,time=1800})
					controlador = true
					piso = 2
				elseif piso == 2 then
					Runtime:removeEventListener("enterFrame",verify)
					transition.to(personaje, { x= cw/2 - ch/40*22, y=ch/32*17,  time=2000})
					transition.to(floor1, { y=ch*7/8 ,time=1800})
					transition.to(floor4, { y=ch/32*21 +5,time=1800})
					transition.to(floor5, { x=cw/2 - ch/40*25 + cw/13*3, y=ch/32*21 +5,time=1800})
					transition.to(wall2, { x=cw/16*13,y=ch/32*25 +5,time=1800})
					transition.to(wall3, { x=cw/8*3,y=ch/32*25 +5,time=1800})
					transition.to(floor6, { x=cw/16*14, y=ch/32*21 +5,time=1800})	
					transition.to(floor7, { x=cw/16*15, y=ch/32*21 +5,time=1800})	
					transition.to(floor8, { x=cw/16*13, y=ch/32*21 +5,time=1800})
					piso = 3
				elseif piso == 3 then

					transition.to(personaje, { x= floor4.x+5, y=ch/2 -10,  time=2000})
					transition.to(floor1, { y=ch ,time=1800})
					transition.to(floor4, { x=floor4.x+5, y=ch/2+5,time=1800})
					transition.to(floor5, { x=cw/16, y=ch/32*21 +5,time=1800})
					transition.to(wall2, { x=cw/16*4,y=ch/8*5,time=1800})
					transition.to(wall3, { x=cw/8*3,y=ch/32*25 +5,time=1800})
					transition.to(floor6, { x=cw/32*11, y=ch/2+5,time=1800})	
					transition.to(floor7, { x=cw/32*14, y=ch/2+5,time=1800})	
					transition.to(floor8, { x=cw/32*21, y=ch/2+5,time=1800})
					transition.to(floor9, { x=cw/32*24, y=ch/2+5,time=1800})
					transition.to(floor10, { x=cw/32*31, y=ch/2+5,time=1800})
					piso = 4
					timer.performWithDelay( 3000, setFall )
				elseif piso == 4 then
					Runtime:removeEventListener("enterFrame",verify)
					transition.to(personaje, { x= cw/16*3-10, y=ch/2 -30,  time=2000})
					transition.to(floor1, { x=cw*3/4,y=ch/16*15 ,time=1800})
					transition.to(floor2, { y=ch/2+5 ,time=1800})
					transition.to(floor3, { x= floor3.x+10,y=ch/2+5 ,time=1800})
					transition.to(floor4, { x=floor4.x+5, y=ch/16*17,time=1800})
					transition.to(floor5, { x=cw/16, y=ch,time=1800})
					transition.to(wall2, { x=cw/32*17,y=ch/8*5,time=1800})
					transition.to(wall3, { x=cw/32*17,y=ch/32*25 +5,time=1800})
					transition.to(floor6, { x=cw/32*12, y=ch/2+5,time=1800})	
					transition.to(floor7, { x=cw/32*15, y=ch/2+5,time=1800})	
					transition.to(floor8, { x=cw/32*21, y=ch/16*17,time=1800})
					transition.to(floor9, { x=cw/32*24, y=ch/16*17,time=1800})
					transition.to(floor10, { x=cw/32*31, y=ch/16*17,time=1800})
					piso = 5
				elseif piso == 5 then
					transition.to(personaje, { x= cw/16*3-10, y=ch/32*21,  time=2000})
					transition.to(floor1, { x=cw*1/4,y=ch/16*15 ,time=1800})
					transition.to(floor2, { y=ch/16*17 ,time=1800})
					transition.to(floor3, { y=ch/16*17 ,time=1800})
					transition.to(floor4, { y=ch/16*17,time=1800})
					transition.to(floor5, { y=ch/16*17,time=1800})
					transition.to(floor6, { y=ch/16*17,time=1800})	
					transition.to(floor7, { y=ch/16*17,time=1800})	
					transition.to(floor8, { y=ch/32*22,time=1800})
					transition.to(floor9, { y=ch/32*22,time=1800})
					transition.to(floor10, { x=cw/32*27,y=ch/32*22,time=1800})
					transition.to(wall2, { x=-cw/16,y=ch/8*5,time=1800})
					transition.to(wall3, { x=cw/32*21,y=ch/32*25 +5,time=1800})
					piso = 6
				elseif piso == 6 then
					transition.to(personaje, { x= cw/16*3-10, y=ch/32*20,  time=2000})
					transition.to(floor1, { x=cw/4*5,y=ch/32*22 ,time=1800})
					transition.to(floor2, { x=cw/32*3,y=ch/32*22 ,time=1800})
					transition.to(floor3, { x=cw/32*6,y=ch/32*22 ,time=1800})
					transition.to(floor4, { x=cw/32*9+5,y=ch/32*22,time=1800})
					transition.to(floor5, { y=ch/16*17,time=1800})
					transition.to(floor6, { y=ch/16*17,time=1800})	
					transition.to(floor7, { y=ch/32*19,time=1800})	
					transition.to(floor8, { y=ch/32*19,time=1800})
					transition.to(floor9, { y=ch/32*19,time=1800})
					transition.to(floor10, { x=cw/32*28.5,y=ch/32*22,time=1800})
					transition.to(wall2, { x=-cw/16,y=ch/8*5,time=1800})
					transition.to(wall3, { x=-cw/16,y=ch/32*25 +5,time=1800})
					piso = 7
					timer.performWithDelay( 3000, setFall )
				elseif piso == 7 then
					transition.to(personaje, { x= cw/8*3, y=ch/32*16,  time=2000})
					transition.to(floor1, { x=cw/4*3,y=ch/32*22 ,time=1800})
					transition.to(floor2, { x=cw/32*3,y=ch/32*19 ,time=1800})
					transition.to(floor3, { x=cw/32*6,y=ch ,time=1800})
					transition.to(floor4, { x=cw/32*9+5,y=ch/32*22,time=1800})
					transition.to(floor5, { y=ch,time=1800})
					transition.to(floor6, { y=ch/32*22,time=1800})	
					transition.to(floor7, { y=ch/16*17,time=1800})	
					transition.to(floor8, { y=ch/16*17,time=1800})
					transition.to(floor9, { y=ch/16*17,time=1800})
					transition.to(floor10, { x=cw/32*28.5,y=ch/16*17,time=1800})
					transition.to(wall2, { x=-cw/16,y=ch/8*5,time=1800})
					transition.to(wall3, { x=-cw/16,y=ch/32*25 +5,time=1800})
					piso = 8
				elseif piso == 8 then
					transition.to(personaje, { x= cw/8*3, y=ch/32*20,  time=2000})
					transition.to(floor1, { x=cw/4*3,y=ch/32*22 ,time=1800})
					transition.to(floor2, { x=cw/32*3,y=ch/32*22 ,time=1800})
					transition.to(floor3, { x=cw/32*6,y=ch/32*22 ,time=1800})
					transition.to(floor4, { x=cw/32*9+5,y=ch/32*22,time=1800})
					transition.to(floor5, { y=ch/16*17,time=1800})
					transition.to(floor6, { y=ch/32*22,time=1800})	
					transition.to(floor7, { y=ch/16*17,time=1800})	
					transition.to(floor8, { y=ch/16*17,time=1800})
					transition.to(floor9, { y=ch/16*17,time=1800})
					transition.to(floor10, { x=cw/32*28.5,y=ch/16*17,time=1800})
					transition.to(wall2, { x=-cw/16,y=ch/8*5,time=1800})
					transition.to(wall3, { x=-cw/16,y=ch/32*25 +5,time=1800})
					piso = 9
        		end
        		timer.performWithDelay( 3000, setRuntimes )
		end
		return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local function nextScreen (event)
  composer.gotoScene( "intro" )
end

-- create()
function scene:create( event )

 	local sceneGroup = self.view
 	rectangleShape = { -10,-5, -10,25, 10,25, 10,-5}
 	cuadro = 0
	piso = 0
	doubleJump = 0
	controlador = true

	

	bg = display.newImageRect( sceneGroup,"backgrounds/background1.png", cw,ch )
	bg.x = 0
	bg.y = 0
	bg.xScale=6.3
	bg.yScale=1.455
	bg.anchorX=0
	bg.anchorY=0
	backGroup:insert( bg )

	floor1 = display.newRect(sceneGroup,cw/2, ch/32*21, cw/2+70,15)
	floor1.isVisible = false
	floor1.name = "floor1"
	floorGroup:insert(floor1)
	physics.addBody(floor1, "static",{ bounce=0, friction=1 })

	floor2 = display.newRect(sceneGroup,cw/4*3+50, ch/32*21 + 15, cw/13,15)
	floor2.isVisible = false
	floor2.name = "floor2"
	floorGroup:insert(floor2)
	physics.addBody(floor2, "static",{ bounce=0, friction=1 })

	floor3 = display.newRect(sceneGroup,cw/2 - ch/40*24 + cw/13 , ch/16*17 , cw/13,15)
	floor3.isVisible = false
	floor3.name = "floor3"
	floorGroup:insert(floor3)
	physics.addBody(floor3, "static",{ bounce=0, friction=1 })

	floor4 = display.newRect(sceneGroup,cw/2 - ch/40*25 + cw/13*2, ch/16*17, cw/13,15)
	floor4.isVisible = false
	floor4.name = "floor4"
	floorGroup:insert(floor4)
	physics.addBody(floor4, "static",{ bounce=0, friction=1 })

	floor5 = display.newRect(sceneGroup,cw/2 - ch/40*27 + cw/13*3, ch/16*17, cw/13,15)
	floor5.isVisible = false
	floor5.name = "floor5"
	floorGroup:insert(floor5)
	physics.addBody(floor5, "static",{ bounce=0, friction=1 })

	floor6 = display.newRect(sceneGroup,cw/2 - ch/40*29 + cw/13*4, ch/16*17, cw/13,15)
	floor6.isVisible = false
	floor6.name = "floor6"
	floorGroup:insert(floor6)
	physics.addBody(floor6, "static",{ bounce=0, friction=1 })

	floor7 = display.newRect(sceneGroup,cw/2 - ch/40*31 + cw/13*5, ch/16*17, cw/10,15)
	floor7.isVisible = false
	floor7.name = "floor7"
	floorGroup:insert(floor7)
	physics.addBody(floor7, "static",{ bounce=0, friction=1 })

	floor8 = display.newRect(sceneGroup,cw/2 - ch/40*33 + cw/13*6, ch/16*17, cw/13,15)
	floor8.isVisible = false
	floor8.name = "floor8"
	floorGroup:insert(floor8)
	physics.addBody(floor8, "static",{ bounce=0, friction=1 })

	floor9 = display.newRect(sceneGroup,cw/2 - ch/40*35 + cw/13*7, ch/16*17, cw/13,15)
	floor9.isVisible = false
	floor9.name = "floor9"
	floorGroup:insert(floor9)
	physics.addBody(floor9, "static",{ bounce=0, friction=1 })

	floor10 = display.newRect(sceneGroup,cw/2 - ch/40*37 + cw/13*8, ch/16*17, cw/13,15)
	floor10.isVisible = false
	floor10.name = "floor10"
	floorGroup:insert(floor10)
	physics.addBody(floor10, "static",{ bounce=0, friction=1 })

	floor11 = display.newRect(sceneGroup,cw/2 - ch/40*39 + cw/13*9, ch/16*17, cw/13,15)
	floor11.isVisible = false
	floor11.name = "floor11"
	floorGroup:insert(floor11)
	physics.addBody(floor11, "static",{ bounce=0, friction=1 })

	floor12 = display.newRect(sceneGroup,cw/2 , ch, cw,15)
	floor12.isVisible = false
	floor12.name = "floor12"
	floorGroup:insert(floor12)
	physics.addBody(floor12, "static",{ bounce=0, friction=1 })


	wallL = display.newRect( sceneGroup, cw/2 - ch/40*19, display.contentCenterY, 20, ch )
	wallL.myName = "Left Wall"
	wallL.anchorX = 1
	wallL.alpha = 0
	floorGroup:insert(wallL)
	physics.addBody( wallL, "static", { bounce=0, friction=1 } )

	wall2 = display.newRect( sceneGroup, cw/2 - ch/40*19, ch, 20, ch/4 )
	wall2.myName = "wall2"
	wall2.anchorX = 1
	wall2.alpha = 0
	floorGroup:insert(wall2)
	physics.addBody( wall2, "static", { bounce=0, friction=1 } )

	wall3 = display.newRect( sceneGroup, cw/2 - ch/40*19, ch, 20, ch/4 )
	wall3.myName = "wall3"
	wall3.anchorX = 1
	wall3.alpha = 0
	floorGroup:insert(wall3)
	physics.addBody( wall3, "static", { bounce=0, friction=1 } )

	personaje = display.newSprite( sceneGroup, personaje_spritesheet, sequence )
	personaje.x = cw/4; 
	personaje.y = ch/4
	personaje.xScale = 0.3; personaje.yScale = 0.35
	personaje.name = "personaje"
	midGroup:insert( personaje )
	print("esta animado? ", personaje.isPlaying)




	physics.addBody(personaje, "dynamic", {shape = rectangleShape, density =10, friction=1})
	personaje.isFixedRotation = true



	

	
	
	--bg:addEventListener( "touch", sceneMovement )
	--bg:addEventListener("touch", floorMovement)

		
end
 
 
-- show()
function scene:show( event )
	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
    	timer.performWithDelay( 3000, setVerify)
    	audio.setVolume( 0.05 , { channel = 1 } )
		audio.setVolume( 0.2 , { channel = 3 } )
    	audio.play(soundtrack, {channel = 1}) 
    end
end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then      
      personaje:removeEventListener( "enterFrame", verify )
      
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    floorGroup:removeSelf()
    personaje:removeEventListener( "enterFrame", verify )
    Runtime:removeEventListener( "enterFrame", sceneMovement )
	Runtime:removeEventListener( "enterFrame", floorMovement )
	Runtime:removeEventListener( "collision", death1)
	Runtime:removeEventListener( "key", teclas )
	Runtime:removeEventListener( "collision", globalCollision)
    midGroup:removeSelf( ) 
    
    -- Code here runs prior to the removal of scene's view
 
end
 
arr_r:addEventListener( "touch", moverDerecha )
controlador2:addEventListener( "touch", moverIzquierda )
buttonA:addEventListener( "touch", saltar )




-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -----------------------------------------------------------------------------------
 
return scene




