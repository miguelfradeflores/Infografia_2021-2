-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local cw = display.contentWidth
local ch = display.contentHeight


local bg = display.newImageRect( "fondo.jpg", cw,ch )
bg:translate( cw/2, ch/2 )


local options = {
	width = 300,
	height = 300,
	numFrames = 8
}

-- local options2 = {
-- 	width = 300,
-- 	height = 300,
-- 	numFrames = 8
-- }


local personaje_spritesheet = graphics.newImageSheet( "avanzaD.png",  options )
local personaje_spritesheet_2 = graphics.newImageSheet( "avanzaL.png", options )


local sequence = {
	{
		name="izquierda",
		start = 1,
		count = 8,
		loopCount = 0,
		time =	667,
		sheet = personaje_spritesheet_2
	},
	{
		name="derecha",
		frames = {5,6,7,8,1,2,3,4},
		loopCount = 0,
		time = 667, 
		sheet = personaje_spritesheet
	}
}

local personaje = display.newSprite(  personaje_spritesheet_2, sequence )
personaje.x = cw/4; personaje.y = ch/2 + 60
personaje.xScale = 0.3; personaje.yScale = 0.3
print("esta animado? ", personaje.isPlaying)
--personaje:setSequence( "avanzar_izquierda" )
-- personaje:setSequence( "seq1" )
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
		if e.keyName == "right" then
			print("tecla oprimida", e.keyName)
			personaje:play( )
			timer.performWithDelay(100, function()
				personaje.x = personaje.x + 5
			end, -1, "movimiento")
		end
	elseif e.phase == "up" then
		print("tecla levantada", e.keyName)

		personaje:pause()
		personaje:setFrame( 1 )
		timer.cancel("movimiento")

	end

end

controlador:addEventListener( "touch", moverDerecha )
Runtime:addEventListener( "key", teclas )





