local composer = require( "composer" )
local widget = require( "widget" )

 ch = display.contentHeight
 cw = display.contentWidth

 --audio.reserveChannels( 1 )
 audio.reserveChannels( 3 )
--background music
 menuSound = audio.loadSound( "sounds/menu.mp3" )
 gameSound = audio.loadSound( "sounds/game.mp3" )
 looseSound = audio.loadSound( "sounds/loose.mp3" )
 winSound = audio.loadSound( "sounds/win.mp3" )

-- sfx
 bulletSound = audio.loadSound( "sounds/bullet.ogg" )
 clickSound = audio.loadSound( "sounds/clickBtn.ogg" )
 clickPlaySound = audio.loadSound( "sounds/clickPlay.ogg" )
 hitSound = audio.loadSound( "sounds/hit.ogg" )
 towerSound = audio.loadSound( "sounds/tower.ogg" )

  --audio.setVolume( 0.5, { channel=1 } )
 --audio.play( explosionSound )
 --audio.stop( 1 )


 numLinesW = 11
 numLinesH = 10

 wDiv = cw / numLinesW
 hDiv = ch / numLinesH

 fondo = {0}
 machine = {0,71/255,171/255}
 path = {12/255,129/255,1}
 path2 = {255/255,200/255,156/255}

 portalColor = {122/255,12/255,1}
 towerColor = {4/255,1,1}
 enemyColor = {4/255,85/255,14/255}



 --life = 1


 soundOn = true



function gotoMenu()
    if soundOn then
        audio.play( menuSound, { channel=1, loops=-1 } )
        audio.setVolume( 0.04, { channel=1 } )

    end
    
    composer.gotoScene( "menu" )
end

function gotoGame()
    life = 1
    if soundOn then

    audio.play( gameSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.04, { channel=1 } )
    

    end

    composer.gotoScene( "game",{ effect = "fade"} )
end

function gotoLoose()
    if soundOn then

    audio.play( looseSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.1, { channel=1 } )
    end
	composer.gotoScene( "perdiste",{ effect = "flipFadeOutIn"}  )
end

function gotoWin()
    if soundOn then

    audio.play( winSound, { channel=1, loops=-1 } )
    audio.setVolume( 0.08, { channel=1 } )
    end
	composer.gotoScene( "win",{ effect = "flipFadeOutIn"}  )
end
gotoMenu()
--gotoGame()
--gotoLoose()
--gotoWin()