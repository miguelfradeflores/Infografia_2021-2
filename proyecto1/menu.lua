


local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 

cw = display.contentWidth
ch = display.contentHeight



local optionsSceneLvl = {

        effect = "fade" ,
        time = "2000"
    }

function irPantallaNivelUno ( self , e , nivel )

        if e.phase ==  "ended" then
            composer.gotoScene( "nivel_1" , optionsSceneLvl )
        end


    return true

end

function irPantallaNivelDos ( self , e , nivel )

        if e.phase ==  "ended" then
            composer.gotoScene( "nivel_2" , optionsSceneLvl )
        end


    return true

end
function irPantallaNivelTres ( self , e , nivel )

        if e.phase ==  "ended" then
            composer.gotoScene( "nivel_3" , optionsSceneLvl )
        end


    return true

end












 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen



    --Musica 
    
    local backgroundMusic = audio.loadStream( "/Sound/background_sound.mp3" )
    local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=1000 } )


    local fondo = display.newImageRect( sceneGroup , "img_menu.jpeg", cw, ch )
    fondo.anchorX = 0 ; fondo.anchorY = 0

    local titulo = display.newImage(sceneGroup, "img_title.png" , cw/2 , ch/8)
    titulo.xScale = 0.5 ;titulo.yScale=0.5



    local scalaBotonesX = 0.25
    local scalaBotonesY = 0.25

    local btnNivel1 = display.newImage(sceneGroup, "img_btn_lvl1.png" , cw/2 , ch/3)
    btnNivel1.xScale =scalaBotonesX ; btnNivel1.yScale = scalaBotonesY


    local btnNivel2 =display.newImage(sceneGroup, "img_btn_lvl2.png" , cw/2 , ch/2)
    btnNivel2.xScale = scalaBotonesX ; btnNivel2.yScale = scalaBotonesY

    local btnNivel3 =display.newImage(sceneGroup, "img_btn_lvl3.png" , cw/2 , 320)
    btnNivel3.xScale = scalaBotonesX ; btnNivel3.yScale = scalaBotonesY



    btnNivel1.touch = irPantallaNivelUno
    btnNivel1:addEventListener( "touch", btnNivel1 )

    btnNivel2.touch = irPantallaNivelDos
    btnNivel2:addEventListener( "touch", btnNivel2 )

    btnNivel3.touch = irPantallaNivelTres
    btnNivel3:addEventListener( "touch", btnNivel3 )


 
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