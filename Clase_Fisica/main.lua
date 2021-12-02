-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require "physics"


local cw= display.contentWidth
local ch = display.contentHeight

local fondo = display.newRect(cw/2,ch/2,cw,ch)
fondo:setFillColor( 0.62 )


local grupo = display.newGroup()


physics.start()

local piso2 = display.newRect(cw/2, ch*0.99, cw,15)
piso2.isVisible = false
piso2.name = "piso"


local piso = display.newImageRect("piso.png", cw+100, 100)
piso.x = cw/2; piso.y = ch*0.9
piso.name = "piso"

local dimensiones_piso = { halfWidth= cw/2, halfHeight=5, x=-5, y=15, angle=0 }

physics.addBody(piso2, "static")

physics.addBody(piso, "static", {box = dimensiones_piso, friction=1})


local cuadrado = display.newRect(grupo,  0,0, 200,200)
cuadrado.name = "cuadrado"
local cabeza = display.newCircle( grupo, cuadrado.x, cuadrado.y -30, 1 )
cabeza.name = "cabeza"


local dimensiones_cuadrado = { halfWidth= 25, halfHeight=25, x=0, y=75, angle=0 }
physics.addBody(cuadrado, "static", {box = dimensiones_cuadrado})
physics.addBody(cabeza, "static", {radius=25})
-- grupo.x = cw/2 ; grupo.y = ch/2
cabeza.x = cw/3; cabeza.y = ch/2-25



local manzana = display.newImageRect(grupo, "f1.png", 195*0.3, 195*0.3)
manzana.x = cw/2; manzana.y = 0
manzana.name = "manzana1"
--manzana:scale( 0.3, 0.3 )
--manzana.anchorX = 0

local manzana2 = display.newImageRect(grupo, "f1.png", 195*0.3, 195*0.3)
manzana2.x = cw/2-25; manzana2.y = ch/2
manzana2.name = "manzana 2"


print( "Manana ancho, alto", manzana.width, manzana.height )

physics.addBody(manzana, "dynamic", {radius = 27, bounce = 0.5, density =5})
physics.addBody(manzana2, "dynamic", {radius = 27, bounce = 0.3, density =3, friction=1 })

print(physics.getGravity())

physics.setGravity(0, 2)

physics.setDrawMode( "hybrid" )

function poscion()
	print( "Mnazana y: ", manzana.y )
end

-- Runtime:addEventListener( "enterFrame", poscion )

function colision (self, event)
	print(self.name)
	print(event.other.name)
	if event.other.name == "manzana 2" then
		print("Colisionee con la manzana 2")
		event.other:setFillColor( 0,0,1 )
		event.other.alpha =0
		display.remove( event.other )
		event.other = nil

	elseif event.other.name == "piso" then

		display.remove(self)

	end
end


function globalCollision( event)
	print( event.object1.name )
	print( event.object2.name )

	if (event.object2.name == "manzana1" and event.object1.name == "manzana 2" )  or 
		(event.object1.name == "manzana1" and event.object2.name == "manzana 2" ) then
		display.remove( event.object2 )
	end



end


Runtime:addEventListener( "collision", globalCollision )


-- manzana.collision = colision

-- manzana:addEventListener( "collision" )


