local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local function nextScreen1 (event)
  if life == 0 then
    composer.gotoScene( "selectCh" , {
    effect = "fade",
    time = 500,
    params = {
            t = character,
            l = life
    }
    })
    else
    composer.gotoScene( "level1" , {
    effect = "fade",
    time = 500,
    params = {
            t = character,
            l = life
    }
    })
    end
end

local function nextScreen (event)
    composer.gotoScene( "level1" )
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    composer.removeScene("level1")
    timer.cancelAll()
    transition.cancel()
    timer.performWithDelay( 500, nextScreen )
end
 
 
-- show()
function scene:show( event )
local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        
    end

end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then      
      timer.cancelAll()
      composer.removeScene("grupoFondo")
      composer.removeScene("grupoMedio")
      composer.removeScene("grupoDelantero")
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