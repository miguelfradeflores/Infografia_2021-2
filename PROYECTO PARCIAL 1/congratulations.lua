

local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight

local grupoFondo = display.newGroup( )
local grupoMedio = display.newGroup()
local grupoDelantero = display.newGroup()

local menuSound = audio.loadSound( "soundtrack/menu.mp3" )
local title, button

print( cw,ch )



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local function nextScreen (event)
  composer.gotoScene( "intro" )
end

-- create()
function scene:create( event )

	composer.removeScene("game2")
    composer.removeScene("game")
    timer.cancelAll()
    transition.cancel()

 
    local sceneGroup = self.view
    local fondo = display.newRect( sceneGroup, 0, 0, cw, ch )
	fondo:setFillColor( 0 ,0, 0 )
	fondo.anchorX = 0
	fondo.anchorY = 0
	grupoDelantero:insert(fondo )

	title = display.newImage( sceneGroup, "background/intro.png", cw/2, ch/2 )
	title.anchorX = 0.5
	title.anchorY = 0.5
	title.xScale = 0.25
	title.yScale = 0.25
	title.x = cw/2
	title.y = ch/8*3
	grupoDelantero:insert(title )

	button = display.newImageRect(  "background/congratulations.png", cw, ch )
    button.x = cw/2
    button.y = ch/2
    sceneGroup:insert( button )
    grupoDelantero:insert( button )
	button:addEventListener( "touch", nextScreen )
end
 
 
-- show()
function scene:show( event )
	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
    	audio.setVolume(0.1)
        audio.play(menuSound)
    end
end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then      
        audio.pause(menuSound)  
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



