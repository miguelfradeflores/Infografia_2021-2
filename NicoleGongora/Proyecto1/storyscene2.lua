local composer = require( "composer" )
 
local scene= composer.newScene()
local cw=display.contentWidth
local ch=display.contentHeight

local paddingX=cw/30
local paddingY=ch/15

local boton, boton1
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 



 function irAlMenu(self,e)
    if e.phase == "ended" then
        composer.gotoScene( "menu",{effect="fade",time=1000})
    end
    return true
end


function irAtras(self,e)
    if e.phase == "ended" then
        composer.gotoScene( "storyscene1",{
            effect = "fromLeft",
            time = "750"
            })
    end
    return true
end 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    local fondo=display.newImageRect(sceneGroup,"inmovilesprites/story2.png",cw,ch)
    fondo.anchorX=0; fondo.anchorY=0
    
    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    boton=display.newImage( sceneGroup,"inmovilesprites/botonMenu.png", paddingX*15,paddingY*13)
    boton.xScale = 0.05; boton.yScale=0.05
    boton.alpha=0
    boton.touch=irAlMenu
    boton:addEventListener( "touch", boton)

    boton1=display.newImage( sceneGroup,"inmovilesprites/botonGoOnB.png", paddingX*0.75,paddingY*13)
    boton1.xScale = 0.05; boton1.yScale=0.05
    boton1.anchorX=0
    boton1.alpha=0
    boton1.touch=irAtras
    boton1:addEventListener( "touch", boton1)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
       
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        transition.to(boton, {alpha=1,xScale=0.15,yScale=0.15, time=500})
        transition.to(boton1, {alpha=1,xScale=0.15,yScale=0.15, time=500})
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        transition.to(boton, {alpha=0,xScale=0.05,yScale=0.05, time=500})
        transition.to(boton1, {alpha=0,xScale=0.05,yScale=0.05, time=500})

    elseif ( phase == "did" ) then

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