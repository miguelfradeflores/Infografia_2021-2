local composer = require( "composer" )
 
local scene= composer.newScene()
local cw=display.contentWidth
local ch=display.contentHeight

local paddingX=cw/30
local paddingY=ch/15

local boton, boton1, logo, blurry
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
local levelparams={
    numberOfEnemies=70,
    antenaVidaInicial=100
}


 function irAlNivel(self,e)
    if e.phase == "ended" then
        composer.gotoScene( "level",{
            effect = "fade",
            time = "250", params=levelparams
            } )
    end
    return true
end

function irAHistoria(self,e)
    if e.phase == "ended" then
        composer.gotoScene( "storyscene1",{
            effect = "fade",
            time = "250"
            } )
    end
    return true
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view


    local fondo=display.newImageRect(sceneGroup,"inmovilesprites/menuFondo.png",cw,ch)
    fondo.anchorX=0; fondo.anchorY=0

    

    blurry=display.newRect( sceneGroup, 0, 0, cw, ch)
    blurry.anchorX=0; blurry.anchorY=0
    blurry.alpha=0
    blurry:setFillColor( 0,0,0 )

    logo=display.newImage( sceneGroup,"inmovilesprites/logo.png", paddingX*22,paddingY*4)
    logo.xScale = 0.3; logo.yScale=0.3
    logo.alpha=0


    boton=display.newImage( sceneGroup,"inmovilesprites/botonPlay.png", paddingX*20,paddingY*10)
    boton.xScale = 0.02; boton.yScale=0.02
    boton.alpha=0
    boton.touch=irAlNivel
    boton:addEventListener( "touch", boton)


    boton1=display.newImage( sceneGroup,"inmovilesprites/botonStory.png", paddingX*25,paddingY*10)
    boton1.xScale = 0.02; boton1.yScale=0.02
    boton1.alpha=0
    boton1.touch=irAHistoria
    boton1:addEventListener( "touch", boton1)
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
       
        composer.removeScene("level",true)
 
    elseif ( phase == "did" ) then
        transition.to(blurry, {alpha=0.5,time=500})
        transition.to(logo, {alpha=1,time=500})
        transition.to(boton, {alpha=1,xScale=0.13,yScale=0.13, time=500})
        transition.to(boton1, {alpha=1,xScale=0.13,yScale=0.13, time=500})
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        transition.to(blurry, {alpha=0,time=500})
        transition.to(logo, {alpha=0,time=500})
        transition.to(boton, {alpha=0,xScale=0.02,yScale=0.02, time=500})
        transition.to(boton1, {alpha=0,xScale=0.02,yScale=0.02, time=500})
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