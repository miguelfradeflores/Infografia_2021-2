local composer = require( "composer" )
 
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Division de pantallas
local paddingX = cw/4
local paddingY = ch/4

-- Variables de la funcion detras
local cartasVolteadas = 0 
local primerfx = 0
local primerfy = 0
local carta1 
local carta2

-- Variables de tiempo
local segundos
local timer1

-- Variable para el score 
local puntaje

-- Botones 
local pausa
local play
local score
local time
local menu

-- Variables usadas para el final 
local win 
local lose
local textWin
local textLose
local textWin2
local textLose2
local replay

-- Musica
local backgroundMusic
local playMusic

local hmmm
local playHmmm

local perder 
local playPerder

local ganar
local playGanar

local moneda 
local playMoneda

-- Grupos 
local GrupoFondo = display.newGroup( )
local GrupoBotones = display.newGroup( )
local GrupoCartas = display.newGroup( )
local GrupoFinal = display.newGroup( )

-- Posiciones ocupadas 
local posisiones = {false, false, false, false, false, false, false, false, false, false, false, false}

-- Seis pares de cartas utilizadas para el juego 
local par1 = {
    imagen = "pDonkey1.png",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}
local par2 = {
    imagen = "pLuigi1.png",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}
local par3 = {
    imagen = "pMario1.png",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}
local par4 = {
    imagen = "pYoshi1.jpg",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}
local par5 = {
    imagen = "pToada1.png",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}
local par6 = {
    imagen = "pWario1.png",
    posx = 0,
    posy = 0,
    posx2 = 0,
    posy2 = 0,
    dis = nil,
    dis2 = nil
}

-- Posibles posiciones de las cartas en el juego
local posiblesPosisiones = {
        {0, paddingY},
        {paddingX, paddingY},
        {paddingX*2, paddingY},
        {paddingX*3, paddingY},

        {0, paddingY*2},
        {paddingX, paddingY*2},
        {paddingX*2, paddingY*2},
        {paddingX*3, paddingY*2},

        {0, paddingY*3},
        {paddingX, paddingY*3},
        {paddingX*2, paddingY*3},
        {paddingX*3, paddingY*3},
}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Funcion para regresar al menu
function irMenu( self, event )
    if event.phase == "ended" then 
        composer.gotoScene( "menu", {
            effect = "fromRight",
            time = "700"
        } )
    hmmm = audio.loadSound("hmm.mp3")
    playHmmm = audio.play(hmmm, {loops =0})
    end
    return true
end

-- Funcion para poner las imagenes en coordenadas (x, y)
function putImage(par)
    local p = posiciones()
    par.dis = display.newImageRect(GrupoCartas, par.imagen, paddingX, paddingY )
    par.dis.anchorX = 0
    par.dis.anchorY = 0
    par.dis.x = p[1][1]
    par.dis.y = p[1][2]
    par.posx = par.dis.x
    par.posy = par.dis.y
    par.dis2 = display.newImageRect(GrupoCartas, par.imagen, paddingX, paddingY )
    par.dis2.anchorX = 0
    par.dis2.anchorY = 0
    par.dis2.x = p[2][1]
    par.dis2.y = p[2][2]
    par.posx2 = par.dis2.x
    par.posy2 = par.dis2.y
end

-- Funcion para ner las cartas en una posicion random 
function posiciones ()
    local resultado 
    local valor1
    local valor2
    local valor1Encontrado = false
    local valor2Encontrado = false

    repeat
        local m = math.random( 1, 12 )
        if posisiones[m] == false then 
            valor1Encontrado = true
            valor1 = m 
            posisiones[m] = true 
        end
    until valor1Encontrado

    repeat
        local m = math.random( 1, 12 )
        if posisiones[m] == false then 
            valor2Encontrado = true
            valor2 = m 
            posisiones[m] = true 
        end
    until valor2Encontrado
    print( valor1, valor2 )
    return {posiblesPosisiones[valor1], posiblesPosisiones[valor2]}
end

-- Funcion para limpiar las posiciones cada vez que se reinicia el juego
function limpiarPosisiones()
    posisiones = {false, false, false, false, false, false, false, false, false, false, false, false}
end

-- Funcion que pone las cartas delante o detras dependiendo si son pares o no
function detras( self, event )
    -- print( primerfx, primerfy, self.x, self.y )
    -- print( cartasVolteadas )
    if event.phase == "ended" and cartasVolteadas < 2 then 
        if cartasVolteadas == 0 then
            self:toFront( )
            cartasVolteadas = cartasVolteadas + 1
            primerfx = self.x
            primerfy = self.y
            carta1 = self
        else 
            self:toFront( )
            carta2 = self
            cartasVolteadas =  cartasVolteadas + 1
            moneda = audio.loadSound("moneda.mp3")
            if par1.posx == primerfx and par1.posy == primerfy and par1.posx2 == self.x and par1.posy2 == self.y then 
                cartasVolteadas = 0
                aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par1.posx2 == primerfx and par1.posy2 == primerfy and par1.posx == self.x and par1.posy == self.y then 
                cartasVolteadas = 0
                aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par2.posx == primerfx and par2.posy == primerfy and par2.posx2 == self.x and par2.posy2 == self.y then 
                cartasVolteadas = 0
                aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par2.posx2 == primerfx and par2.posy2 == primerfy and par2.posx == self.x and par2.posy == self.y then 
                cartasVolteadas = 0
                aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par3.posx == primerfx and par3.posy == primerfy and  par3.posx2 == self.x and par3.posy2 == self.y then 
                cartasVolteadas = 0
                aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par3.posx2 == primerfx and par3.posy2 == primerfy and par3.posx == self.x and par3.posy == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par4.posx == primerfx and par4.posy == primerfy and par4.posx2 == self.x and par4.posy2 == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par4.posx2 == primerfx and par4.posy2 == primerfy and par4.posx == self.x and par4.posy == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par5.posx == primerfx and par5.posy == primerfy and par5.posx2 == self.x and par5.posy2 == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par5.posx2 == primerfx and par5.posy2 == primerfy and par5.posx == self.x and par5.posy == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par6.posx == primerfx and par6.posy == primerfy and par6.posx2 == self.x and par6.posy2 == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                playMoneda = audio.play(moneda, {loops =0})
            elseif par6.posx2 == primerfx and par6.posy2 == primerfy and par6.posx == self.x and par6.posy == self.y then 
                cartasVolteadas = 0
                 aumentar_score()
                 playMoneda = audio.play(moneda, {loops =0})
            else 
                timer.performWithDelay( 1000, desaparecerCartas)
            end
        end
        -- Funcion que ayuda a que las cartas previamente volteadas vuelvan a ponerse atras
        function desaparecerCartas( )
            carta1:toBack()
            carta2:toBack()
            cartasVolteadas = 0
        end
    end
    return true
end

-- Funcion que hace que cuando se esta en pausa las cartas no se vean y pausa el tiempo
function func_pausa( self, event )
    if event.phase == "ended" then 
        timer.pause( timer1 )
        audio.pause( playMusic )
        par1.dis.alpha = 0
        par2.dis.alpha = 0
        par3.dis.alpha = 0
        par4.dis.alpha = 0
        par5.dis.alpha = 0
        par6.dis.alpha = 0
        par1.dis2.alpha = 0
        par2.dis2.alpha = 0
        par3.dis2.alpha = 0
        par4.dis2.alpha = 0
        par5.dis2.alpha = 0
        par6.dis2.alpha = 0
    end
    return true
end

-- Funcion que ayuda a que las cartas puelvan a verse y el tiempo continue
function func_play( self, event )
    if event.phase == "ended" then 
        timer.resume( timer1 )
        audio.resume( playMusic )
        par1.dis.alpha = 1
        par2.dis.alpha = 1
        par3.dis.alpha = 1
        par4.dis.alpha = 1
        par5.dis.alpha = 1
        par6.dis.alpha = 1
        par1.dis2.alpha = 1
        par2.dis2.alpha = 1
        par3.dis2.alpha = 1
        par4.dis2.alpha = 1
        par5.dis2.alpha = 1
        par6.dis2.alpha = 1
    end
    return true
end

-- Funcion que decrementa el tiempo de 1 en 1
function decrementar( event )
    segundos = segundos - 1
    time.text = "TIME: ".. segundos
    if segundos == 0  and puntaje < 6 then 
        audio.stop( playMusic )
        finalLose()
    end 
end

-- Funcion que aumenta el score de 1 en 1
function aumentar_score( event )
    puntaje = puntaje + 1
    score.text = "SCORE: ".. tostring( puntaje ) 
    if puntaje == 6 and segundos >= 0 then 
        audio.stop( playMusic )
        finalWin()
    end
end 

-- Funcion que le muestra al ganador que gano
function finalWin (  )
    win = display.newImageRect(GrupoFinal, "win.png", cw, ch )
    win.anchorX = 0
    win.anchorY =0

    textWin = display.newText(GrupoFinal, "CONGRATULATIONS!", 100, 100, "arial black")
    textWin:setTextColor( 1, 1, 1 )
    textWin.size = 25
    textWin.x = 0
    textWin.y = 0
    textWin.anchorX = 0
    textWin.anchorY = 0

    textWin2 = display.newText(GrupoFinal, "YOU WIN", 100, 100, "arial black")
    textWin2:setTextColor( 1, 1, 1 )
    textWin2.size = 25
    textWin2.x = paddingX*2.7
    textWin2.y = paddingY*3
    textWin2.anchorX = 0
    textWin2.anchorY = 0

    ganar = audio.loadSound("ganar.mp3")
    playGanar = audio.play(ganar, {loops =0})

    replay = display.newImageRect(GrupoFinal, "replay.png", 50, 50 )
    replay.x = paddingX*1.8
    replay.y = paddingY*2
    replay.anchorX = 0
    replay.anchorY =0

    replay.touch = irMenu
    replay:addEventListener( "touch", replay )

    transition.to( replay, { time=2500, alpha=0.3, iterations =5} )
end

-- Funcion que le muestra al jugador que perdio
function finalLose (  )
    lose = display.newImageRect(GrupoFinal, "lose.jpg", cw, ch )
    lose.anchorX = 0
    lose.anchorY =0

    textLose = display.newText(GrupoFinal, "OH NO, MARIO IS SAD...", 100, 100, "arial black")
    textLose:setTextColor( 1, 1, 1 )
    textLose.size = 25
    textLose.x = 0
    textLose.y = paddingY*0.4
    textLose.anchorX = 0
    textLose.anchorY = 0

    textLose2 = display.newText(GrupoFinal, "YOU LOSE", 100, 100, "arial black")
    textLose2:setTextColor( 1, 1, 1 )
    textLose2.size = 25
    textLose2.x = paddingX*2.8
    textLose2.y = paddingY*3.3
    textLose2.anchorX = 0
    textLose2.anchorY = 0

    perder = audio.loadSound("perder.mp3")
    playPerder = audio.play(perder, {loops =0})

    replay = display.newImageRect(GrupoFinal, "replay.png", 60, 60 )
    replay.x = paddingX*1.8
    replay.y = paddingY*2
    replay.anchorX = 0
    replay.anchorY =0

    replay.touch = irMenu
    replay:addEventListener( "touch", replay )

    transition.to( replay, { time=2500, alpha=0.3, iterations =5} )
end



-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Al momento de crear ponemos el score en 0
    puntaje = 0
    cartasVolteadas = 0

    -- Imagen que esta de fondo
    local fondo = display.newImageRect(GrupoFondo, "fondoOficial.jpg", cw, ch )
    fondo.anchorX = 0 
    fondo.anchorY = 0
    fondo.alpha = 0.4

    -- Boton de menu
    menu = display.newImageRect(GrupoBotones, "menu1.png", 50, 50 )
    menu.anchorX = 0
    menu.anchorY = 0

    -- Boton de pausa
    pausa = display.newImageRect(GrupoBotones, "pausa2.png", 50, 50 )
    pausa.x = cw/1.07
    pausa.y = ch/13

    -- Boton de play
    play = display.newImageRect(GrupoBotones, "play.png", 50, 50 )
    play.x = cw/1.2
    play.y = ch/13

    -- Nos permitio visualizar las lineas por las cuales esta dividida la pantalla
    for i=0, 4 do
        local lineaVertical = display.newLine(GrupoFondo,  paddingX*i, 0, paddingX*i, ch)
        lineaVertical.strokeWidth = 1
        lineaVertical:setStrokeColor( 0 )
        lineaVertical.alpha = 0
    end

    for i=0, 4 do
        local lineaHorizontal = display.newLine(GrupoFondo, 0, paddingY*i, cw, paddingY*i)
        lineaHorizontal.strokeWidth = 1
        lineaHorizontal:setStrokeColor( 0 )
        lineaHorizontal.alpha = 0 
    end

    -- Muestra el texto score
    score = display.newText(GrupoBotones, "SCORE: " .. tostring( puntaje ) , 100, 100, "arial")
    score:setTextColor( 1, 1, 1 )
    score.size = 25
    score.x = paddingX
    score.y = paddingY*0.1
    score.anchorX = 0.5
    score.anchorY = 0

    -- Muestra el texto time
    time = display.newText(GrupoBotones, "TIME: " .. event.params.segundos, 100, 100, "arial", 25)
    time:setTextColor( 1, 1, 1 )
    time.size = 25
    time.x = paddingX*2
    time.y = paddingY*0.1
    time.anchorX = 0
    time.anchorY = 0

    sceneGroup:insert( GrupoFondo)
    sceneGroup:insert( GrupoBotones)
    sceneGroup:insert( GrupoCartas)
    sceneGroup:insert( GrupoFinal)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        -- Pone las imagenes correspondientes de par en par 
        cartasVolteadas = 0
        segundos = 40

        putImage(par1)
        putImage(par2)
        putImage(par3)
        putImage(par4)
        putImage(par5)
        putImage(par6)

        -- Pone las imagenes que estaran como la parte trasera de las cartas
        for i=0, 3 do
            for j=1, 3 do
                fichaDetras = display.newImageRect( GrupoCartas, "fondoFichas.png", paddingX, paddingY )
                fichaDetras.x = paddingX*i
                fichaDetras.y = paddingY*j
                fichaDetras.anchorX = 0
                fichaDetras.anchorY = 0
                --fichaDetras.touch = detras
            end 
        end

        -- Llama a la funcion detras para cada carta
        par1.dis.touch = detras
        par2.dis.touch = detras
        par3.dis.touch = detras
        par4.dis.touch = detras
        par5.dis.touch = detras
        par6.dis.touch = detras

        par1.dis2.touch = detras
        par2.dis2.touch = detras
        par3.dis2.touch = detras
        par4.dis2.touch = detras
        par5.dis2.touch = detras
        par6.dis2.touch = detras

        --fichaDetras:addEventListener( "touch", fichaDetras)

        par1.dis:addEventListener( "touch", par1.dis)
        par2.dis:addEventListener( "touch", par2.dis)
        par3.dis:addEventListener( "touch", par3.dis)
        par4.dis:addEventListener( "touch", par4.dis)
        par5.dis:addEventListener( "touch", par5.dis)
        par6.dis:addEventListener( "touch", par6.dis)

        par1.dis2:addEventListener( "touch", par1.dis2)
        par2.dis2:addEventListener( "touch", par2.dis2)
        par3.dis2:addEventListener( "touch", par3.dis2)
        par4.dis2:addEventListener( "touch", par4.dis2)
        par6.dis2:addEventListener( "touch", par6.dis2)
        par5.dis2:addEventListener( "touch", par5.dis2)

        -- Pone el tiempo actualizado con el parametro previamente pasado
        time.text = "TIME: ".. event.params.segundos
        segundos = event.params.segundos

        -- Se pone un timer para que decremente automaticamente 
        timer1 = timer.performWithDelay( 1000, decrementar, 40 )

        -- Pone en pausa el juego
        pausa.touch = func_pausa
        pausa:addEventListener( "touch", pausa)

        -- Actualiza el score 
        score.text = "SCORE: ".. puntaje

        -- Cuando se toque el menu se volvera a la escena menu
        menu.touch = irMenu
        menu:addEventListener( "touch", menu )

        -- Da play al juego despues de haberlo puesto en pausa
        play.touch = func_play
        play:addEventListener( "touch", play)

        backgroundMusic = audio.loadSound("sound1.mp3")
        playMusic = audio.play(backgroundMusic, {loops =-1})
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off

        -- elimina tanto de la memoria como de la imagen a las cartas, para reiniciarlo cada vez que se habra 
        par1.dis:removeSelf( )
        par1.dis2:removeSelf( )
        par2.dis:removeSelf( )
        par2.dis2:removeSelf( )
        par3.dis:removeSelf( )
        par3.dis2:removeSelf( )
        par4.dis:removeSelf( )
        par4.dis2:removeSelf( )
        par5.dis:removeSelf( )
        par5.dis2:removeSelf( )
        par6.dis:removeSelf( )
        par6.dis2:removeSelf( )

        -- Limpia las posisiones para que todas vuelvan a estar disponibles
        limpiarPosisiones()

        -- El tiempo se cancela
        timer.cancel(timer1 )

        -- Las cartas vuelven a estar en 0 para poder dar la vuelta
        cartasVolteadas = 0

        -- El puntaje tambien vuelve a estar en 0 para reiniciar el juego 
        puntaje = 0

        -- Eliminamos todos los elementos que muestran si el jugador gano o perdio para poder reiniciar el
        display.remove( win )
        display.remove( textWin )
        display.remove( textWin2 )

        display.remove( lose )
        display.remove( textLose )
        display.remove( textLose2 )

        display.remove( replay )

        audio.stop( playMusic )

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