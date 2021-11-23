local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

 function irPantallaMenu( self, event )
    if event.phase == "ended" then 
        transition.to( playBoton, {alpha = 0, iterations = 5, time = 900} ) 
        composer.gotoScene( "menu" )
    end
    return true
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    local fondoOscuro = display.newImageRect(sceneGroup,"fondoMain2.jpg", cw, ch )
    fondoOscuro.anchorX = 0 
    fondoOscuro.anchorY = 0 
    fondoOscuro:setFillColor( 106/255, 100/255, 101/255, 0.5)

    local playBoton = display.newImageRect(sceneGroup, "play.png", cw/3, ch/2)
    playBoton.x = cw/2
    playBoton.y = ch/2

    local textPlay = display.newText(sceneGroup, "It's time to play", 100, 100, "arial black")
    textPlay:setTextColor( 1, 1, 1 )
    textPlay.size = 25
    textPlay.x = cw/2
    textPlay.y = ch/15
    textPlay.anchorX = 0.5
    textPlay.anchorY = 0

    function parpadear_boton( event )
        if event.phase  == "ended" then 
            transition.to( playBoton, {alpha = 0, iterations = 3, time = 700} ) 
        end
    end

    -- fondo:addEventListener("touch", parpadear_fondo )

    playBoton.touch = irPantallaMenu

    playBoton:addEventListener( "touch", playBoton )
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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