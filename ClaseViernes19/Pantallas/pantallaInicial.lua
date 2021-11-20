local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
--  local cw = display.actualContentWidth
-- local ch = display.contentHeight
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
function irMenu(self, e)
    if e.phase == "ended" then
        composer.gotoScene( "menu",{
            effect = "zoomInOut",
            time = "500"
            } )
    end
    return true
end

local enemigos
local textoEnemigos

function spawnEnemy(posx,posy, grupo)
    local enemy = display.newImageRect(grupo, "yetiFast.png", 50,30)
    enemy.x = posx; enemy.y = posy

end


local posicionesOcupadas = {false,false,false }
local posicionesX = {cw/4,cw/2,cw*3/4}


-- create()
function scene:create( event )

    print( event.params )

    for k, v in pairs( event.params  ) do

        print( k,v )
    end
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


    local fondo = display.newImageRect(sceneGroup, "8.jpg",cw,ch )
    fondo.anchorX = 0; fondo.anchorY=0

    local botonAtras = display.newImageRect( sceneGroup, "hoja izq.png", 80,80 )
    botonAtras.x = 50; botonAtras.y = 50
    botonAtras.touch = irMenu

    textoEnemigos = display.newText(sceneGroup , "ENEMIGOS" .. event.params.enemigos, cw/2, 100, "arial", 25 )
    textoEnemigos:setFillColor( 1,0,0 )


    botonAtras:addEventListener( "touch", botonAtras )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
        for k,v in pairs( event.params ) do
            print("Params in show event", k ,v)
        end

        textoEnemigos.text = "Enemigos: " .. event.params.enemigos
        enemigos = event.params.enemigos



    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        composer.removeScene("menu")
        function decrementar( event )
            enemigos = enemigos -1
            textoEnemigos.text = "Enemigos: " .. enemigos
        end

        timer.performWithDelay( 1000, decrementar, -1 ,"cronometro")
       -- for i=1, 3 do

            local todosCubiertos = true

            -- repeat 
            --     todosCubiertos = true
            -- local  posiblePosicionX =  math.random(1,3)
            -- print( "Posicion randomica", posiblePosicionX )
            -- if posicionesOcupadas[posiblePosicionX] == false then
            --     posicionesOcupadas[posiblePosicionX] = true
            --     spawnEnemy( posicionesX[posiblePosicionX] , math.random(200, ch-50 ), sceneGroup  )
            -- end

            -- for i,v in ipairs( posicionesOcupadas ) do 
            --     if  not(v)  then
            --         todosCubiertos = false
            --         break
            --     end
            -- end

            -- until todosCubiertos == true


--        end

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        timer.cancelAll()
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