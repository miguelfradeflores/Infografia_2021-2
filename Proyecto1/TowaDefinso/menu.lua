local composer = require( "composer" )
composer.recycleOnSceneChange = true

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Function to handle button events
local widget = require( "widget" )

soundBtn = nil


local function handleButtonEvent( event )
 
	if ( "began" == event.phase ) then
		audio.play( clickPlaySound, { channel=2, loops=0 } )
        audio.setVolume( 4, { channel=2 } )
	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
        audio.stop( 1 )
		gotoGame()
    end
end
  

function handleButtonSoundEvent( event )
 
	if ( "began" == event.phase ) then
        if(soundOn)then
            print(currScene);
            audio.stop( 1 )
            soundOn = false
        else
            if (currScene == "menu" and soundOn == false) then
                audio.play( menuSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.04, { channel=1 } )
    soundOn = true
            elseif (currScene == "game" and soundOn == false) then
                audio.play( gameSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.04, { channel=1 } )
    soundOn =true
            elseif(currScene == "perdiste" and soundOn == false) then
                audio.play( looseSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.1, { channel=1 } )
    soundOn = true

elseif(currScene == "win" and soundOn == false) then
    audio.play( winSound, { channel=1, loops=-1 } )
audio.setVolume( 0.08, { channel=1 } )
soundOn = true
            end
            
        end

	elseif ( "ended" == event.phase or "cancelled" == event.phase ) then
        if(soundOn)then
            soundBtn.alpha = 1

        else
            soundBtn.alpha = 0.5

        end

    end
end
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
    
        

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Create the widget
        

        local background = display.newRect(0,0, cw*4, ch*2)
background.fill = { type="image", filename="sprites/nebula.png" }
background:toBack()
sceneGroup:insert(background)


        local playBtn = widget.newButton(
            {
                width = 100,
                height = 80,
                id = "playBtn",
                --label = "Default",
                --shape = "circle",
                defaultFile = "sprites/play.png",
                overFile = "sprites/playPressed.png",
                onEvent = handleButtonEvent
            }
        )
 
-- Center the button
--button1.alpha = 0.5
playBtn.x = display.contentCenterX
playBtn.y = display.contentCenterY+20

local nameText = 
{
    text = "TOWA DEFINSO",
    x = display.contentCenterX,
	y = display.contentCenterY-60,
    font = native.systemFont,
    fontSize = 40,
    align = "center"
}
local nameText = display.newText(nameText )
nameText:setFillColor( 1, 1, 1 )
-- Change the button's label text
sceneGroup:insert(playBtn)
sceneGroup:insert(nameText)

soundBtn = widget.newButton(
    {
        width = wDiv,
        height = hDiv,
        id = "SoundBtn",
        --label = "Default",
        --shape = "circle",
        defaultFile = "sprites/soundOn.png",
        overFile = "sprites/soundOn.png",
        onEvent = handleButtonSoundEvent
    }
)
soundBtn.anchorX = 0
soundBtn.anchorY = 0

soundBtn.x = wDiv*8
soundBtn.y = hDiv*0
 
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