local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight

local backGroup = display.newGroup( )
local midGroup = display.newGroup()


local menuSound = audio.loadSound( "soundtrack/06 SEASON OF DESPAIR.mp3" )
local buttonEffect = audio.loadSound( "soundtrack/HS_SE_001.wav" )
local title, button, titleRed, fondo, fondo2

print( cw,ch )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function nextScreen (event)
    composer.gotoScene( "selectCh" )
end

local function effects (e)
    audio.stop(10)
    audio.play(buttonEffect,{channel=9})
    timer.cancelAll()
    transition.cancel()
    title.alpha = 0
    titleRed.alpha = 1
    transition.to(titleRed, {alpha =0, iterations =10,time=200})
    timer.performWithDelay( 2000, nextScreen )
end




-- create()
function scene:create( event )

    timer.cancelAll()
    transition.cancel()
 
    local sceneGroup = self.view
    fondo = display.newImageRect( sceneGroup, "backgrounds/splash.png", cw, ch )
	fondo.anchorX = 0
	fondo.anchorY = 0
	backGroup:insert(fondo)

    
    title = display.newImageRect( sceneGroup, "backgrounds/title.png", cw, ch )
    title.x = cw
    title.y = ch
    backGroup:insert(title)

    titleRed = display.newImageRect( sceneGroup, "backgrounds/title_red.png", cw, ch )
    titleRed.x = cw/2
    titleRed.y = ch/2
    titleRed.alpha = 0
    backGroup:insert(titleRed)

    fondo2 = display.newImageRect( sceneGroup, "backgrounds/splash_front.png", cw, ch )
    fondo2.anchorX = 0
    fondo2.anchorY = 0
    backGroup:insert(fondo2)

    button = display.newRect( sceneGroup, 0, 0, cw, ch )
    button.anchorX = 0
    button.anchorY = 0
    button.alpha = 0.1
    midGroup:insert(button)

    transition.to(title, { x= cw/2, y=ch/2,  time=4000})
    transition.to(titleRed, {alpha =1, iterations =1, time=5000, delay=4000})
    transition.to(title, {alpha =0, time=5000, delay=4000})
    button:addEventListener( "touch", effects )
end
 
 
-- show()
function scene:show( event )
	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
    	audio.setVolume( 0.1 , { channel = 10 } )
        audio.setVolume( 0.5 , { channel = 9 } )
        audio.play(menuSound,{channel=10})
   
    end
end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then      
        audio.stop(10)
        backGroup:removeSelf()
        midGroup:removeSelf()  
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