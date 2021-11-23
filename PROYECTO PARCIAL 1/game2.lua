local composer = require( "composer" )
local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight

local birdTable, birdSheet

local grupoFondo = display.newGroup()
local grupoMedio = display.newGroup()
local grupoDelantero = display.newGroup()


local stage1, press_start , press_start_white, reticle, shotgun, flash

local bullets, par



local duckSound = audio.loadSound("soundtrack/duck.mp3")
local blastSound = audio.loadSound("soundtrack/blast.mp3")
local fallSound = audio.loadSound("soundtrack/falling.mp3")
local laughSound = audio.loadSound("soundtrack/laugh.mp3")
local winSound = audio.loadSound("soundtrack/captured.mp3")

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )


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

birdTable = { 
  width = 40,
  height = 37,
  numFrames = 24, 
  sheetContentWidth = 240,
  sheetContentHeight = 148 
}

birdSheet = graphics.newImageSheet( "sprites/duck_blue_mirror.png", birdTable )


local birdData = {
  {
    name = "fly",
    frames = { 1,2,3,1,2,3,1,2,3},
    time = 1500, -- in milliseconds
    loopDirection = "forward",
    loopCount = 20
   },
     {
    name = "flyInvert",
    frames = { 4,5,6,4,5,6,4,5,6},
    time = 1500, -- in milliseconds
    loopDirection = "forward",
    loopCount = 20
   },
   {
    name = "flyAway",
    frames = { 7,8,9},
    time = 1500, -- in milliseconds
    loopDirection = "forward",
    loopCount = 3
   }
   
}


local deathTable, deathSheet

deathTable = { 
  width = 40,
  height = 37,
  numFrames = 24, 
  sheetContentWidth = 240,
  sheetContentHeight = 148 
  }

deathSheet = graphics.newImageSheet( "sprites/duck_blue_mirror.png", deathTable )


local deathData = {
    {
    name = "death",
    frames = { 20,23 },
    time = 1500, -- in milliseconds
    loopDirection = "forward",
    loopCount = 8
   }
}


function mAngle( sgx, sgy )
  m_ab = ( 363 - sgy ) / ( 360 - sgx ) 

  angle = math.deg ( math.atan( m_ab ) )
  print(angle)
  if angle < 0 then
    return  angle
  else
    return (-180 + angle)
  end
end


local function nextScreen (event)
composer.gotoScene( "game",{
            time = "200",
            params = {
                ducks = killCounter
            }
            } )
end


local function fail(event)   
       audio.play(laughSound) 
      lostDuck=display.newImage("sprites/laugh.png" )
      grupoMedio:insert ( lostDuck )
      lostDuck.x = cw/2
      lostDuck.y = ch/8*5
      lostDuck:scale( 1.5, 1.5 )
      transition.to(lostDuck,{ delay = 1000, alpha = 1})
      timer.cancelAll()
      transition.cancel()
      timer.performWithDelay( 3000, nextScreen )
end


local function onTarget(event)
    audio.play(winSound)
    cathDuck=display.newImage("sprites/kill.png" )
    grupoMedio: insert ( cathDuck )
    cathDuck.x = reticle.x
    cathDuck.y = ch/8*5
    cathDuck:scale( 1.5, 1.5 )
    transition.to(cathDuck,{ delay = 1000, alpha = 1})
    timer.cancelAll()
    transition.cancel()
    killCounter = killCounter + 1
    print(killCounter)
    timer.performWithDelay( 1000, nextScreen )
end


function fire( event )
  audio.play(blastSound) 
  transition.to(flash, {alpha =1, iterations =1, time=400}) 
    transition.to(flash, {alpha =0, iterations =1, time=100, delay=400})
    if par == true and bullets == 3 then
      bullets = 2
      bullet = display.newImageRect(  "background/bullet" .. bullets .. ".png", cw, ch )
      bullet.x = cw/2
      bullet.y = ch/2
      par = false
    elseif par == true and bullets == 2 then
      bullets = 1
      bullet = display.newImageRect(  "background/bullet" .. bullets .. ".png", cw, ch )
      bullet.x = cw/2
      bullet.y = ch/2
      par = false
    elseif par == true and bullets == 1 then
      bullets = 0
      bullet = display.newImageRect(  "background/bullet" .. bullets .. ".png", cw, ch )
      bullet.x = cw/2
      bullet.y = ch/2
      par = false
    elseif par == true and bullets <=0 then
      bullets = 0
      bullet = display.newImageRect(  "background/bullet" .. bullets .. ".png", cw, ch )
      bullet.x = cw/2
      bullet.y = ch/2
      par = false
      timer.performWithDelay( 500, fail )
    else
      par = true

    end
end

function moveReticle( event )
  if event.phase == "began" then
    reticle:addEventListener( "tap", fire )
    
  elseif event.phase == "moved" then
    print( "Me siguen tocando" , event.x, event.y)
    reticle.x = event.x
    if event.y <= ch/4*3 then
      reticle.y = event.y
    else
      reticle.y = ch/4*3 + 10
    end
    shotgun.rotation = mAngle(reticle.x,reticle.y)
  elseif event.phase == "ended" or event.phase == "cancelled" then
    print( 'Ya no me estan tocando' )
  end
  return true
end

local function flightPath(event)
  birdSprite:setSequence("flyAway")
  birdSprite:play()
   timer.performWithDelay( 3000, fail )
end

local function birdDeath(event)
  print(reticle.x,reticle.y,birdSprite,birdSprite.y)

  if (reticle.x-60)<= birdSprite.x and birdSprite.x <= (60 + reticle.x)  and (reticle.y-60) <= birdSprite.y and birdSprite.y <= (60 + reticle.y) then
    transition.cancel()
    timer.cancelAll()
    audio.pause(duckSound)
    audio.pause(blastSound)
    birdSprite:pause()
    audio.play(blastSound) 
    audio.play(fallSound)
    transition.to(flash, {alpha =1, iterations =1, time=400}) 
    transition.to(flash, {alpha =0, iterations =1, time=100, delay=400})
    transition.to(birdSprite, {alpha=0})


    deathSprite = display.newSprite (deathSheet, deathData)
    deathSprite:setSequence("death")
    deathSprite.x = event.x
    deathSprite.y = event.y
    deathSprite:scale( 1.2, 1.2 )
    deathSprite:play()
    transition.to(deathSprite,{ y=ch*3/4, time = 2000, delay = 1000, alpha = 0.01})
    
    
    physics.addBody( deathSprite )

    timer.performWithDelay( 3000, onTarget )
   end

   return true
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    composer.removeScene("game")
    timer.cancelAll()
    transition.cancel()
    bullets = 3
    par = false

    if killCounter >= 11 then
      audio.pause(duckSound)
      audio.pause(blastSound)
      audio.pause(winSound)
      audio.pause(laughSound)
      composer.gotoScene( "congratulations")
    end

    sky = display.newImageRect( "background/bg_back.png", cw, ch )
    sky.x = cw/2
    sky.y = ch/2
    sceneGroup:insert( sky )
    grupoFondo:insert( sky )

    trees = display.newImageRect( "background/bg_mid.png", cw, ch )
    trees.x = cw/2
    trees.y = ch/2
    sceneGroup:insert( trees )
    grupoMedio:insert( trees )

    field = display.newImageRect(  "background/bg_front.png", cw, ch )
    field.x = cw/2
    field.y = ch/2
    sceneGroup:insert( field )
    grupoDelantero:insert( field )


    reticle = display.newImageRect( "sprites/reticle.png", 40,55)
    reticle.x = cw/4*3
    reticle.y = cw/4
    sceneGroup:insert( reticle )
    grupoDelantero:insert( reticle )

    score = display.newImageRect(  "background/score" .. killCounter .. ".png", cw, ch )
    score.x = cw/2
    score.y = ch/2
    sceneGroup:insert( score )
    grupoDelantero:insert( score )

    bullet = display.newImageRect(  "background/bullet" .. bullets .. ".png", cw, ch )
    bullet.x = cw/2
    bullet.y = ch/2
    sceneGroup:insert( bullet )
    grupoDelantero:insert( bullet )


    shotgun = display.newImageRect( grupoDelantero, "sprites/shotgun.png", 40,55)
    shotgun.x = cw/4*3
    shotgun.y = ch
    shotgun.anchorX = 0.25
    shotgun.anchorY = 0.5
    shotgun.xScale = 4.7*0.8
    shotgun.yScale = 0.8
    shotgun.rotation = -90
    sceneGroup:insert( shotgun )
    grupoDelantero:insert( shotgun )

    reticle:addEventListener( "touch", moveReticle )

    birdSprite = display.newSprite (birdSheet, birdData)
    sceneGroup:insert( birdSprite ) 
    grupoMedio:insert( birdSprite )
    birdSprite:setSequence("fly")
    birdSprite.x = cw/2
    birdSprite.y = ch*3/4
    birdSprite:scale( 1.2, 1.2)
    transition.to(birdSprite, {x= math.random(0, cw), time=2500})
    transition.to(birdSprite, {y=math.random(0, ch*3/4), x= math.random(0, cw), delay= 2500, time=2500})
    transition.to(birdSprite, {y=math.random(0, ch*3/4), x= math.random(0, cw), delay= 3900, time=2500})
    transition.to(birdSprite, {y=-30, delay=5500, time = 3000})

    flash = display.newImageRect( "background/bg_white.png", cw, ch )
    flash.x = cw/2
    flash.y = ch/2
    flash.alpha = 0
    sceneGroup:insert( flash )
    grupoDelantero:insert( flash )
  
    timer.performWithDelay( 6000, flightPath )

    physics.addBody( birdSprite, "dynamic")  

end
 
 
-- show()
function scene:show( event )
local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        birdSprite:play()
        audio.play(duckSound,{loops=3})
        birdSprite:addEventListener( "tap", birdDeath )
        
    end

end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then      
          timer.cancelAll()
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