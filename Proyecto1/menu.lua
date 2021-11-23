local composer = require( "composer" )
 
local scene = composer.newScene()

 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local hereWeGo
local playhereWeGo
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function irPantallaNivel1( self, event )
    if event.phase == "ended" then 
        composer.gotoScene( "nivel1", {
            effect = "fromRight",
            time = "700",
            params = {
                nivel = 1,
                segundos = 40 
            }
        })
        hereWeGo = audio.loadSound("level.mp3")
        playhereWeGo = audio.play(hereWeGo)
    end
    return true
end


function irPantallaNivel2( self, event )
    if event.phase == "ended" then 
        composer.gotoScene( "nivel2", {
            effect = "fromRight",
            time = "700",
            params = {
                nivel = 2,
                segundos = 30
            }
        })
        hereWeGo = audio.loadSound("level.mp3")
        playhereWeGo = audio.play(hereWeGo)
    end
    return true
end


function irPantallaNivel3( self, event )
    if event.phase == "ended" then 
        composer.gotoScene( "nivel3", {
            effect = "fromRight",
            time = "700",
            params = {
                nivel = 3,
                segundos = 20
            }
        } )
        hereWeGo = audio.loadSound("level.mp3")
        playhereWeGo = audio.play(hereWeGo)
    end
    return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local fondo = display.newImageRect(sceneGroup, "fondoMenu3.jpg", cw, ch )
    fondo.anchorX = 0 
    fondo.anchorY = 0

    -- local myRoundedRect = display.newRoundedRect(sceneGroup, 0, 0, 400, 270, 12 )
    -- myRoundedRect:setFillColor( 47/255, 188/255, 188/255 )
    -- myRoundedRect.x = cw/15
    -- myRoundedRect.y = ch/15
    -- myRoundedRect.anchorX = 0 
    -- myRoundedRect.anchorY = 0

    local myRoundedRect2 = display.newRoundedRect(sceneGroup, 0, 0, 330, 220, 12 )
    myRoundedRect2:setFillColor( 237/255, 232/255, 223/255 )
    myRoundedRect2.x = cw/7.5
    myRoundedRect2.y = ch/7.5
    myRoundedRect2.anchorX = 0 
    myRoundedRect2.anchorY = 0

    local level = display.newText(sceneGroup, "CHOOSE A LEVEL", 100, 100, "arial")
    level:setTextColor( 0, 0, 0 )
    level.size = 25
    level.x = cw/2
    level.y = ch/6
    level.anchorX = 0.5
    level.anchorY = 0

    local blevel1 = display.newImageRect(sceneGroup, "backLeves.png", cw/3.8, ch/3.8)
    blevel1.x = cw/5.8
    blevel1.y = ch/3.5
    blevel1.anchorX = 0 
    blevel1.anchorY = 0
    blevel1:setFillColor( 0.4, 0.4, 0.4, 0.3 )

    local level1 = display.newImageRect(sceneGroup, "1.png", cw/5, ch/6 )
    level1.x = cw/5
    level1.y = ch/3
    level1.anchorX = 0 
    level1.anchorY = 0

    local blevel2 = display.newImageRect(sceneGroup, "backLeves.png", cw/3.8, ch/3.8)
    blevel2.x = cw/2.1
    blevel2.y = ch/3.5
    blevel2.anchorX = 0 
    blevel2.anchorY = 0
    blevel2:setFillColor( 0.4, 0.4, 0.4, 0.3 )

    local level2 = display.newImageRect(sceneGroup, "2.png", cw/5, ch/6 )
    level2.x = cw/2
    level2.y = ch/3
    level2.anchorX = 0 
    level2.anchorY = 0

    local blevel3 = display.newImageRect(sceneGroup, "backLeves.png", cw/3.8, ch/3.8)
    blevel3.x = cw/2.9
    blevel3.y = ch/1.8
    blevel3.anchorX = 0 
    blevel3.anchorY = 0
    blevel3:setFillColor( 0.4, 0.4, 0.4, 0.3 )

    local level3 = display.newImageRect(sceneGroup, "3.png", cw/5, ch/6 )
    level3.x = cw/2.1
    level3.y = ch/1.7
    level3.anchorX = 0.5 
    level3.anchorY = 0

    level1.touch = irPantallaNivel1
    level1:addEventListener( "touch", level1 )

    level2.touch = irPantallaNivel2
    level2:addEventListener( "touch", level2 )

    level3.touch = irPantallaNivel3
    level3:addEventListener( "touch", level3 )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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