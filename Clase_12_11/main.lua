-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local cw = display.actualContentWidth
local ch = display.contentHeight
local paddingX = cw/12
local paddingY = ch/16
local rojo = {170/255, 6/255 ,11/255}
local azul = {26/255,0,168/255}
local amarilla = {220/255,210/255,0}


print( cw, ch )

local fondo = display.newRect( 0, 0, cw, ch )
fondo.anchorX = 0; fondo.anchorY = 0
fondo:setFillColor( 104/255,242/255,242/255 )

for i=0, 11 do
	local LineaVertical = display.newLine( paddingX*i, 0, paddingX*i, ch  )
	LineaVertical.strokeWidth = 2
	LineaVertical:setStrokeColor( 0 )
end


for i=0, 16 do
	local LineaHorizontal = display.newLine( 0, paddingY*i, cw, paddingY*i )
	LineaHorizontal.strokeWidth = 2
	LineaHorizontal:setStrokeColor( 0 )
end

local hat = display.newRect( paddingX*3, 0, paddingX*5, paddingY )
hat.anchorX = 0; hat.anchorY = 0
hat:setFillColor( unpack( rojo ) )

local hat2 = display.newRect(paddingX*2, paddingY, paddingX*9, paddingY)
hat2.anchorX=0; hat2.anchorY=0
hat2:setFillColor( unpack(rojo) )

local cabello1 = display.newRect(paddingX*2, paddingY*2, paddingX*3, paddingY )
cabello1.anchorY=0; cabello1.anchorX=0
cabello1:setFillColor( unpack(azul) )

local cara = display.newRect(paddingX*3, paddingY*2, paddingX*6, paddingY*5)
cara.anchorX=0; cara.anchorY=0
cara:setFillColor( unpack(amarilla) )
--cara:toBack( )

local vertices = {
	paddingX*4, paddingY*4,
	paddingX*5, paddingY*4,
	paddingX*5, paddingY*5,
	paddingX*6, paddingY*5,
	paddingX*6, paddingY*6,
	paddingX*4, paddingY*6
}

local cabello2 = display.newPolygon( cw/2, ch/2, vertices )
cabello2:setFillColor( unpack(azul) )
cabello2.x = paddingX*4; cabello2.y = paddingY*4

cabello1:toFront( )


print(unpack(rojo))

local mario = display.newImage(  "mario.png", cw/2, ch/2 )

local mario2 = display.newImageRect("mario2.png", cw/2, cw/2)
mario2.x = cw/2; mario2.y=ch/2
--mario:toFront( )

