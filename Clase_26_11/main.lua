-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local cw = display.contentWidth
local ch = display.contentHeight

local fondo = display.newRect( cw/2, ch/2, cw, ch )
fondo:setFillColor( 0.43, 0, 0.78 )

local grupoFondo = display.newGroup()
local grupoMedio = display.newGroup( )
local grupoDelantero = display.newGroup()



local bg = display.newImageRect(grupoFondo, "fondo.jpg", cw,ch )
bg:translate( cw/2, ch/2 )

local bg2 = display.newImageRect(grupoFondo,"fondo2.png", cw,ch )
bg2.x = cw/2; bg2.y = ch/2
bg2:translate( cw, 0 )

local options = {
	width = 300,
	height = 300,
	numFrames = 8
}

local options2 = {
	width = 533,
	height = 300,
	numFrames = 6
}

local options3 = {
	width = 1750/5,
	height = 1800/4,
	numFrames= 19
}

local personaje_spritesheet = graphics.newImageSheet( "avanzaD.png",  options )
local personaje_spritesheet_2 = graphics.newImageSheet( "avanzaL.png", options )
local personaje_acciones_spritesheet = graphics.newImageSheet("special.png", options2)
local cabra_salto = graphics.newImageSheet("sana.png", options3)


local sequence = {
	{
		name="derecha",
		frames = {5,6,7,8,1,2,3,4},
		loopCount = 0,
		time = 667, 
		sheet = personaje_spritesheet
	},
	{
		name="izquierda",
		frames={4,3,2,1,8,7,6,5},
		loopCount = 0,
		time =	667,
		sheet = personaje_spritesheet_2
	},
	{
		name="atacar",
		frames= {1,6,3, 2, 2,1,4},
		loopCount = 1,
		time = 2000,
		sheet = personaje_acciones_spritesheet
	},{
		name = "saltar",
		frames = {4,6,6,5,5,4},
		loopCount = 1,
		time = 2000,
		sheet = personaje_acciones_spritesheet
	},
	{
		name= "saltar2",
		start =1,
		count = 19,
		loopCount =1,
		time = 1200,
		sheet = cabra_salto
	}
}

local personaje = display.newSprite(  personaje_spritesheet, sequence )
personaje.x = cw/2; personaje.y = ch/2 + 60
personaje.anchorY = 0
personaje.xScale = 0.3; personaje.yScale = 0.3
print("esta animado? ", personaje.isPlaying)
--personaje:setSequence( "avanzar_izquierda" )
personaje:setSequence( "izquierda" )
--personaje:play( )


local controlador = display.newImageRect( "pad.png", 100,100)
controlador.x = 60; controlador.y = ch -60

function moverDerecha(e)
	if e.phase == "began" then
		personaje:setSequence( "derecha" )
		personaje:play( )
		timer.performWithDelay(100, function()
				personaje.x = personaje.x + 5
			end, -1, "movimiento")
	elseif e.phase == "moved" then 
	--	personaje.x = personaje.x + 5
 	
	elseif e.phase == "ended" then
		personaje:pause()
		personaje:setFrame( 1 )
		timer.cancel("movimiento")
 	end
	return true
end

function teclas(e)

	if e.phase == "down" then
		print("tecla oprimida", e.keyName)
		if e.keyName == "right" then
			personaje:setSequence( "derecha" )
			personaje:play( )
			timer.performWithDelay(100, function()
				personaje.x = personaje.x + 5

				-- Mover individualmente a cada ojeto del grupo fondo
					-- bg.x = bg.x - 1
					-- bg2.x = bg2.x -1
--				grupoFondo.x = grupoFondo.x - 5


				if personaje.x >= cw then 
					bg:translate(-cw,0)
					bg2:translate(-cw,0)
					personaje.x = 20

				end


			end, -1, "movimiento")
	
		elseif e.keyName == "left" then
			personaje:setSequence( "izquierda" )
			personaje:play( )
			timer.performWithDelay(100, function()
				personaje.x = personaje.x - 5

				if personaje.x <= 0 then 
					bg:translate(cw,0)
					bg2:translate(cw,0)
					personaje.x = cw- 20

				end


			end, -1, "movimiento")

		elseif e.keyName == "space" then
			--personaje:scale( -1, -1 )
			personaje.yScale = -0.3
			--personaje:rotate( 180 )
			personaje:setSequence( "saltar2" )
			personaje:play( )
		elseif e.keyName == "x" then

			personaje:setSequence( "atacar")
			personaje:play()
		end

	elseif e.phase == "up" then
		print("tecla levantada", e.keyName)
		
		if e.keyName == "right" then
			personaje:setFrame( 1 )
			personaje:pause()
		elseif e.keyName == "left" then
			personaje:setFrame( 5 )
			personaje:pause()
		end
		timer.cancel("movimiento")

	end

end

controlador:addEventListener( "touch", moverDerecha )
Runtime:addEventListener( "key", teclas )


function seguirCamara ()

	grupoFondo.x = - personaje.x + cw/2
	grupoFondo.y = personaje.y -ch*0.6 -30


end


Runtime:addEventListener( "enterFrame", seguirCamara )



