local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
cw = display.actualContentWidth
ch = display.contentHeight
 
 
function irPantallaInicial(self, e)

    if e.phase == "ended" then
        composer.gotoScene( "pantallaInicial",{
            effect = "zoomInOut",
            time = "500",
            params = {
                nivel = 1,
                tiempo = 60,
                enemigos = self.enemigos,
                nivelesDeElectron = 10
            }
            } )
    end
    return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local boton, icon

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local fondo = display.newImageRect(sceneGroup, "1.jpg",cw,ch )
    fondo.anchorX = 0; fondo.anchorY=0

    boton = display.newImage( sceneGroup, "play.png", cw/2, ch/2 )
    boton.xScale = 0.1; boton.yScale=0.1
    boton.touch = irPantallaInicial
    boton.enemigos = 10
    boton:addEventListener( "touch", boton )


    boton2 = display.newImage( sceneGroup, "play.png", cw/4, ch/2 )
    boton2.xScale = 0.1; boton2.yScale=0.1
    boton2.touch = irPantallaInicial
    boton2.enemigos = 30
    boton2:addEventListener( "touch", boton2 )


    print("Children del menu",  sceneGroup.numChildren)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
--        boton.x = 300
        boton.rotation=0
        transition.to(boton, {x= 300, time=2000})
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        transition.to(boton, {rotation=180, time=2000})
        icon = display.newImage(sceneGroup, "Icon.png", math.random(0,cw ), ch/2)
        icon.nombre = "par1"

    end

    print( "Children de la escena en show", sceneGroup.numChildren )

end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --display.remove(icon)
            -- icon:removeSelf( )
            -- icon = nil
            --icon.isVisible = false

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        print(icon.nombre)
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