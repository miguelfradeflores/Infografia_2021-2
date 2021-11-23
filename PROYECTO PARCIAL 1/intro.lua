local composer = require( "composer" )
local scene = composer.newScene()
composer.removeScene("home")

local cw = display.contentWidth
local ch = display.contentHeight
 
print(cw, ch)

local dogTable , dogSheet


killCounter = 0
local grupoFondo = display.newGroup()
local grupoMedio = display.newGroup()
local grupoDelantero = display.newGroup()

local stage1, press_start , press_start_white


local startaudio = audio.loadSound( "soundtrack/start_game.mp3" )
local bark = audio.loadSound("soundtrack/bark.mp3")

dogTable = { 
  width = 60,
  height = 53,
  numFrames = 30, 
  sheetContentWidth = 375,
  sheetContentHeight = 267
}

dogSheet = graphics.newImageSheet( "sprites/sprites.png", dogTable )

local dogData = {
  {
    name = "walk",
    frames = { 1,2,3,4,1,2,3,4,1,2,3,4,5,7,8,9},
    time = 4000, -- in milliseconds
    loopDirection = "forward",
    loopCount = 1
   }
}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local function nextScreen ( event )
  composer.gotoScene( "game" , {
    effect = "fade",
    time = 500,
    params = {
            kills = 0
    }
    })
end


-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    composer.removeScene("congratulations")
    timer.cancelAll()
    transition.cancel()

    local fondo = display.newImageRect( sceneGroup, "background/bckgd_large.png", cw, ch )
    fondo.x = cw/2
    fondo.y = ch/2

    dogSprite = display.newSprite ( sceneGroup, dogSheet, dogData)
    dogSprite:setSequence("walk")
    dogSprite.x = 0
    dogSprite.y = ch*3/4
    dogSprite:scale( 1.5, 1.5 )
    transition.to(dogSprite, {x=ch/2 + ch/9*2, time=3600})
    transition.to(dogSprite, {y=170, time=1600, delay= 3600})
    transition.to(dogSprite, {alpha=0, delay=4000})
    transition.to(dogSprite, {alpha=0, delay=4000})
   
    stage1 = display.newImage( sceneGroup, "sprites/stage.png", cw/2, ch/2 )
    stage1.anchorX = 0.5
    stage1.anchorY = 0.5
    stage1.xScale = 0.7
    stage1.yScale = 0.7
    stage1.x = cw/2
    stage1.y = ch/8*3

    transition.to(stage1, {alpha =0.2, iterations =5, time=1000, size =40})
    transition.to(stage1, {alpha = 0, time=500, delay=5000})

end
 
 

function scene:show( event )
local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        dogSprite:play()
        audio.play( startaudio )
        timer.performWithDelay( 6000, nextScreen )

    end

end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then      
        audio.pause(startaudio)
        audio.setVolume(0.6)
        audio.play( bark,{loops=2} )
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