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

--En el cuadro que comenzará 
local cuadro = 0

-- Controlador para cambiar la camara
local controlador = true

-- Botones
local backCam
local backScene
local nextCam
local nextScene

-- Lectura 
local backgroundMusic
local playMusic

-- Opciones de la animacion
local options = {
    width = 1000/3,
    height = 810/4,
    numFrames = 12
}

local secuence = {
    {
        name = "reproducir",
        start = 1,
        count = 12,
        loopCount = 1,
        time = 1000, 
        sheet = frame1
    }
}

function setControlador( )
    controlador = true
end

local estados = {
    {x=0, y=0, xScale=3, yScale=3.5, anchorX=0.15, anchorY=0.10, time = 2000, onComplete = setControlador},
    {x=0, y=0, xScale=3, yScale=3, anchorX=0.15, anchorY=0.35, time = 3000, onComplete = setControlador},
    {x=0, y=0, xScale=3, yScale=5, anchorX=0.15, anchorY=0.68, time = 3000, onComplete = setControlador},
    {x=0, y=0, xScale=3.3, yScale=6, anchorX=0.5, anchorY=0.10, time = 3000, onComplete = setControlador},
    {x=0, y=0, xScale=3, yScale=2, anchorX=0.5, anchorY=0.25, time = 3000, onComplete = setControlador},
    {x=0, y=0, xScale=1, yScale=1, anchorX=0, anchorY=0, time = 3000, onComplete = setControlador}
}
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

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

function irEscena3( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "historia3" ,{
            effect = "slideLeft",
            time = "1000"
            } )
    end
    return true
end

function backInicioHistoria( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "inicioHistoria" ,{
            effect = "slideRight",
            time = "1000"
            } )
    end
    return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    background = display.newImageRect(sceneGroup, "Assets/Frames/52.jpg", cw, ch )
    background.x = cw/2
    background.y = ch/2

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

    frame1 = graphics.newImageSheet( "Assets/Frames/frame2.png", options )

    frame = display.newSprite( sceneGroup, frame1, secuence )
    frame.x = cw/2
    frame.y = ch/2 
    frame.xScale = 2
    frame.yScale = 2

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
        play:addEventListener( "touch", moverFotograma )
        
        transition.to( frame, {delay = 1000, alpha=0} )
        transition.to( play, {delay = 1000, alpha=0} )
        
        nextCam:addEventListener( "touch", cambiar_cuadro )

        backCam:addEventListener( "touch", retroceder_cuadro )

        backScene.touch = backInicioHistoria
        backScene:addEventListener( "touch", backScene )

        nextScene.touch = irEscena3
        nextScene:addEventListener( "touch", nextScene )

        backgroundMusic = audio.loadStream("pagina2.mp3")
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