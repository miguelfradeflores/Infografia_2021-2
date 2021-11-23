local composer = require( "composer" )

local scene = composer.newScene()
 
cw = display.contentWidth
ch = display.contentHeight
local paddingX = cw/9
local paddingY = ch/6

local grupoElementos = display.newGroup( )
local grupoOrbitas = display.newGroup()


--tabla de los electrones

local t = {{1,0,0,0,0,0,0},
        {2,8,2,0,0,0,0},
        {2,8,9,0,0,0,0},
        {2,8,1,0,0,0,0},
        {2,5,0,0,0,0,0},
        {2,8,18,3,0,0,0},
        {2,8,18,32,19,0,0}
}
-- protones,neutrones, electrones,pa
local info = {{1,0,1,1.0},
            {12,12,12,24.3},
            {19,20,19,39.1},
            {11,11,11,23.0},
            {7,7,7,14.0},
            {31,39,31,69.7},
            {79,117,79,197.0}
}

-- tabla de radios de las orbitas
local radios = {20,30,40,50,60,70,80}


local centro
local info1
local info2
local info3
local info4


---Modelo 
 function showElement(self, event)
    print( self.id )
    if event.phase == "ended" or event.phase == "cancelled" then
    
        if(grupoElementos ~= nil) then
            print( "El grupo no esta vacio" )
            display.remove(grupoElementos )
            grupoElementos = nil

            display.remove(info1 )
            info1 = nil

            display.remove(info2 )
            info2 = nil

            display.remove(info3 )
            info3 = nil

            display.remove(info4 )
            info4 = nil

            display.remove(grupoOrbitas )
            grupoOrbitas = nil
        end

        grupoElementos = display.newGroup( )
        grupoOrbitas = display.newGroup( )

        info1 = display.newText( "Protones: "..info[self.id][1], cw/2 + 3.5*paddingX, ch/2 + 3*paddingY/2 , "arial",10)
        info1:setTextColor( 0, 0, 1 )

        info2 = display.newText( "Neutrones: "..info[self.id][2], cw/2 + 3.5*paddingX, ch/2 + 4*paddingY/2 , "arial",10)
        info2:setTextColor( 0, 0, 1 )

        info3 = display.newText( "Electrones: "..info[self.id][3], cw/2 + 3.5*paddingX, ch/2 + 5*paddingY/2 , "arial",10)
        info3:setTextColor( 0, 0, 1 )

        info4 = display.newText( "P.Atómico: "..info[self.id][4], cw/2 + 3.5*paddingX, ch/2 + 2*paddingY/2 , "arial",10)
        info4:setTextColor( 0, 0, 1 )
        
        for i=1,7 do
            local grupoAnillos = display.newGroup( )
            local orbita = display.newCircle(centro.x, centro.y, radios[i])
            orbita.strokeWidth = 2
            orbita.alpha=0.1
            orbita:setStrokeColor( 1, 0, 1 )
            grupoOrbitas:insert(orbita)

            for j=1, t[self.id][i] do 
                local elec = display.newImageRect("yellow-ball.png",20,20)
                local ang = math.random( 1, 100 ) 
                elec.angulo = ang 

                elec.x = math.sin( ang ) * radios[i] + centro.x
                elec.y = math.cos( ang ) * radios[i] + centro.y
                grupoAnillos:insert(elec)

            end
            grupoElementos:insert( grupoAnillos )
        end



        --grupoElementos.isVisible=true
    end
    return true
 end

------
 function rotar( elemento, radio )

    elemento.angulo = elemento.angulo + 0.03 
    elemento.x = math.sin( elemento.angulo ) * radio + centro.x
    elemento.y = math.cos( elemento.angulo ) * radio + centro.y
        
 
 end

 --------

function rotarElectrones()
    if(grupoElementos~= nil) then
        for i=1, grupoElementos.numChildren do 
            for j=1, grupoElementos[i].numChildren do 
                rotar(grupoElementos[i][j], radios[i])
            end
        end
    end
end

 Runtime:addEventListener( "enterFrame", rotarElectrones )


 

-------------------------------------------------- create()
function scene:create( event )
 
    local sceneGroup = self.view
    grupoElementos.isVisible = false

    local modelo = display.newImageRect( sceneGroup,"fondo3.jpg", cw, ch)
    modelo.anchorX=0; modelo.anchorY=0

    centro = display.newImageRect( sceneGroup,"nucleo.png", 25, 25)
    centro.x = cw/2 + paddingX 
    centro.y = ch/2 + 2*paddingY/2



    -- for i=0,8 do
    --  local LineaVertical = display.newLine(paddingX*i,0, paddingX*i,ch )
    --  LineaVertical.strokeWidth = 1
    --  LineaVertical:setStrokeColor(0) --color negro de las lineas
    -- end

    -- for i=0,5 do
    --  local LineaHorizontal = display.newLine(0,paddingY*i,cw,paddingY*i)
    --  LineaHorizontal.strokeWidth = 1
    --  LineaHorizontal:setStrokeColor(0) --color negro de las lineas
    -- end

    local hidro = display.newImageRect( sceneGroup,"hidro.png", paddingX, paddingY)
    hidro.x = cw/2 - 2*paddingX
    hidro.y = ch/2 - 3*paddingY/2
    hidro.id=1
    hidro.touch = showElement
    


    local mg = display.newImageRect( sceneGroup,"magnesio.png", paddingX, paddingY)
    mg.x = cw/2  - paddingX
    mg.y = ch/2 - 3*paddingY/2
    mg.id=2
    mg.touch = showElement

    local k = display.newImageRect( sceneGroup,"potasio.png", paddingX, paddingY)
    k.x = cw/2
    k.y = ch/2 - 3*paddingY/2
    k.id=3
    k.touch = showElement

    local na = display.newImageRect( sceneGroup,"sodio.png", paddingX, paddingY)
    na.x = cw/2 + paddingX
    na.y = ch/2 - 3*paddingY/2
    na.id = 4
    na.touch = showElement

    local n = display.newImageRect( sceneGroup,"nitrogeno.png", paddingX, paddingY)
    n.x = cw/2 + 2*paddingX
    n.y = ch/2 - 3*paddingY/2
    n.id=5
    n.touch = showElement

    local ga = display.newImageRect( sceneGroup,"galio.png", paddingX, paddingY)
    ga.x = cw/2 + 3*paddingX
    ga.y = ch/2 - 3*paddingY/2
    ga.id=6
    ga.touch = showElement

    local au = display.newImageRect( sceneGroup,"oro.png", paddingX, paddingY)
    au.x = cw/2 + 4*paddingX
    au.y = ch/2 - 3*paddingY/2
    au.id=7
    au.touch = showElement

    

       

    hidro:addEventListener( "touch", hidro)
    mg:addEventListener( "touch",mg )
    k:addEventListener( "touch", k)
    na:addEventListener( "touch", na)
    n:addEventListener( "touch", n)
    ga:addEventListener( "touch", ga)
    au:addEventListener( "touch", au)



end

-------------------------------------------- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        --grupoElementos.isVisible = true
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- --------------------------------------------hide()
-- function scene:hide( event )
 
--     local sceneGroup = self.view
--     local phase = event.phase
 
--     if ( phase == "will" ) then
--         -- Code here runs when the scene is on screen (but is about to go off screen)
 
--     elseif ( phase == "did" ) then
--         -- Code here runs immediately after the scene goes entirely off screen
--      --display.remove(elec)
 
--     end
-- end
 
 
-- ---------------------------------------------------------- destroy()
-- function scene:destroy( event )
--     local sceneGroup = self.view
--     -- Code here runs prior to the removal of scene's view
 

 
-- end
 
 
-- -- -----------------------------------------------------------------------------------
-- -- Scene event function listeners
-- -- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
-- scene:addEventListener( "hide", scene )
-- scene:addEventListener( "destroy", scene )


-- -----------------------------------------------------------------------------------
 
return scene