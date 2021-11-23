local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
cw = display.contentWidth
ch = display.contentHeight

local buttonStart

local backgroundMusic
local playMusic
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function irPantallaInicial( self, event )
    if event.phase == "ended" then 
        composer.gotoScene( "menu" ,{
            effect = "crossFade",
            time = "1000"
            } )
        audio.stop( playMusic )
    end
    return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local fondo = display.newImageRect(sceneGroup, "splashWallper.png", cw, ch )
    fondo.anchorX = 0 
    fondo.anchorY = 0 

    buttonStart = display.newImageRect(sceneGroup, "buttonStart.png", cw/1.5, ch/2 )
    buttonStart.x = cw/2
    buttonStart.y = ch/1.7
    buttonStart.anchorX = 0.5
    buttonStart.anchorY = 0

    backgroundMusic = audio.loadSound("sound1.mp3")
    playMusic = audio.play(backgroundMusic, {loops =-1})

    transition.to( buttonStart, { time=2500, alpha=0.3, iterations =5} )
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        buttonStart.touch = irPantallaInicial
        buttonStart:addEventListener( "touch", buttonStart )
 
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