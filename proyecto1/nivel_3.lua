composer = require( "composer" )
 
local scene = composer.newScene()
 


local esPar = false

local tocarSegundaCarta = 0

local cartaBocaAbajo = { }

local numerosImagenes = { 1 , 1 , 2 , 2 , 3 , 3, 4 , 4 , 5 , 5 , 6 , 6 , 7 ,7 , 8 , 8 , 9 , 9  }

local cantidadCartas = 0

local carta = { }

tiempo = 0 -- Cronometro empieza 0 

local puntaje = 0


ubicacionX = 0 

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

function gameOver( t )
    

    if (tiempo  >  30 )then
        composer.gotoScene("gameOver")

    end

end





function cronometroInicio ( )

 timer.performWithDelay( 1000 ,  function() 

                tiempo = tiempo + 1 

                cronometro.text = "Tiempo :  " ..tiempo..  " Seg. "

                    end, -1)

end


--- LLENAR CARTAS




 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


    local fondo = display.newImageRect( sceneGroup , "img_fondojuego.jpeg", cw, ch )
    fondo.anchorX = 0 ; fondo.anchorY = 0


    puntuacion = display.newText(sceneGroup,  "Puntaje :  " .. puntaje  , 210 , 10 , "fonts/minecraft_font.ttf" , 24)

    local botonAtras = display.newImageRect(sceneGroup , "img_backbtn.png",50,50)

    cronometro = display.newText( sceneGroup, "Tiempo :  " .. tiempo ..  " Seg. "  , 230, 40 , "fonts/minecraft_font.ttf" , 24)



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

        cronometroInicio()

     function juego ( carta , event )




        if(event.phase == "began") then 
            

            if (esPar == false and tocarSegundaCarta == 0 ) then

                cartaBocaAbajo[carta.number].isVisible = false;
                cartaClickeada = carta
                tocarSegundaCarta = 1


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

                        timer.performWithDelay( 1000 ,  function ()

                            esPar = false
                            tocarSegundaCarta = 0
                            cartaClickeada:removeSelf()
                            cartaBocaAbajo[cartaClickeada.number]:removeSelf()
                            cartaBocaAbajo[carta.number]:removeSelf()
                            puntaje = puntaje + 1
                            puntuacion.text = "Score " .. puntaje



                            --Verificando Tiempo 
                            -- game over
                            
                            gameOver(tiempo)                           


                            --TODO  si GANA TRANSICION pantalla WIN 

                            --

                            --
                        

                            end , 1 )   
                    end     
             end          
         end

     end 











 
    elseif ( phase == "did" ) then


        inicio_i = 1
        fin_i =  2
        inicio_j = 1
        inicio_j = 4
     
        
                    for i =  1,4 do 
                            ubicacionX = ubicacionX + 60
                            ubicacionY = 5

                        for j = 1,4 do 

                            ubicacionY = ubicacionY + 120


                            -- Sorteo Cartas     

                                sorteo = math.random(1,#numerosImagenes)

                                carta[i] =  display.newImage(sceneGroup,"img_carta_0"..numerosImagenes[sorteo]..".png");
                                carta[i].xScale = 0.1
                                carta[i].yScale = 0.1
                                carta[i].x = ubicacionX;
                                carta[i].y = ubicacionY;
                                carta[i].nombre = numerosImagenes[sorteo]
                                carta[i].number = cantidadCartas

                                table.remove( numerosImagenes , sorteo )

                                cartaBocaAbajo[cantidadCartas] = display.newImage(sceneGroup,"img_cardBack.JPEG");
                                cartaBocaAbajo[cantidadCartas].xScale = 0.03
                                cartaBocaAbajo[cantidadCartas].yScale = 0.03
                                cartaBocaAbajo[cantidadCartas].x = ubicacionX;
                                cartaBocaAbajo[cantidadCartas].y = ubicacionY;
                                cantidadCartas = cantidadCartas + 1
                                carta[i].touch =  juego
                                carta[i]:addEventListener( "touch", carta[i] )

                         end  

                        end    








end  end


 












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

    -- BORRAR cuando haces back y volver al nivel 1
 
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