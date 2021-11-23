local composer = require( "composer" )
 
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local widget = require( "widget" )

display.setDefault("background", unpack(fondo))



local function handleButtonRetryEvent( event )
 
	if ( "began" == event.phase ) then
		audio.play( clickSound, { channel=2, loops=0 } )
        audio.setVolume( 4, { channel=2 } )
	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
		audio.stop( 1 )

		gotoGame()
        composer.removeScene( "perdiste" )

    end
end

local function handleButtonHomeEvent( event )
 
	if ( "began" == event.phase ) then
		audio.play( clickSound, { channel=2, loops=0 } )
        audio.setVolume( 4, { channel=2 } )
	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
		audio.stop( 1 )

		gotoMenu()
        composer.removeScene( "perdiste" )

    end
end

local background = display.newRect(0,0, cw*4, ch*2)
background.fill = { type="image", filename="sprites/nebula.png" }
background:toBack()


local looseText = 
{
    text = "PERDISTE",
    x = display.contentCenterX,
	y = display.contentCenterY,
    font = native.systemFont,
    fontSize = 40,
    align = "center"
}
local looseText = display.newText(looseText )
looseText:setFillColor( 1, 1, 1 )

local retryBtn = widget.newButton(
    {
        width = wDiv,
        height = hDiv,
        id = "retryBtn",
        --label = "Default",
        --shape = "circle",
        defaultFile = "sprites/restart.png",
        overFile = "sprites/restartPressed.png",
        onEvent = handleButtonRetryEvent
    }
)

-- Center the button
--button1.alpha = 0.5
retryBtn.x = display.contentCenterX-30
retryBtn.y = display.contentCenterY +50
 

local homeBtn = widget.newButton(
    {
        width = wDiv,
        height = hDiv,
        id = "homeBtn",
        --label = "Default",
        --shape = "circle",
        defaultFile = "sprites/home.png",
        overFile = "sprites/homePressed.png",
        onEvent = handleButtonHomeEvent
    }
)

-- Center the button
--button1.alpha = 0.5
homeBtn.x = display.contentCenterX+30
homeBtn.y = display.contentCenterY +50
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    currScene = composer.getSceneName( "current" )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.removeScene( "game" )

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        composer.removeHidden()




sceneGroup:insert(background)
sceneGroup:insert(looseText)
sceneGroup:insert(retryBtn)
sceneGroup:insert(homeBtn)

 
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