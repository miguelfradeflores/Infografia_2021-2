local composer = require( "composer" )
 
local scene = composer.newScene()
 




local esPar = false

local tocarSegundaCarta = false 

local cartaBocaAbajo = { }

local numerosImagenes = { 1 , 1 , 2 , 2 , 3 , 3}

local cantidadCartas = 0

local carta = { }

local tiempo = 0 -- Cronometro empieza 0 

local puntaje = 0


ubicacionX = -10 

local cartaClickeada = display.newImage("img_carta_01.png");
cartaClickeada.nombre = 1
cartaClickeada.anchorX = 1



local optionsSceneLvl = {

        effect = "fade" ,
        time = "1000"
    }


function irMenu ( self , e  )

        if e.phase ==  "ended" then
            composer.gotoScene( "menu" , options)
        end


    return true

end


 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


    local fondo = display.newImageRect( sceneGroup , "img_fondojuego.jpeg", cw, ch )
    fondo.anchorX = 0 ; fondo.anchorY = 0


    local puntaje = display.newText(sceneGroup,  "Puntaje :  " .. puntaje  , 210 , 10 , "fonts/minecraft_font.ttf" , 24)

    local botonAtras = display.newImageRect(sceneGroup , "img_backbtn.png",50,50)

    local cronometro = display.newText( sceneGroup, "Tiempo :  " .. tiempo ..  " Seg. "  , 230, 40 , "fonts/minecraft_font.ttf" , 24)


    timer.performWithDelay( 1000 ,  function() 

                tiempo = tiempo + 1 

                    end, 1)


    botonAtras.x = 30 ; botonAtras.y = 30


    botonAtras.touch = irMenu

    botonAtras:addEventListener( "touch", botonAtras )

    print( "width : " , cw  )
    print( "height : " , ch )



 
end
 









 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)


         function juego ( carta , event )

            if(event.phase == "began") then 
                if (esPar == false and tocarSegundaCarta == false ) then

                    cartaBocaAbajo[carta.number].isVisible = false;
                    tocarSegundaCarta = true


                        if(cartaClickeada.nombre ~= carta.nombre ) then 
                            -- NO ES PAR
                            timer.performWithDelay( 1000 , function()

                                esPar = false
                                tocarSegundaCarta = 0 
                                cartaBocaAbajo[cartaClickeada.number].isVisible = true
                                cartaBocaAbajo[carta.number].isVisible = true 


                                end , 1 )

                        elseif(cartaClickeada.nombre == carta.nombre ) then 
                            -- ES PAR

                            performWithDelay( 1000 ,  function ()

                                esPar = false
                                tocarSegundaCarta = 0
                                cartaClickeada:removeSelf()
                                cartaBocaAbajo[cartaClickeada.number]:removeSelf()
                                cartaBocaAbajo[carta.number]:removeSelf()
                                puntaje = puntaje + 1
                                puntaje.text = "Score : " .. puntaje

                                --TODO  si GANA TRANSICION pantalla WIN 

                                --

                                --
                            

                                end , 1 )   
                    end     
             end          
         end

     end 






 
    elseif ( phase == "did" ) then


        for i =  1,3 do 
            ubicacionX = ubicacionX + 90
            ubicacionY = 20 

        for j = 1,2 do 

            ubicacionY = ubicaciony + 135


            -- Sorteo Cartas     

                sorteo = math.random(1,#numerosImagenes)

                carta[i] =  display.newImage("img_0"..numerosImagenes[sorteo]..".png");
                carta[i].x = ubicacionX;
                carta[i].y = ubicacionY;
                carta[i].nombre = numerosImagenes[sorteo]
                carta[i].number = cantidadCartas

                table.remove( numerosImagenes , sorteo )

                cartaBocaAbajo[cantidadCartas] = display.newImage("img_cardBack.JPEG");
                cartaBocaAbajo[cantidadCartas].x = ubicacionX;
                cartaBocaAbajo[cantidadCartas].y = ubicacionY;
                cantidadCartas = cantidadCartas + 1
                carta[i].touch =  juego
                carta[i]:addEventListener( "touch", carta[i] )

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