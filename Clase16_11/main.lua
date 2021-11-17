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
personaje.anchorX = 0
personaje.anchorY = 0
personaje.x = cw/2
personaje.y = ch/2
print( personaje.anchorX, personaje.anchorY )

-- local circulo = display.newCircle(  personaje.x, personaje.y, 10 )
-- circulo:setFillColor( 0,0,1 )


local personaje2 = display.newImage("win.png", cw/4, ch/2)
print("ESCALA DEL PERSONAJE 2", personaje2.xScale, personaje2.yScale )
personaje2.xScale = 0.2; personaje2.yScale = 0.2
print( "tamanho de la imagen", personaje2.width, personaje2.height )
personaje2.alpha = 1
personaje:setFillColor( 0.25,0.42,0.13, 1 )
print( personaje2.rotation )
personaje2.rotation = 180
personaje.rotation = 145
print("Escalas ", personaje.xScale, personaje.yScale)
personaje.xScale = 1
personaje.yScale = 1


local valorPuntaje = 0


local puntaje = display.newText( "SCORE:".. valorPuntaje, 30, 30,	"arial"  )
puntaje:setTextColor( 1, 0, 0 )
print("Tamanho texto", puntaje.size )
puntaje.size = 25
puntaje.anchorX = 0

local fruta = display.newImageRect("f1.png", 20,20)
fruta.x = cw/4
fruta.y = ch*0.8
fruta.color = "Roja"
fruta.tamanho = 156
boton:toFront( )




local fruta2 = display.newImage( "f1.png", 100,250 )
fruta2.xScale=0.1; fruta2.yScale=0.1


function AvisarDetencion(  )
	puntaje.text = "Me detuve"
end

function subirFruta()
	transition.to(fruta2, {y=100, time=500, onComplete=moverFrutaIzquierda, tag="fruta2", onPause= AvisarDetencion })
end

function moverFrutaIzquierda()
	transition.to(fruta2, {x=100, time=1000, tag="fruta2"})
	--puntaje.text = "SCORE:1000"
end


transition.to(fruta2, {x = cw-100, time=2000, onComplete=subirFruta, tag="fruta2" })

--FUNCTIONES

function AumentarPuntaje()
	valorPuntaje = valorPuntaje +1
	puntaje.text = "SCORE: " .. valorPuntaje

end

function Restaurar( ... )
	puntaje.alpha=1
	puntaje.size=25
end

function parpadear(e)
	if e.phase == "ended" then
		print( "Oprimiendo el texto" )
		transition.to(puntaje, {alpha =0.2, iterations =5, time=1000, size =40, delay = 2000, onRepeat=AumentarPuntaje, onComplete= Restaurar})
	end
	return true
end


function personaje:describir()
	print("Soy el personaje del proyecto")
end


function fruta:describir()
	print( "Soy una fruta y tengo el color " .. self.color, self.tamanho )
	transition.to( self, {x=math.random(0,cw), time =2000} )
end

function detallar( self, event)
	if event.phase == "ended" then
		print("FASE FINAL DE LA FRUTA", self.x, self.y)
		self:describir()
		transition.to(self, {xScale=0.5, yScale=0.5, time=3000}  )
	end

	return true
end



function tocar( event )
	if event.phase == "began" then
		print( "Fase inicial de la cabra", personaje.x, personaje.y )

	elseif event.phase == "moved" then
		print( "Fase durante de la cabra" , event.x, event.y)
		
		--personaje:removeSelf( )

	elseif event.phase == "ended" or event.phase == "cancelled" then
		print( 'Fase final' )
		--display.remove(boton)
		transition.pause(fruta2)
		transition.pause(personaje)
	end
	return true
end


-- function personaje:touch(event)

-- 	if event.phase == "ended" then
-- 		display.remove(personaje)
-- 	end
-- 	return true
-- end

--personaje:addEventListener( "touch", tocar )

function moverCabra( event )
	if event.phase == "began" then
		print( "Fase inicial del fondo" )

	elseif event.phase == "moved" then
		print( "Fase durante de la fondo" , event.x, event.y)
		-- personaje.x = event.x
		-- personaje.y = event.y
	elseif event.phase == "ended" or event.phase == "cancelled" then
		print( 'Fase final' )
		--display.remove(fondo2)
		print( "Posicion del fondo2", fondo2.x, fondo2.y )
		transition.to(personaje2, {x = event.x, y=event.y, time=2000, rotation=0})
	end
	return true
end

personaje.touch = detallar
fruta.touch = detallar

fruta:addEventListener( "touch", fruta )
boton:addEventListener( "touch", tocar )
personaje:addEventListener( "touch", personaje )
puntaje:addEventListener( "touch", parpadear )
fondo2:addEventListener( "touch", moverCabra )

