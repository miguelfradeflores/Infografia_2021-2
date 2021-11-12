-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
cw = display.contentWidth
ch = display.contentHeight

ach = display.safeActualContentHeight



--display.setStatusBar( display.HiddenStatusBar )

print( display.actualContentWidth, display.actualContentHeight )
print( display.safeActualContentHeight, display.safeActualContentWidth )

display.newLine( 0,0, cw, ch )


miLinea =  display.newLine( cw/2, -40, cw/2, ch, cw, ch/2, 0, ch/2 )
miLinea:append(cw/2, ch )
miLinea.strokeWidth = 5

-- display.newCircle( cw/2, ch/2, 50 )

-- display.newCircle(50, 10, 50)

cuadrado =  display.newRect(  0, 0, 50, 50 )

print(cuadrado.x, cuadrado.y)

cuadrado.x = 0
cuadrado.anchorX = 0
cuadrado.anchorY = 0
cuadrado:setFillColor( 1,0,0 )
cuadrado:setStrokeColor( 0, 0, 1 )
cuadrado.strokeWidth = 5
--cuadrado:setFillColor( red, green, blue, alpha )

print( cuadrado.width, cuadrado.height )


star = display.newLine( 200, 90, 227, 165 )
star:append( 305,165, 243,216, 265,290, 200,245, 135,290, 157,215, 95,165, 173,165, 200,90 )
star:setStrokeColor( 228/255, 213/255, 22/255,0.2 )
-- star:setFillColor(1,0,0)


local vertices = { 0,-150, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, }
 
local o = display.newPolygon( cw/2, ch/2 -45, vertices )
o:setFillColor( 0.33 )

local vertices2 ={
	0, ch/2,
	cw/2, ch,
	cw, ch/2
}

-- local triangulo = display.newPolygon(0,0, vertices2 )
-- triangulo.x = cw/2
-- triangulo.y = ch/2
-- triangulo.anchorY= 0
