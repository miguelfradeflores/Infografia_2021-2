local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local cw = display.contentWidth
local ch = display.contentHeight

-- Variables de fondo
local fondo
local fondoBano

--Personaje
local personaje_spritesheet
local personaje

-- Asset que permite cambiar de escena
local botonPuerta

-- Grupos
local grupoFondo
local grupoDelantero
local grupoMedio

-- Variable que ayuda saber la posicion de pantalla
local location

-- Opciones para el sprite 
local options = {
    -- ancho
    width = 85,
    --alto
    height = 94,
    -- numero de cuadros
    numFrames = 24
}

-- Secuencia del personaje para su movimiento
local secuence = {
        {
            name = "avanzar_izquierda",
            start = 1,
            count = 3,
            loopCount = 1,
            time = 250, 
            sheet = personaje_spritesheet
        },
        {
            name = "avanzar_derecha",
            frames = {1,9,16},
            loopCount = 1,
            time = 250, 
            sheet = personaje_spritesheet
        }
}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Funcion para cambiar de escena
function irBano( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "inicioHistoria" ,{
            effect = "zoomInOut",
            time = "1000"
            } )
    end
    return true
end

-- Funcion para el movimiento del personaje
function teclas( event )
    if event.phase == "down" then 
        if event.keyName == "right" then 
            print("Tecla oprimida: ", event.keyName) 
            personaje:setSequence( "avanzar_derecha" )
            personaje:play()
            timer.performWithDelay( 100, function() 
                if(personaje.x < cw - 20 or location == 1) then 

                    personaje.x = personaje.x + 10
                    --grupoFondo.x = grupoFondo.x - 5

                    if personaje.x >= cw then 
                        fondo:translate(-cw,0)
                        fondoBano:translate(-cw,0)
                        personaje.x = 20
                        location = location +1 

                        grupoMedio.x = cw/2.6
                        print( grupoMedio.x, botonPuerta.x )
                        print( fondoBano.x )

                    end
                end
                
            end, -1, "movimiento" ) 
        elseif event.keyName == "left" then 
            print("Tecla oprimida: ", event.keyName) 
            personaje:setSequence( "avanzar_izquierda" )
            personaje:play()
            timer.performWithDelay( 100, function() 
                print(personaje.x)
                if(personaje.x > 10 ) then 
                    personaje.x = personaje.x - 10
                    --grupoFondo.x = grupoFondo.x + 5

                    if personaje.x <= 0 then 
                        fondo:translate(cw,0)
                        fondoBano:translate(cw,0)
                        personaje.x = cw- 20

                        grupoMedio.x = -cw/2.6

                    end
                end 
            end, -1, "movimiento" )
        end
    elseif event.phase == "up" then 
        print( "Tecla levantada: ", event.keyName )
        --  personaje:pause()
        personaje:setFrame( 1 )
        timer.cancel( "movimiento" )
    end
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Grupos
    grupoFondo = display.newGroup()
    grupoMedio = display.newGroup()
    grupoDelantero = display.newGroup()

    sceneGroup:insert(grupoFondo)
    sceneGroup:insert(grupoMedio)
    sceneGroup:insert(grupoDelantero)

    -- Primer fondo
    fondo = display.newImageRect(grupoFondo, "Assets/Frames/154.jpg", cw, ch )
    fondo:translate( cw/2, ch/2 )

    -- Segundo fondo
    fondoBano = display.newImageRect(grupoFondo,"Assets/Frames/157.jpg", cw,ch )
    fondoBano.x = cw/2
    fondoBano.y = ch/2
    fondoBano:translate( cw, 0 )

    --Sprite personaje
    personaje_spritesheet = graphics.newImageSheet( "Assets/spriteSherk.png", options )

    -- Posicion del personaje
    personaje = display.newSprite( grupoDelantero, personaje_spritesheet, secuence )
    personaje.x = cw/2
    personaje.y = ch/1.2
    personaje.xScale = 1
    personaje.yScale = 1

    -- Puerta png
    botonPuerta = display.newImageRect(grupoMedio, "Assets/botonPuerta.png", cw/3.5, ch/1.1)
    botonPuerta.y = ch/11
    botonPuerta.anchorX = 0
    botonPuerta.anchorY = 0
    botonPuerta:setFillColor( 1, 0.6, 0 )
    grupoMedio:translate( cw + cw/2 , 0 )

    -- Locacion se inicializa en 1 
    location = 1

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        -- Uso de teclas para que se mueva el personaje
        Runtime:addEventListener( "key", teclas )
        
        -- Touch para cambiar de escena
        botonPuerta.touch = irBano
        botonPuerta:addEventListener( "touch", botonPuerta )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene