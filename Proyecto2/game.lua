local composer = require( "composer" )
local physics = require('physics')
local gameUI = require("gameUI")

local scene = composer.newScene()

physics.start()
physics.setGravity( 0 , 0 )
physics.setDrawMode( 'normal' )

-- Variables de apoyo
local cw = display.contentWidth
local ch = display.contentHeight

local grupoFondo = display.newGroup()
local grupoJuego = display.newGroup()

local marcadorJ = 0
local marcadorR = 0

local controlador = true

-- Escenario
local fondo = display.newRect( grupoFondo , 0 , 0 , cw - 10 , ch - 10 )
fondo:setFillColor( 0.75 )
fondo:translate( cw / 2 , ch / 2 )

local lineaCentral = display.newRect( grupoFondo , 0 , 0 , 5 , ch - 10 )
lineaCentral:setFillColor( 1 , 0 , 0 )
lineaCentral:translate( cw / 2 , ch / 2 )

local circuloCentral = display.newCircle( grupoFondo , cw / 2 , ch / 2 , 50 )
circuloCentral:setFillColor( 0 , 0 )
circuloCentral.strokeWidth = 5
circuloCentral:setStrokeColor( 1 , 0 , 0 )

local marcadorJugador = display.newText( grupoFondo , marcadorJ , 120 , 160 , 'arial' , 100 )
marcadorJugador:setFillColor( 0 )

local marcadorRival = display.newText( grupoFondo , marcadorR , 360 , 160 , 'arial' , 100 )
marcadorRival:setFillColor( 0 )

local bordeSuperior = display.newRect( grupoJuego , 0 , 0 , cw , 5 )
bordeSuperior:setFillColor( 1 )
bordeSuperior:translate( cw / 2 , 2.5 )

local bordeInferior = display.newRect( grupoJuego , 0 , 0 , cw , 5 )
bordeInferior:setFillColor( 1 )
bordeInferior:translate( cw / 2 , ch - 2.5 )

local bordeIzquierdoSuperior = display.newRect( grupoJuego , 0 , 0 , 5 , 100 )
bordeIzquierdoSuperior:setFillColor( 1 )
bordeIzquierdoSuperior:translate( 2.5 , 50 )

local bordeIzquierdoInferior = display.newRect( grupoJuego , 0 , 0 , 5 , 100 )
bordeIzquierdoInferior:setFillColor( 1 )
bordeIzquierdoInferior:translate( 2.5 , ch - 50 )

local bordeDerechoSuperior = display.newRect( grupoJuego , 0 , 0 , 5 , 100 )
bordeDerechoSuperior:setFillColor( 1 )
bordeDerechoSuperior:translate( cw - 2.5 , 50 )

local bordeDerechoInferior = display.newRect( grupoJuego , 0 , 0 , 5 , 100 )
bordeDerechoInferior:setFillColor( 1 )
bordeDerechoInferior:translate( cw - 2.5 , ch - 50 )

local arcoIzquierdo = display.newRect( grupoJuego , 0 , 0 , 5 , ch)
arcoIzquierdo:setFillColor( 0 , 0 )
arcoIzquierdo:translate( -30 , ch / 2 )

local arcoDerecho = display.newRect( grupoJuego , 0 , 0 , 5 , ch)
arcoDerecho:setFillColor( 0 , 0 )
arcoDerecho:translate( cw + 30 , ch / 2 )

local disco = display.newCircle( grupoJuego , cw / 2 , ch / 2 , 15 )
disco:setFillColor( 1 , 1 , 0 )
disco.strokeWidth = 2
disco:setStrokeColor( 0 )

local jugador = display.newCircle( grupoJuego , 50 , ch / 2 , 20 )
jugador:setFillColor( 0 , 0 , 1 )
jugador.strokeWidth = 2
jugador:setStrokeColor( 0 )

local rival = display.newCircle( grupoJuego , cw - 50 , ch / 2 , 20 )
rival:setFillColor( 0 , 1 , 0 )
rival.strokeWidth = 2
rival:setStrokeColor( 0 )

-- Funciones
function setControlador()
	controlador = true
end

function mostrarResultados()
	display.remove( marcadorJugador )
	display.remove( marcadorRival )
	marcadorJugador = display.newText( grupoFondo , marcadorJ , 120 , 160 , 'arial' , 100 )
	marcadorJugador:setFillColor( 0 )
	marcadorRival = display.newText( grupoFondo , marcadorR , 360 , 160 , 'arial' , 100 )
	marcadorRival:setFillColor( 0 )
end

function moverJugador( e )
	return gameUI.dragBody( e )
end

function verificarJugadorX( e )
	if ( jugador.x > cw / 2 ) then
		jugador.x = cw / 2
	end
end

function verificarDisco( e )
	local vx, vy = disco:getLinearVelocity()
	if ( vx == 0 and vy == 0 ) then
		disco.x = cw / 2
		disco.y = ch / 2
	end
end

function verificarMarcador( e )
	if ( marcadorJ == 5 ) then
		timer.cancel( 'moverRival' )
		jugador:removeEventListener( 'touch' , moverJugador )
		Runtime:removeEventListener( 'enterFrame' , verificarJugadorX )
		Runtime:removeEventListener( 'enterFrame' , verificarDisco )
		Runtime:removeEventListener( 'enterFrame' , verificarMarcador )
		Runtime:removeEventListener( 'collision' , anotacion )
		jugador:setLinearVelocity( 0 , 0 )
		jugador.angularVelocity = 0
		jugador.x = 50
		jugador.y = ch / 2
		rival.x = cw - 50
		rival.y = ch / 2
		local ganador = display.newText( 'GANASTE' , cw / 4 , ch * 3 / 4 , 'arial' , 30 )
		ganador:setFillColor( 0 , 0 , 1 )
	elseif ( marcadorR == 5 ) then
		timer.cancel( 'moverRival' )
		jugador:removeEventListener( 'touch' , moverJugador )
		Runtime:removeEventListener( 'enterFrame' , verificarJugadorX )
		Runtime:removeEventListener( 'enterFrame' , verificarDisco )
		Runtime:removeEventListener( 'enterFrame' , verificarMarcador )
		Runtime:removeEventListener( 'collision' , anotacion )
		jugador:setLinearVelocity( 0 , 0 )
		jugador.angularVelocity = 0
		jugador.x = 50
		jugador.y = ch / 2
		rival.x = cw - 50
		rival.y = ch / 2
		local perdedor = display.newText( 'PERDISTE' , cw / 4 , ch * 3 / 4 , 'arial' , 30 )
		perdedor:setFillColor( 1 , 0 , 0 )
	end
end

function anotacion(e)
	if ( e.object2 == disco and e.object1 == arcoDerecho or e.object1 == disco and e.object2 == arcoDerecho ) then
		if (controlador) then
			controlador = false
			marcadorJ = marcadorJ + 1
			disco:setLinearVelocity( 0 , 0 )
			mostrarResultados()
			transition.to( disco , { time = 100 , x = cw / 2 , y = ch / 2 , delay = 100 , onComplete = setControlador} )
		end
	elseif ( e.object2 == disco and e.object1 == arcoIzquierdo or e.object1 == disco and e.object2 == arcoIzquierdo ) then
		if (controlador) then
			controlador = false
			marcadorR = marcadorR + 1
			disco:setLinearVelocity( 0 , 0 )
			mostrarResultados()
			transition.to( disco , { time = 100 , x = cw / 2 , y = ch / 2 , delay = 100 , onComplete = setControlador} )
		end
	end
end

-- Scenes
function scene:create( event )
	local sceneGroup = self.view

	-- Fisicas
	physics.addBody( bordeInferior , 'static' )
	physics.addBody( bordeIzquierdoInferior , 'static' )
	physics.addBody( bordeIzquierdoSuperior , 'static' )
	physics.addBody( bordeSuperior , 'static' )
	physics.addBody( bordeDerechoInferior , 'static' )
	physics.addBody( bordeDerechoSuperior , 'static' )
	physics.addBody( arcoIzquierdo , 'static' )
	physics.addBody( arcoDerecho , 'static' )
	physics.addBody( disco , 'dynamic' , { radius = 15 } )
	physics.addBody( jugador , 'dynamic' , { radius = 20 } )
	physics.addBody( rival , 'static' , { radius = 20 } )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then
		-- Listeners
		mostrarResultados()
		jugador:addEventListener( 'touch' , moverJugador )
		Runtime:addEventListener( 'enterFrame' , verificarJugadorX )
		Runtime:addEventListener( 'enterFrame' , verificarDisco )
		Runtime:addEventListener( 'enterFrame' , verificarMarcador )
		Runtime:addEventListener( 'collision' , anotacion )
		timer.performWithDelay( 1000 , function()
			transition.to( rival , { time = 500, y = 110 } )
			transition.to( rival , { time = 500, y = 210 , delay = 500 } )
		end , 0 , 'moverRival' )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene