-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local cw = display.contentWidth
local ch = display.contentHeight

local paddingX = cw/30

print( cw,ch )

local fondo = display.newRect(  cw/2, ch/2, cw, ch )
fondo:setFillColor( 0.75,0, 0 )


local fondo2 = display.newImageRect( "5.jpg",cw, ch )
fondo2.x = cw/2
fondo2.y = ch/2

-- fondo:toFront( )

local boton = display.newImageRect( "botones/plus_button.jpg" , 30, 30 )
boton.x = cw/2
boton.y = ch/2

local personaje = display.newImageRect( "win.png", paddingX*6, paddingX*8 )
personaje.anchorX = 0.5
personaje.anchorY = 0.5
personaje.x = cw/2
personaje.y = ch/2
print( personaje.anchorX, personaje.anchorY )


function personaje:describir()
	print("Soy el personaje del proyecto")
end

local fruta = display.newImageRect("f1.png", 20,20)
fruta.x = cw/4
fruta.y = ch*0.8
fruta.color = "Roja"
fruta.tamanho = 156

function fruta:describir()
	print( "Soy una fruta y tengo el color " .. self.color, self.tamanho )
	transition.to( self, {x=math.random(0,cw), time =2000} )
end

function detallar( self, event)
	if event.phase == "ended" then
		print("FASE FINAL DE LA FRUTA", self.x, self.y)
		self:describir()
	end

	return true

end

fruta.touch = detallar

fruta:addEventListener( "touch", fruta )

-- local circulo = display.newCircle(  personaje.x, personaje.y, 10 )
-- circulo:setFillColor( 0,0,1 )

function tocar( event )
	if event.phase == "began" then
		print( "Fase inicial de la cabra", personaje.x, personaje.y )

	elseif event.phase == "moved" then
		print( "Fase durante de la cabra" , event.x, event.y)
		
		--personaje:removeSelf( )

	elseif event.phase == "ended" or event.phase == "cancelled" then
		print( 'Fase final' )
		display.remove(boton)
	end
	return true
end

-- function personaje:touch(event)

-- 	if event.phase == "ended" then
-- 		display.remove(personaje)
-- 	end
-- 	return true
-- end


personaje.touch = detallar
boton:toFront( )

--personaje:addEventListener( "touch", tocar )
boton:addEventListener( "touch", tocar )
personaje:addEventListener( "touch", personaje )


function moverCabra( event )
	if event.phase == "began" then
		print( "Fase inicial del fondo" )

	elseif event.phase == "moved" then
		print( "Fase durante de la fondo" , event.x, event.y)
		-- personaje.x = event.x
		-- personaje.y = event.y
	elseif event.phase == "ended" or event.phase == "cancelled" then
		print( 'Fase final' )
		display.remove(fondo2)
	end
	return true
end





fondo2:addEventListener( "touch", moverCabra )

