local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local cw = display.contentWidth
local ch = display.contentHeight

-- Variables para la animación
local frame1
local frame

-- Fondo para el uso de la camara
local background

-- Boton para iniciar la animacion
local play

-- Botones
local backCam
local backScene
local nextCam
local nextScene

-- Lectura 
local backgroundMusic
local playMusic

--En el cuadro que comenzará
local cuadro = 0

-- Controlador para cambiar la camara
local controlador = true

-- Opciones de la animacion
local options = {
    width = 1000/5,
    height = 980/8,
    numFrames = 40
}

-- Secuencia de la animacion
local secuence = {
    {
        name = "reproducir",
        start = 1,
        count = 40,
        loopCount = 1,
        time = 5000, 
        sheet = frame1
    }
}

-- Controlador para cambiar 
function setControlador( )
    controlador = true
end

-- Estados para cambiar la camara
local estados = {
    {x=0, y=0, xScale=3.3, yScale=3, anchorX=0.5, anchorY=0.1, time = 2000, onComplete = setControlador},
    {x=0, y=0, xScale=3.3, yScale=2.7, anchorX=0.51, anchorY=0.37, time = 3000, onComplete = setControlador},
    {x=0, y=0, xScale=1, yScale=1, anchorX=0, anchorY=0, time = 3000, onComplete = setControlador}
}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Animacion 
function moverFotograma( event)
    if event.phase == "began" then 
        frame:setSequence( "reproducir" )
        frame:play()
        timer.performWithDelay( 100, function() 
            end, -1, "movimiento" )
    elseif event.phase == "ended" then 
        frame:setFrame( 1 )
        timer.cancel( "movimiento" )
    end
    return true
end

-- Cambia de cuadro al siguiente
function cambiar_cuadro( event )
        if event.phase == "ended" then 
            if controlador == true then 
                cuadro = cuadro + 1
                controlador = false
                transition.to( background, (estados[cuadro]) )
                print( "touch" )
            end
        end
        return true
end

-- Cambio de cuadro al anterior
function retroceder_cuadro( event )
        if event.phase == "ended" then 
            if controlador == true then 
                if cuadro > 1 then
                    cuadro = cuadro - 1
                    controlador = false
                    transition.to( background, (estados[cuadro]) )
                    print( "touch" )
                end
            end
        end
        return true
end

-- Cambio de escena
function irEscena2( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "historia2" ,{
            effect = "slideLeft",
            time = "1000"
            } )
    end
    return true
end

-- Volver a la pantalla inicial
function backPantallaInicial( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "pantallaInicial" ,{
            effect = "zoomOutIn",
            time = "1000"
            } )
    end
    return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Libro para la camara
    background = display.newImageRect(sceneGroup, "Assets/Frames/40.jpg", cw, ch )
    background.x = cw/2
    background.y = ch/2

    -- Botones
    backScene = display.newImageRect( sceneGroup, "Assets/backCamGreen.png", cw/10, cw/10 )
    backScene.x = cw/10
    backScene.y= ch/1.1

    backCam = display.newImageRect( sceneGroup, "Assets/back.png", cw/10, cw/10 )
    backCam.x = cw/10
    backCam.y= ch/2

    nextScene = display.newImageRect( sceneGroup, "Assets/nextCamGreen.png", cw/10, cw/10 )
    nextScene.x = cw/1.1
    nextScene.y= ch/1.1

    nextCam = display.newImageRect( sceneGroup, "Assets/next.png", cw/10, cw/10 )
    nextCam.x = cw/1.1
    nextCam.y= ch/2

    -- Animacion
    frame1 = graphics.newImageSheet( "Assets/Frames/frame1.png", options )

    -- Posicion de la animacion
    frame = display.newSprite( sceneGroup, frame1, secuence )
    frame.x = cw/2
    frame.y = ch/2 
    frame.xScale = 3
    frame.yScale = 3.9

    -- Boton
    play = display.newImageRect( sceneGroup, "Assets/play2.png", cw/5, cw/5 )
    play.x = cw/2
    play.y= ch/2
 
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        -- Boton para comenzar la animacion
        play:addEventListener( "touch", moverFotograma )

        -- Transicion de la animacion a la camara
        transition.to( frame, {delay = 5000, alpha=0} )
        transition.to( play, {delay = 1000, alpha=0} )

        -- Botones para volver con la camara
        nextCam:addEventListener( "touch", cambiar_cuadro )

        backCam:addEventListener( "touch", retroceder_cuadro )

        -- Botnes para los cambios de escena
        backScene.touch = backPantallaInicial
        backScene:addEventListener( "touch", backScene )

        nextScene.touch = irEscena2
        nextScene:addEventListener( "touch", nextScene )

        -- Audio
        backgroundMusic = audio.loadStream("pagina1.mp3")
        playMusic = audio.play(backgroundMusic)

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
        frame.alpha = 1
        play.alpha = 1
        audio.stop( playMusic )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    audio.stop( playMusic )
 
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