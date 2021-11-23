local composer = require( "composer" )
 
local scene= composer.newScene()
local cw=display.actualContentWidth
local ch=display.contentHeight

local paddingX=cw/30
local paddingY=ch/15
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupoJuego, grupoStats, grupoDisparo, grupoFrontEnd
local pistol, fondo, antena, powerButton, pauseButton, blurry, lifebarMain, enemyFrame, line, menuButton, surloeAnimated
local initialAntenaVida=0
local enemiesForStage=0
local enemiesLeft=0
local backgroundLevelMusic, laserBang
local enemiesLeftText, lifeText, lifebar, pauseText, gameOverDrawing, levelCompleteDrawing, levelCompleteDrawingAnimated
local enemies={}
local explosion
local vertexLoadSquare,loadSquare, vertexNew
local changeScale



function toMenu(self,e)
    audio.stop()
    if e.phase == "ended" then
        composer.gotoScene( "menu",{effect="fade",time=1000})
    end
    return true
end

local metasiteOptions={
        width=638,
        height=600,
        numFrames=6
}
local spriteSheet3=graphics.newImageSheet("Metasite/metasiteSpritesheet.png",metasiteOptions)

local sequenceMetasite={
         {
            name = "sequenceFlight",
            start = 1,
            count = 6,
            time = 600,
            loopCount = 0,
            loopDirection = "forward"
        }

    }


function spawnEnemy(e)
    local paramets=e.source.paramet
    local nombre=e.count
    enemies[nombre]=display.newSprite(paramets.group,spriteSheet3,sequenceMetasite)
    enemies[nombre].xScale=0.1;enemies[nombre].yScale=0.1
    enemies[nombre].x = cw; enemies[nombre].y = math.random( 0, ch)
    enemies[nombre].name = "enemy: " .. nombre
    enemies[nombre].touch = paramets.listener
    enemies[nombre]:addEventListener( "touch", enemies[nombre] )
    enemies[nombre]:play()
    transition.to(enemies[nombre], {time= math.random(1000,5000), x=antena.x+50,y=antena.y,onComplete=damageAntena})

end

function destruir(self, e)
    if e.phase == "ended" then
        shootLine(self.x,self.y,"enemy")
        powerButton.filled=powerButton.filled+math.random(3,5) 
        checkButtonPower()
        self:pause()
        transition.cancel(self)
        self:removeSelf( )
        self = nil
        enemiesLeft=enemiesLeft-1
        enemiesLeftText.text="Enemies: "..enemiesLeft
        checkAntenaLife()
    end
return true
end

function shootLine(objectiveX,objectiveY,mode)
    audio.play(laserBang)
    line= display.newLine(grupoDisparo,pistol.x,pistol.y,objectiveX,objectiveY)
    if mode=="idle" then 
        line.strokeWidth=2
        line:setStrokeColor( 1,1, 1)
    end
    if mode=="enemy" then 
        line.strokeWidth=5
        line:setStrokeColor( 0,255/255, 255/255)
    end
    line:toBack()
     transition.to(line,{alpha=0,time=200})    
end

function checkButtonPower()
    if powerButton.filled>=25 then 
        powerButton.alpha=0.25
        vertexNew=scaleTheLoadSquare(vertexLoadSquare,1.25,1.25) 
    end
    if powerButton.filled>=50 then 
        powerButton.alpha=0.5
        vertexNew=scaleTheLoadSquare(vertexLoadSquare,1.5,1.5) 
    end
    if powerButton.filled>=100 then 
        powerButton.alpha=1
        vertexNew=scaleTheLoadSquare(vertexLoadSquare,2,2)
    end
    createNewSquare(vertexNew,powerButton.filled)
end


function createNewSquare(vertex,levelFilled)
    if levelFilled<100 then
        display.remove(loadSquare)
        loadSquare=display.newPolygon(grupoStats,0,0,vertexNew)
        loadSquare.isVisible=true
        loadSquare:translate(paddingX*7,paddingY*13)
        loadSquare.anchorX=1
    end
    if levelFilled>=100 then
        loadSquare:setFillColor(0,255/255,255/255)
    end
    if levelFilled>50 and levelFilled<100 then
        loadSquare:setFillColor(171/255,219/255,227/255)
    end
    if levelFilled>25 and levelFilled<=50 then
        loadSquare:setFillColor(118/255,181/255,197/255)
    end
    if levelFilled<=25 then
        loadSquare:setFillColor(21/255,76/255,121/255)
    end
end

function powerEliminate()
    numEnemiesToEliminate=5
    for i=grupoJuego.numChildren, 1,-1 do
        if grupoJuego[i] ~= nil and numEnemiesToEliminate>=0 then
            grupoJuego[i]:pause()
            transition.cancel(grupoJuego[i])
            grupoJuego[i]:removeSelf()
            grupoJuego[i] = nil
            enemiesLeft=enemiesLeft-1
            enemiesLeftText.text="Enemies: "..enemiesLeft
            numEnemiesToEliminate=numEnemiesToEliminate-1
        end
    end
    numEnemiesToEliminate=5
    checkAntenaLife()
end

function damageAntena(self)
    self:removeSelf()
    self = nil
    enemiesLeft=enemiesLeft-1
    antena.vida=antena.vida-math.random(3,6)
    lifebar.width=math.floor((antena.vida*100)/initialAntenaVida)
    enemiesLeftText.text="Enemies: "..enemiesLeft
    lifeText.text="Life: "..antena.vida
    checkAntenaLife()
    return true
end


function scaleTheLoadSquare(vertexI,valx,valy)
    vertexF={}
    for i,v in ipairs( vertexI ) do 
        if i%2==0 then 
            vertexF[i] = v*valy
        else
            vertexF[i] = v*valx
        end
    end
    return vertexF
end

function checkAntenaLife()
    if antena.vida<=math.floor(initialAntenaVida*0.75) then
        lifebar:setFillColor(255/255, 255/255, 0)
    end
    if antena.vida<=math.floor(initialAntenaVida*0.50)then
        lifebar:setFillColor(255/255, 165/255, 0)
    end
    if antena.vida<=math.floor(initialAntenaVida*0.25) then
        lifebar:setFillColor(255/255, 0/255, 0)
    end

    if antena.vida>0 and enemiesLeft==0 then 
        endGame(true)
    end
    if antena.vida<=0 then
        antena.vida=0
        lifeText.text="Life: "..antena.vida
        endGame(false)
    end

end


function power(e)
    if e.phase=="ended" then
        if powerButton.filled>=100 and powerButton.alpha==1 then
            powerEliminate()
            display.remove(loadSquare)
            transition.to(explosion,{alpha=1,xScale=2,yScale=2,time=800,onComplete=redoExplosion})
            powerButton.filled=0
            powerButton.alpha=0.2
            vertexNew=vertexLoadSquare
            createNewSquare(vertexLoadSquare,powerButton.filled)
        end
    end
end

function redoExplosion()
    explosion.alpha=0
    explosion.xScale=0.1
    explosion.yScale=0.1
end


function limpiar()
    for i=grupoJuego.numChildren, 1,-1 do
        if grupoJuego[i] ~= nil then
            grupoJuego[i]:pause()
            transition.cancel(grupoJuego[i])
            grupoJuego[i]:removeSelf()
            grupoJuego[i] = nil
        end
    end
    timer.cancel( "enemySpawner" )
end



function pauseGame(e)
    if e.phase=="ended" then
        pauseButton.isPaused=not pauseButton.isPaused
        if not(pauseButton.isPaused) then 
            visualPauseSwitch(false)
            eventPauseSwitch(false)
            for i=grupoJuego.numChildren, 1,-1 do
                if grupoJuego[i] ~= nil then
                    grupoJuego[i].touch=destruir
                    grupoJuego[i]:addEventListener( "touch", grupoJuego[i])
                    grupoJuego[i]:play()
                    transition.resume(grupoJuego[i])
                end
            end
        end
        if pauseButton.isPaused then 
           visualPauseSwitch(true)
           eventPauseSwitch(true)
            for i=grupoJuego.numChildren, 1,-1 do
                if grupoJuego[i] ~= nil then
                    grupoJuego[i].touch=nil
                    grupoJuego[i]:removeEventListener( "touch", grupoJuego[i])
                    grupoJuego[i]:pause()
                    transition.pause(grupoJuego[i])
                end
            end    
        end
    end
end


function eventPauseSwitch(switchBoolean)
    if switchBoolean then 
        audio.pause(backgroundLevelMusic)
        surloeAnimated:pause()
        transition.pause(pistol)
        powerButton:removeEventListener( "touch", power )
        fondo:removeEventListener( "touch", pointIt)
        timer.pause( "enemySpawner" )
    end
    if not(switchBoolean) then 
        audio.resume(backgroundLevelMusic)
        surloeAnimated:play()
        transition.resume(pistol)
        powerButton:addEventListener( "touch", power )
        fondo:addEventListener( "touch", pointIt)
        timer.resume( "enemySpawner")
    end
end


function visualPauseSwitch(switchBoolean)
    if switchBoolean then 
        switchVisibleStats(false)
        transition.to(blurry,{alpha=0.5,time=250})
        transition.to(pauseText,{alpha=1,time=250})
    end
    if not(switchBoolean) then 
        transition.to(blurry,{alpha=0,time=250})
        transition.to(pauseText,{alpha=0,time=250})
        switchVisibleStats(true)
    end
    switchMenuinPause(switchBoolean)
end

function switchMenuinPause(switchBoolean)
    menuButton:toFront()
    if switchBoolean then
        menuButton.alpha=1
        menuButton.x=paddingX*10
        menuButton.y=paddingY*6
        menuButton:addEventListener( "touch", menuButton)
    end
    if not(switchBoolean) then 
        menuButton.alpha=0
        menuButton.x=paddingX*17
        menuButton.y=paddingY*10
        menuButton:removeEventListener( "touch", menuButton)
    end
end


function iniciar(grupo)
    local tm=timer.performWithDelay( 750, spawnEnemy ,enemiesForStage,"enemySpawner")
    tm.paramet={group=grupo,listener=destruir}
end

function endGame(success)
    audio.pause(backgroundLevelMusic)
    surloeAnimated:pause()
    display.remove(grupoDisparo)
    grupoDisparo=nil
    fondo:removeEventListener( "touch", pointIt)
    display.remove(pauseButton)
    pauseButton=nil
    switchVisibleStats(false)
    blurry.alpha=0.5
    if success then
        levelCompleteDrawingAnimated:toFront()
        transition.to(levelCompleteDrawingAnimated,{alpha=1,time=500})
        levelCompleteDrawingAnimated:play()
    else
        limpiar()
        gameOverDrawing:toFront()
        transition.to(gameOverDrawing,{alpha=1,time=500})
    end
    menuButton:toFront()
    transition.to(menuButton,{alpha=1,time=500})
end


 function pointIt(e)
    if e.phase=="ended" then
        shootLine(e.x,e.y,"idle")
        mab=(e.y-(pistol.y))/(e.x-(pistol.x))
        mbc=(pistol.y-(pistol.y))/(cw-(pistol.x))
        convert=180/math.pi
        angA=(math.atan((mbc-mab)/(1+(mbc*mab))))*convert
        transition.to(pistol,{rotation=-angA,time=200})
    end
end

function switchVisibleStats(visible)
    explosion.isVisible=visible
    lifebarMain.isVisible=visible
    enemyFrame.isVisible=visible
    powerButton.isVisible=visible
    lifeText.isVisible=visible
    enemiesLeftText.isVisible=visible
    lifebar.isVisible=visible
    loadSquare.isVisible=visible
end




 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    initialAntenaVida=event.params.antenaVidaInicial
    enemiesForStage=event.params.numberOfEnemies
    enemiesLeft=enemiesForStage
    enemies={}
    vertexLoadSquare={paddingX*7,paddingY*7, paddingX*7, paddingY*6, paddingX*8, paddingY*6,paddingX*8, paddingY*7}
    changeScale=truev
    vertexNew=vertexLoadSquare
    backgroundLevelMusic=audio.loadStream( "audio/soundtrackNoMio.mp3")
    laserBang=audio.loadSound("audio/laserBang.mp3")
    audio.reserveChannels(1)
    audio.setVolume(0.2)
    audio.setVolume(1,{channel=1})

    grupoDisparo=display.newGroup()
    grupoStats= display.newGroup()
    grupoJuego = display.newGroup( )
    grupoFrontEnd=display.newGroup()

    fondo=display.newImageRect(sceneGroup,"inmovilesprites/fondo.png",cw,ch)
    fondo.anchorX=0; fondo.anchorY=0
    fondo:addEventListener( "touch", pointIt )

    local torre = display.newImageRect(sceneGroup,"inmovilesprites/torre.png",paddingX*10,paddingY*25)
    torre.anchorX=0
    torre.x=paddingX*0
    torre.y=paddingY*15

    antena = display.newImageRect(sceneGroup,"inmovilesprites/antena.png",paddingX*6,paddingY*7)
    antena.x=torre.x+paddingX*5
    antena.y=torre.y-paddingY*12.5
    antena.vida=initialAntenaVida

    gameOverDrawing=display.newImage(grupoFrontEnd,"inmovilesprites/gameover.png",paddingX*15,paddingY*7.5 )
    gameOverDrawing.xScale = 0.15; gameOverDrawing.yScale=0.15
    gameOverDrawing.alpha=0
    gameOverDrawing.anchorX=0.75

    levelCompleteDrawing=display.newImage(grupoFrontEnd,"Surloe/surloeP.png",paddingX*15,paddingY*7.5 )
    levelCompleteDrawing.xScale = 0.15; levelCompleteDrawing.yScale=0.15
    levelCompleteDrawing.alpha=0
    levelCompleteDrawing.anchorX=0.75

    menuButton=display.newImage(grupoFrontEnd,"inmovilesprites/botonMenu.png",paddingX*17,paddingY*10 )
    menuButton.xScale =0.10; menuButton.yScale=0.10
    menuButton.anchorX=1
    menuButton.anchorY=0
    menuButton.alpha=0
    menuButton.touch=toMenu
    menuButton:addEventListener( "touch", menuButton)  

    local surloeOptions={
        width=710,
        height=1496,
        numFrames=6
    }

    local surloeSceneOptions={
        width=1000,
        height=351,
        numFrames=9
    }


    local spriteSheet1=graphics.newImageSheet("Surloe/surloeSprite.png",surloeOptions)
    local spriteSheet2=graphics.newImageSheet("Surloe/surloeSucessSprite4.png",surloeSceneOptions)
    


    local sequenceSurloeSprite={
        {
            name = "normalStand",
            start = 1,
            count = 6,
            time = 600,
            loopCount = 0,
            loopDirection = "forward"
        }
    }

    local sequenceSurloeScene={
         {
            name = "finishAnimation",
            start = 1,
            count = 9,
            time = 1250,
            loopCount = 0,
            loopDirection = "forward"
        }
    }

    surloeAnimated=display.newSprite(grupoDisparo,spriteSheet1,sequenceSurloeSprite)
    surloeAnimated.x=antena.x+paddingX*3
    surloeAnimated.y=torre.y-paddingY*3.5
    surloeAnimated.xScale=0.1;surloeAnimated.yScale=0.1
    surloeAnimated:play()

    levelCompleteDrawingAnimated=display.newSprite(grupoFrontEnd,spriteSheet2,sequenceSurloeScene)
    levelCompleteDrawingAnimated.x=paddingX*15
    levelCompleteDrawingAnimated.y=paddingY*7.5
    levelCompleteDrawingAnimated.anchorX=0.75
    levelCompleteDrawingAnimated.xScale=0.5;levelCompleteDrawingAnimated.yScale=0.5
    levelCompleteDrawingAnimated.alpha=0
    

    pistol=display.newImageRect(grupoDisparo,"pistol/pistols3.png",paddingX*5,paddingY*2)
    pistol.x=surloeAnimated.x+paddingX*0.25
    pistol.y=surloeAnimated.y+paddingY*0.5

    lifebarMain=display.newImage(grupoStats,"inmovilesprites/LifeFrame.png",paddingX*24,paddingY*2 )
    lifebarMain.xScale = 0.10; lifebarMain.yScale=0.10
    lifebarMain.anchorX=1

    lifebar=display.newRect(grupoStats,paddingX*23.5,paddingY*2,(100*antena.vida)/antena.vida,30 )
    lifebar:setFillColor( 0, 1, 0)
    lifebar.anchorX=1 

    lifeText=display.newText(grupoStats,"Life",paddingX*23.5,paddingY*2,"fonts/digital-geometric-bold.ttf",17)
    lifeText.anchorX=1
    lifeText.text="Life: "..antena.vida
    lifeText:setFillColor(0,0, 255/255)

    loadSquare=display.newPolygon(grupoStats,0,0,vertexLoadSquare)
    loadSquare:translate(paddingX*7,paddingY*13)
    loadSquare.anchorX=1
    loadSquare:setFillColor(21/255,76/255,121/255)

    blurry=display.newRect(grupoFrontEnd,0,0,cw,ch)
    blurry.anchorX=0;blurry.anchorY=0
    blurry:setFillColor(0,0,0)
    blurry.alpha=0
    blurry:toFront()

    pauseButton=display.newImage(grupoFrontEnd,"inmovilesprites/botonPause.png",paddingX*15,paddingY*2 )
    pauseButton.xScale =0.10; pauseButton.yScale=0.10
    pauseButton.anchorX=1
    pauseButton.isPaused=false
    pauseButton:addEventListener( "touch", pauseGame)
    pauseButton:toFront()

    pauseText=display.newText(grupoFrontEnd,"PAUSE",paddingX*15,paddingY*7.5,"fonts/digital-geometric-bold.ttf",30)
    pauseText.alpha=0
    pauseText:setFillColor(0,255/255, 255/255)
    pauseText:toFront()

    explosion=display.newImage(grupoFrontEnd,"inmovilesprites/explosion.png",cw/2,ch/2)
    explosion.xScale=0.10;explosion.yScale=0.10
    explosion.alpha=0

    enemyFrame=display.newImage(grupoStats,"inmovilesprites/TextFrame.png",paddingX*24,paddingY*13 )
    enemyFrame.xScale = 0.10; enemyFrame.yScale=0.10
    enemyFrame.anchorX=1

    enemiesLeftText=display.newText(grupoStats,"Enemies",paddingX*23.5,paddingY*13,"fonts/digital-geometric-bold.ttf",17)
    enemiesLeftText.anchorX=1
    enemiesLeftText.text="Enemies: "..enemiesLeft
    enemiesLeftText:setFillColor(0,255/255, 255/255)

    powerButton=display.newImage(grupoStats,"inmovilesprites/specialAttackButton.png",paddingX*1.5,paddingY*13 )
    powerButton.xScale = 0.10; powerButton.yScale=0.10
    powerButton.anchorX=0
    powerButton.alpha=0.2
    powerButton.filled=0
    powerButton:addEventListener( "touch", power)

    sceneGroup:insert(grupoDisparo)
    sceneGroup:insert(grupoStats)
    sceneGroup:insert(grupoJuego)
    sceneGroup:insert(grupoFrontEnd)


    -- Code here runs when the scene is first created but has not yet appeared on screen

end
 
 
-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        
        audio.play(backgroundLevelMusic,{channel=1,loops=-1})
        iniciar(grupoJuego)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
    end    
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
        display.remove(grupoJuego)
        grupoJuego=nil
        display.remove(grupoStats)
        grupoStats=nil
        display.remove(grupoDisparo)
        grupoDisparo=nil
        display.remove(grupoFrontEnd)
        grupoFrontEnd=nil
        enemies=nil
        vertexLoadSquare=nil
        vertexNew=nil
        surloeAnimated=nil
        levelCompleteDrawingAnimated=nil
        backgroundLevelMusic=nil
        timer.cancelAll( )
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