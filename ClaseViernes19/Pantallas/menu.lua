local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
cw = display.actualContentWidth
ch = display.contentHeight

local grupoJuego, texto, enemy
local boton, icon
local enemys = {}

function spawnEnemy(posx,posy, grupo, name, listener)
    print( grupoJuego.numChildren )
    enemys[name] = display.newImageRect(grupo, "Icon.png", 50,30)
    enemys[name].x = posx; enemys[name].y = posy
    enemys[name].name = "enemy: " .. name

    enemys[name].touch = listener
    enemys[name]:addEventListener( "touch", enemys[name] )

    transition.to(enemys[name], {time= 20000, x=cw, y = math.random(0,ch)})

end

local enemigos = 10

function destruir(self, e)

    if e.phase == "began" then
        print( self.name )

        local lineaDisparo = display.newLine(boton.x, boton.y, self.x, self.y )
        lineaDisparo.strokeWidth = 4
    elseif e.phase == "ended" then
        
        transition.cancel(self)



        self:removeSelf( )
        self = nil




        print( grupoJuego.numChildren )
        texto.text = "Enemigos ".. grupoJuego.numChildren
    end
return true
end


function iniciar(grupo)

    texto.text = "Enemigos 10"
    for i=1,10 do
        local x1 = math.random(0,cw)
        local y1 = math.random(0,ch)
        spawnEnemy(x1,y1, grupo, i, destruir)
    end

end



function limpiar()
    for i=grupoJuego.numChildren, 1, -1 do
        if grupoJuego[i] ~= nil then
            grupoJuego[i]:removeSelf()
            grupoJuego[i] = nil

        end
    end

    for i=#enemys,1,-1 do
        table.remove( enemys, i )
    end
end

function reiniciar(  )
    limpiar()
    iniciar(grupoJuego)

end

function iniciarAuxiliar()
    iniciar(grupoJuego)
end


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
 


-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    grupoJuego = display.newGroup( )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local fondo = display.newImageRect(sceneGroup, "1.jpg",cw,ch )
    fondo.anchorX = 0; fondo.anchorY=0

    boton = display.newImage( sceneGroup, "play.png", cw/2, ch/2 )
    boton.xScale = 0.1; boton.yScale=0.1
    boton.touch = iniciarAuxiliar
    boton.enemigos = 10
    boton:addEventListener( "touch", boton )


    boton2 = display.newImage( sceneGroup, "play.png", cw/4, ch/4 )
    boton2.xScale = 0.1; boton2.yScale=0.1
    boton2.touch = reiniciar
    boton2.enemigos = 30
    boton2:addEventListener( "touch", boton2 )

    texto = display.newText(sceneGroup, "Enemigos:", cw/2, ch/5, "arial", 20 )

    sceneGroup:insert( grupoJuego )

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
       -- transition.to(boton, {x= 300, time=2000})
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
       -- transition.to(boton, {rotation=180, time=2000})
        -- icon = display.newImage(sceneGroup, "Icon.png", math.random(0,cw ), ch/2)
        -- icon.nombre = "par1"

        -- function icon:touch(e)
        --     if e.phase == "ended" then
        --         Runtime:removeEventListener( "enterFrame", rotar )
        --         boton:removeSelf( )
        --     end
        -- end



        --icon:addEventListener( "touch", icon )
        -- function rotar()
        --     boton.rotation = boton.rotation+1
        --     boton.x = boton.x +1

        --     if boton.x >= cw then

        --         boton.x = 0
        --     end
 

        -- end

        iniciar(grupoJuego)
        for i=1, grupoJuego.numChildren do
            print( grupoJuego[i].x, grupoJuego[i].y, grupoJuego[i].name )

        end
        print("Cantidad de enemigos", #enemys)

     --   Runtime:addEventListener( "enterFrame", rotar )

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
        -- print(icon.nombre)
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