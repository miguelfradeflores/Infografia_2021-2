-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local cw = display.contentWidth
local ch = display.contentHeight


local horizontal = display.newLine( 0, ch/2, cw, ch/2)
horizontal.strokeWidth = 3

local vertical = display.newLine( cw/2,0,cw/2, ch  )
vertical.strokeWidth=3

local icon = display.newImage( "Icon.png", cw/2,ch/2 )

print( "rotacion icono", icon.rotation )
icon.rotation = 45


local vertices = {
	0,0, 
	0,57,			--sx = 2; sy = 3
	57, 57,
	57,0
}

local vertices2 ={
	0,0,
	-40,40,
	0,81,
	40, 40
}

local sx =2
local sy =3

local p3sx = vertices[5] * sx
local p3sy = vertices[6] * sy
 
local vertices3 = {
	0,0,
	0, 171,
	114,171,
	114,0
}

local p1x = math.cos(45)*0 - math.sin(45)*0
local p1y =  math.cos(45)*0 + math.sin(45)*0

local p2x = math.cos(45)*0 - math.sin(45)*57
local p2y =  math.cos(45)*0 + math.sin(45)*57

print( p1x,p1y, p2x,p2y )



local poligono_cuadrado = display.newPolygon(  0, 0, vertices )
poligono_cuadrado.x = cw/2 + 23.5
poligono_cuadrado.y = ch/2 -23.5
poligono_cuadrado:setFillColor( 0,0,1 )


poligono_cuadrado.rotation=45

local poligono_rotado = display.newPolygon( 0, 0, vertices2 )
poligono_rotado.x = 100
poligono_rotado.y = ch/2
poligono_rotado:setFillColor( 0,0.6, 0)

print("Escala de iconos", icon.xScale, icon.yScale )
icon.xScale = 2; icon.yScale =3


local poligono_escalado = display.newPolygon(0,0, vertices3)
-- poligono_escalado.x = cw/2
-- poligono_escalado.y = ch/2
poligono_escalado:setFillColor( 0.5, 0,0, 0.6 )
poligono_escalado:rotate( 45 )

poligono_escalado:translate( cw/2, ch/2 )



--poligono_rotado:scale( 2, 3 )
poligono_cuadrado.xScale=2
poligono_cuadrado.yScale = 3


