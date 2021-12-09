

local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight

local backGroup = display.newGroup( )
local midGroup = display.newGroup()
local frontGroup = display.newGroup()

local ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8

local menuSound = audio.loadSound( "soundtrack/06 SEASON OF DESPAIR.mp3" )
local buttonEffect = audio.loadSound( "soundtrack/HS_SE_001.wav" )

local title, button, title2

local student = 16

local sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8

local options = {
	width = 88.125,
	height = 88.125,
	numFrames =256
}

print( cw,ch )

local personaje_spritesheet = graphics.newImageSheet( "sprites/sprites8Bits.png",  options )
character=0
life=2

local sequence = {
	{
		name="init1",
		frames = {16*3 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie1",
		frames = {16*3 + 4,16*3 + 4,16*3 + 4,16*3 + 4,16*3 + 4,16*3 + 4,16*3 + 4,16*3 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init2",
		frames = {16*15 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie2",
		frames = {16*15 + 4,16*15 + 4,16*15 + 4,16*15 + 4,16*15 + 4,16*15 + 4,16*15 + 4,16*15 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init3",
		frames = {16*12 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie3",
		frames = {16*12 + 4,16*12 + 4,16*12 + 4,16*12 + 4,16*12 + 4,16*12 + 4,16*12 + 4,16*12 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init4",
		frames = {16 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie4",
		frames = {16 + 4,16 + 4,16 + 4,16 + 4,16 + 4,16 + 4,16 + 4,16 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init5",
		frames = {16*9 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie5",
		frames = {16*9  + 4,16*9  + 4,16*9  + 4,16*9  + 4,16*9  + 4,16*9  + 4,16*9  + 4,16*9  + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init6",
		frames = {16*5 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie6",
		frames = {16*5  + 4,16*5  + 4,16*5  + 4,16*5  + 4,16*5  + 4,16*5  + 4,16*5  + 4,16*5  + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
		{
		name="init7",
		frames = {0 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie7",
		frames = {0 + 4,0 + 4,0 + 4,0 + 4,0 + 4,0 + 4,0 + 4,0 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="init8",
		frames = {16*8 + 8},
		loopCount = 0,
		time = 2000, 
		sheet = personaje_spritesheet
	},
	{
		name="de_pie8",
		frames = {16*8 + 4,16*8 + 4,16*8 + 4,16*8 + 4,16*8 + 4,16*8 + 4,16*8 + 4,16*8 + 8},
		loopCount = 40,
		time = 2000, 
		sheet = personaje_spritesheet
	}
}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function nextScreen (event)
  composer.gotoScene( "level1" , {
    effect = "fade",
    time = 500,
    params = {
            toSelect = character,
            lifeCounter = life
    }
    })
end

local function nextScreen (event)
    composer.gotoScene( "level1" )
end

local function effects (e)
    audio.stop(10)
    audio.play(buttonEffect,{channel=9})
    timer.cancelAll()
    transition.cancel()
    title2.alpha = 1
    transition.to(sp1, {alpha =0, iterations =10,time=200})
    transition.to(title2, {alpha =0, iterations =10,time=200})
    timer.performWithDelay( 2000, nextScreen )
end

local function nextScreen1 (event)
   character=1
   timer.performWithDelay( 500, effects )
end

local function nextScreen2 (event)
	character=2
  	timer.performWithDelay( 500, effects )
end

local function nextScreen3 (event)
	character=3
  	timer.performWithDelay( 500, effects )
end

local function nextScreen4 (event)
	character=4
  	timer.performWithDelay( 500, effects )
end

local function nextScreen5 (event)
	character=5
	timer.performWithDelay( 500, effects )
end

local function nextScreen6 (event)
	character=6
	timer.performWithDelay( 500, effects )
end

local function nextScreen7 (event)
	character=7
	timer.performWithDelay( 500, nextScreen )
end

local function nextScreen8 (event)
	character=8
	timer.performWithDelay( 500, effects )
end

-- create()
function scene:create( event )

	composer.removeScene("congratulations")
    timer.cancelAll()
    transition.cancel()
 
    local sceneGroup = self.view
    ch1 = display.newRect( sceneGroup, 0, 0, cw/4, ch/2)
	ch1:setFillColor( 0 ,0.99, 0 )

	ch1.anchorX = 0
	ch1.anchorY = 0
	backGroup:insert(ch1)

	ch2 = display.newRect( sceneGroup, cw/4, 0, cw/4, ch/2)
	ch2:setFillColor( 0.67 ,0.09, 0.57 )
	ch2.anchorX = 0
	ch2.anchorY = 0
	backGroup:insert(ch2)

	ch3 = display.newRect( sceneGroup, cw/2, 0, cw/4, ch/2)
	ch3:setFillColor( 0.03 ,0.24, 0.44 )
	ch3.anchorX = 0
	ch3.anchorY = 0
	backGroup:insert(ch3)

	ch4 = display.newRect( sceneGroup, cw/4*3, 0, cw/4, ch/2)
	ch4:setFillColor( 0.53 ,0.10, 0.57 )
	ch4.anchorX = 0
	ch4.anchorY = 0
	backGroup:insert(ch4)

	ch5 = display.newRect( sceneGroup, 0, ch/2, cw/4, ch/2)
	ch5:setFillColor( 1 ,0, 0)
	ch5.anchorX = 0
	ch5.anchorY = 0
	backGroup:insert(ch5)

	ch6 = display.newRect( sceneGroup, cw/4, ch/2, cw/4, ch/2)
	ch6:setFillColor( 1 ,1, 1 )
	ch6.anchorX = 0
	ch6.anchorY = 0
	backGroup:insert(ch6)

	ch7 = display.newRect( sceneGroup, cw/2, ch/2, cw/4, ch/2)
	ch7:setFillColor( 0.01 ,0.40, 0.55 )
	ch7.anchorX = 0
	ch7.anchorY = 0
	backGroup:insert(ch7)

	ch8 = display.newRect( sceneGroup, cw/4*3, ch/2, cw/4, ch/2)
	ch8:setFillColor( 0.73 ,0.59, 0)
	ch8.anchorX = 0
	ch8.anchorY = 0
	backGroup:insert(ch8)

	title = display.newImageRect( sceneGroup, "backgrounds/select_title_v3.png", cw, ch )
	title.anchorX = 0
	title.anchorY = 0
	backGroup:insert(title)

	title2 = display.newImageRect( sceneGroup, "backgrounds/select_title.png", cw, ch )
	title2.anchorX = 0
	title2.anchorY = 0
	backGroup:insert(title2)

	sp1 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch1"} )
	sp1.x = cw/8
	sp1.y = ch/4
	sp1.xScale = 0.6; sp1.yScale = 0.6*23/16
	sp1:setSequence( "de_pie1" )
	sp1:play()
	frontGroup:insert(sp1)

	sp2 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch2"} )
	sp2.x = cw/8*3
	sp2.y = ch/4
	sp2.xScale = 0.6; sp2.yScale = 0.6*23/16
	sp2:setSequence( "de_pie2" )
	sp2:play()
	frontGroup:insert(sp2)

	sp3 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch3"} )
	sp3.x = cw/8*5
	sp3.y = ch/4
	sp3.xScale = 0.6; sp3.yScale = 0.6*23/16
	sp3:setSequence( "de_pie3" )
	sp3:play()
	frontGroup:insert(sp3)

	sp4 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch4"} )
	sp4.x = cw/8*7
	sp4.y = ch/4
	sp4.xScale = 0.6; sp4.yScale = 0.6*23/16
	sp4:setSequence( "de_pie4" )
	sp4:play()
	frontGroup:insert(sp4)

	sp5 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch5"} )
	sp5.x = cw/8
	sp5.y = ch/4*3
	sp5.xScale = 0.6; sp5.yScale = 0.6*23/16
	sp5:setSequence( "de_pie5" )
	sp5:play()
	frontGroup:insert(sp5)

	sp6 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch6"} )
	sp6.x = cw/8*3
	sp6.y = ch/4*3
	sp6.xScale = 0.6; sp6.yScale = 0.6*23/16
	sp6:setSequence( "de_pie6" )
	sp6:play()
	frontGroup:insert(sp6)

	sp7 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch7"} )
	sp7.x = cw/8*5
	sp7.y = ch/4*3
	sp7.xScale = 0.6; sp7.yScale = 0.6*23/16
	sp7:setSequence( "de_pie7" )
	sp7:play()
	frontGroup:insert(sp7)

	sp8 = display.newSprite(sceneGroup, personaje_spritesheet, sequence,{name="ch8"} )
	sp8.x = cw/8*7
	sp8.y = ch/4*3
	sp8.xScale = 0.6; sp8.yScale = 0.6*23/16
	sp8:setSequence( "de_pie8" )
	sp8:play()
	frontGroup:insert(sp8)
	life=2
	sp1:addEventListener( "touch", nextScreen1 )
	sp2:addEventListener( "touch", nextScreen2 )

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
        frontGroup:removeSelf()  
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