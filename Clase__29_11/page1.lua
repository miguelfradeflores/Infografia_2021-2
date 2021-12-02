local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local cw = display.actualContentWidth
local ch = display.actualContentHeight

local background
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local controlador = true
 
function setContralador( e )
    controlador = true
    print( "Accion completada" )
end

local estados = {
    {x=0,y=0, xScale=1.5, yScale=3, anchorX=0, anchorY=0, time = 2000, onComplete = setContralador},
    {x=0,y=0, xScale=3, yScale=3, anchorX=0.67, anchorY=0, time = 500, onComplete = setContralador},
    {x=0,y=0, xScale=3.7, yScale=3, anchorX=0, anchorY=0.33, time = 500, onComplete = setContralador }
}

local estados2 = {
    {x=0,y=0, width=cw*1.5, height=ch*3, anchorX=0, anchorY=0, time = 2000},
    {x=0,y=0, width=cw*3, height=ch*3, anchorX=0.67, anchorY=0, time = 500},
    {x=0,y=0, width=cw*3, height=ch*3, anchorX=0.67, anchorY=0, time = 500},
}

local cuadro = 0


function setContralador( e )
    controlador = true
    print( "Accion completada" )
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    background = display.newImageRect(  sceneGroup, "spiderman2.jpg", cw, ch )
    background.x = cw/2; background.y = ch/2
    -- background.xScale = background.xScale * 3.7; 
    -- background.yScale = background.yScale * 3
    -- background.anchorX = 0
    -- background.anchorY = 0.33

    -- -- background.width = 3036; background.height = ch*3
    -- background.x = 0; background.y=0

    print( background.width, background.height )

    -- background.x = 0; background.y = 0

    function cambiar_cuadro( e )

        if e.phase == "ended" then

            if controlador == true then
                cuadro = cuadro +1
                controlador = false
             --   transition.cancel()
                transition.to( background,estados[cuadro])
                print( "touch" )
            end
        end
        return true
    end


    background:addEventListener( "touch", cambiar_cuadro )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
      --  transition.to( background, {time = 2000, x=0, y=0, xScale = 1.5, yScale=3, anchorX=0, anchorY=0}  )

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