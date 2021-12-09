local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local cw = display.contentWidth
local ch = display.contentHeight

local frame1
local frame
local background
local play
local cuadro = 0
local controlador = true


local backScene
local nextScene

local backgroundMusic
local playMusic

local options = {
    width = 999/3,
    height = 972/5,
    numFrames = 14
}

local options = {
    width = 1000/4,
    height = 726/5,
    numFrames = 18
}

local secuence = {
    {
        name = "reproducir",
        start = 1,
        count = 18,
        loopCount = 1,
        time = 6000, 
        sheet = frame1
    }
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


function backHistoria5( self, event )
    if event.phase == "ended" then 
    print("touch")
        composer.gotoScene( "historia5" ,{
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
    background = display.newImageRect(sceneGroup, "Assets/Frames/118.jpg", cw, ch )
    background.x = cw/2
    background.y = ch/2

    backScene = display.newImageRect( sceneGroup, "Assets/backCamGreen.png", cw/10, cw/10 )
    backScene.x = cw/10
    backScene.y= ch/1.1

    frame1 = graphics.newImageSheet( "Assets/Frames/frame6.png", options )

    frame = display.newSprite( sceneGroup, frame1, secuence )
    frame.x = cw/2
    frame.y = ch/2 
    frame.xScale = 3
    frame.yScale = 3

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

        transition.to( frame, {delay = 6000, alpha=0} )
        transition.to( play, {delay = 1000, alpha=0} )

        backScene.touch = backHistoria5
        backScene:addEventListener( "touch", backScene )

        backgroundMusic = audio.loadStream("pagina7.mp3")
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