local composer = require( "composer" )
 
local scene = composer.newScene()

display.setStatusBar( display.HiddenStatusBar )

--Variables utiles

local cw = display.actualContentWidth
local ch = display.actualContentHeight

local uw = cw/48
local uh = ch/32

local tiempo = 0
local tiempoDespliegue=1500
local tiempoDeSuccion = 500

local orbitasVisibles = true 
local satelitesVisibles = false
local universoDestruido = false
local tierraVisible = true

--Declaración de grupos
local GrupoFondo = display.newGroup()
local GrupoOrbitas = display.newGroup()
local GrupoAstros = display.newGroup()
local GrupoAstros2 = display.newGroup( )
local GrupoInterfaz = display.newGroup()

--Declaración del fondo
local fondo = display.newImageRect(GrupoFondo,"Imagenes/espacio.jpg",cw,ch)
fondo.x = cw/2; fondo.y = ch/2

--Declaración de botones
local botonOrbitas
local botonAgujeroNegro
local botonBigBang
local botonSatelites
local botonTierra

--Declaración de elementos centrales
local sol 
local bigBang
local bigBang2
local agujeroNegro

--Declaración de cometas
local cometa1
local cometa2

--Declaración de planetas junto con sus orbitas elípticas
local mercurio
local orbitaMercurio={
        a=3.5*uw,
        b=3*uh,
        h=cw/2,
        k=ch/2,
        linea={}
    }


local venus 
local orbitaVenus={
    a=5*uw,
    b=4*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

local tierra 
local orbitaTierra={
    a=7*uw,
    b=5.5*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

local marte 
local orbitaMarte={
    a=9.5*uw,
    b=7.5*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

local jupiter 
local orbitaJupiter={
    a=12.5*uw,
    b=9.5*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

local saturno 
local orbitaSaturno={
    a=16*uw,
    b=11.5*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

local urano 
local orbitaUrano={
    a=19.5*uw,
    b=14*uh,
    h=cw/2,
    k=ch/2,
    linea={}
}

--Declaración de satélites y sus orbitas circulares
local luna
local orbitaLuna={
    planeta = tierra,
    r =uw
}

local phobos
local orbitaPhobos={
    planeta = marte,
    r =uw
}

local deimos
local orbitaDeimos={
    planeta = marte,
    r =uw
}

local umbriel
local orbitaUmbriel={
    planeta = urano,
    r =1.5*uw
}

local oberon
local orbitaOberon={
    planeta = urano,
    r =1.5*uw
}

local puck
local orbitaPuck={
    planeta = urano,
    r =1.5*uw
}
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

--Funciones para iniciar los botones
function iniciarBotonOrbitas(  )
    botonOrbitas = display.newImageRect( GrupoInterfaz, "Imagenes/botonOrbitas.png", uw*5, uh*5 )
    botonOrbitas.x = 3.5*uw; botonOrbitas.y =3.5*uh
    botonOrbitas.touch = cambiarOrbitas
    botonOrbitas:addEventListener( "touch", botonOrbitas )
end

function iniciarBotonAgujeroNegro(  )
    botonAgujeroNegro = display.newImageRect( GrupoInterfaz, "Imagenes/botonAgujeroNegro.png", uw*5, uh*5 )
    botonAgujeroNegro.x = 44.5*uw; botonAgujeroNegro.y =3.5*uh
    botonAgujeroNegro.touch = destruirConAgujero
    botonAgujeroNegro:addEventListener( "touch", botonAgujeroNegro )
end

function iniciarBotonBigBang(  )
    botonBigBang = display.newImageRect( GrupoInterfaz, "Imagenes/botonBigBang.png", uw*5, uh*5 )
    botonBigBang.x = 44.5*uw; botonBigBang.y =3.5*uh
    botonBigBang.touch = relanzarBigBang
    botonBigBang:addEventListener( "touch", botonBigBang )
end

function iniciarBotonTierra()
    botonTierra = display.newImageRect( GrupoInterfaz, "Imagenes/botonTierra.png", uw*5, uh*5 )
    botonTierra.x = 3.5*uw; botonTierra.y =28.5*uh
    botonTierra.touch = mostrarPlanetas
    botonTierra:addEventListener( "touch", botonTierra )
end

function iniciarBotonSatelites()
    botonSatelites = display.newImageRect( GrupoInterfaz, "Imagenes/botonSatelites.png", uw*5, uh*5 )
    botonSatelites.x = 44.5*uw; botonSatelites.y =28.5*uh
    botonSatelites.touch = cambiarSatelites
    botonSatelites:addEventListener( "touch", botonSatelites )
end

--Funciones para iniciar a los elementos centrales
function iniciarSol(  )
    sol = display.newImageRect( GrupoAstros,"Imagenes/sol.png", uw*5, uh*5 )
    sol.x = 24*uw; sol.y = 16*uh

    transition.to( sol, {rotation = 360, time = 12000, iterations=-1} )
end

function iniciarAgujeroNegro(  )
    agujeroNegro = display.newImageRect( GrupoFondo,"Imagenes/agujeroNegro.png", uw*6, uh*6 )
    agujeroNegro:scale( 0, 0 )
    agujeroNegro.x = 24*uw; agujeroNegro.y = 16*uh
    agujeroNegro:toFront()
end

function iniciarBigBang(  )
    bigBang = display.newImageRect( GrupoAstros2,"Imagenes/bigBang.png" ,uw*5,uh*5 )
    bigBang2 = display.newImageRect( GrupoAstros2,"Imagenes/bigBang2.png" ,uw*5,uh*5 )
    bigBang:scale( 0, 0 )
    bigBang.x = 24*uw; bigBang.y = 16*uh
    bigBang2.x = 24*uw; bigBang2.y = 16*uh

end

--Funciones para iniciar a los planetas y a sus orbitas
function iniciarMercurio(  )
    mercurio = display.newImageRect( GrupoAstros,"Imagenes/mercurio.png", uw, uh )
    --mercurio.x = 20.5*uw; mercurio.y = 16*uh
    mercurio.x = 24*uw; mercurio.y = 16*uh
    transition.to( mercurio, {rotation = 360, time = 12000, iterations=-1} )

    mercurio.touch = ocultarPlaneta
    mercurio:addEventListener( "touch", mercurio )
    dibujarOrbita(orbitaMercurio)


end

function iniciarVenus(  )
    venus = display.newImageRect( GrupoAstros,"Imagenes/venus.png", uw, uh )
    venus.x = 24*uw; venus.y = 16*uh
    transition.to( venus, {rotation = 360, time = 12000, iterations=-1} )
    venus.touch = ocultarPlaneta
    venus:addEventListener( "touch", venus )
    dibujarOrbita(orbitaVenus)

end

function iniciarTierra(  )
    tierra = display.newImageRect( GrupoAstros,"Imagenes/tierra.png", uw, uh )
    tierra.x = 24*uw; tierra.y = 16*uh
    transition.to( tierra, {rotation = 360, time = 12000, iterations=-1} )
    tierra.touch = ocultarPlaneta
    tierra:addEventListener( "touch", tierra )
    dibujarOrbita(orbitaTierra)

end

function iniciarMarte(  )
    marte = display.newImageRect( GrupoAstros,"Imagenes/marte.png", uw, uh )
    marte.x = 24*uw; marte.y = 16*uh
    transition.to( marte, {rotation = 360, time = 12000, iterations=-1} )
    marte.touch = ocultarPlaneta
    marte:addEventListener( "touch", marte )
    dibujarOrbita(orbitaMarte)

end

function iniciarJupiter(  )
    jupiter = display.newImageRect( GrupoAstros,"Imagenes/jupiter.png", uw*2, uh*2 )
    jupiter.x = 24*uw; jupiter.y = 16*uh
  --  transition.to( jupiter, {rotation = 360, time = 12000, iterations=-1} )
    jupiter.touch = ocultarPlaneta
    jupiter:addEventListener( "touch", jupiter )
    dibujarOrbita(orbitaJupiter)

end

function iniciarSaturno(  )
    saturno = display.newImageRect( GrupoAstros,"Imagenes/saturno.png", uw*3, uh*2 )
    saturno.x = 24*uw; saturno.y = 16*uh
--transition.to( saturno, {rotation = 360, time = 12000, iterations=-1} )
    saturno.touch = ocultarPlaneta
    saturno:addEventListener( "touch", saturno )
    dibujarOrbita(orbitaSaturno)

end

function iniciarUrano(  )
    urano = display.newImageRect( GrupoAstros,"Imagenes/urano.png", uw, uh )
    urano.x = 24*uw; urano.y = 16*uh
    transition.to( urano, {rotation = 360, time = 12000, iterations=-1} )
    urano.touch = ocultarPlaneta
    urano:addEventListener( "touch", urano )
    dibujarOrbita(orbitaUrano)

end

--Funciones para iniciar los satélites ( invisibles al comienzo)
function iniciarLuna(  )
    luna = display.newImageRect( GrupoAstros2,"Imagenes/luna.png", uw/2, uh/2 )
    luna.x = tierra.x - orbitaLuna.r; luna.y = tierra.y
    luna.alpha=0
end

function iniciarPhobos(  )
    phobos = display.newImageRect( GrupoAstros2,"Imagenes/phobos.png", uw/2, uh/2 )
    phobos.x = marte.x - orbitaPhobos.r; phobos.y = marte.y
    phobos.alpha=0
end

function iniciarDeimos(  )
    deimos = display.newImageRect( GrupoAstros2,"Imagenes/deimos.png", uw/2, uh/2 )
    deimos.x = marte.x + orbitaDeimos.r; deimos.y = marte.y
    deimos.alpha=0
end

function iniciarUmbriel(  )
    umbriel = display.newImageRect( GrupoAstros2,"Imagenes/deimos.png", uw/2, uh/2 )
    umbriel.x = urano.x - orbitaUmbriel.r/2; umbriel.y = urano.y - orbitaUmbriel.r/2
    umbriel.alpha=0
end

function iniciarOberon(  )
    oberon = display.newImageRect( GrupoAstros2,"Imagenes/oberon.png", uw/2, uh/2 )
    oberon.x = urano.x + orbitaUmbriel.r/2; oberon.y = urano.y - orbitaUmbriel.r/2
    oberon.alpha=0
end

function iniciarPuck(  )
    puck = display.newImageRect( GrupoAstros2,"Imagenes/puck.png", uw/2, uh/2 )
    puck.x = urano.x ; puck.y = urano.y + orbitaUmbriel.r
    puck.alpha=0
end


--Funciones para iniciar los cometas
function iniciarCometa1 ()
    c1iniciox= math.random(0,48*uw )
    c1inicioy = 0 
    cometa1=display.newImageRect(GrupoAstros2,"Imagenes/cometa.png",1.5*uw,1.5*uh)
    cometa1.x=c1iniciox
    cometa1.y=c1inicioy

    finx=math.random(0,48*uw )
    finy = 32*uh 

    if finx> c1iniciox then 
        cometa1.rotation=90+((math.atan((finy-c1inicioy)/(finx-c1iniciox)))*180/math.pi)
    else
        cometa1.rotation=270-(math.atan((finy-c1inicioy)/(c1iniciox-finx)))*180/math.pi
    end
    transition.to(cometa1,{x=finx,y=finy,time=4000,onComplete=eliminarCometa1})
end

function eliminarCometa1 () 
    display.remove(cometa1)
    cometa1=nil 
end

function iniciarCometa2 ()
    c2iniciox= 0
    c2inicioy = math.random(0,32*uh )
    cometa2=display.newImageRect(GrupoAstros2,"Imagenes/cometa.png",1.5*uw,1.5*uh)
    cometa2.x=c2iniciox
    cometa2.y=c2inicioy

    finx=48*uw
    finy = math.random(0,32*uh )

    if finy> c2inicioy then 
        cometa2.rotation=90+((math.atan((finy-c2inicioy)/(finx-c2iniciox)))*180/math.pi)
    else
        cometa2.rotation=90-(math.atan((c2inicioy-finy)/(finx-c2iniciox)))*180/math.pi
    end
    transition.to(cometa2,{x=finx,y=finy,time=4000,onComplete=eliminarCometa2})
end

function eliminarCometa2 () 
    display.remove(cometa2)
    cometa2=nil 
end

--Lanza a los planetas a sus respectivas posiciones iniciales
function lanzarPlanetas(  )
    lanzarPlaneta(mercurio, 20.5*uw, 16*uh)
    lanzarPlaneta(venus, 24*uw, 12*uh)
    lanzarPlaneta(tierra, 31*uw, 16*uh)
    lanzarPlaneta(marte, 24*uw, 23.5*uh)
    lanzarPlaneta(jupiter, 11.5*uw, 16*uh)
    lanzarPlaneta(saturno, 24*uw, 4.5*uh)
    lanzarPlaneta(urano, 43.5*uw, 16*uh)
end

--Lanza a un planeta en específico a uno de los 4 puntos cardinales, con 
--recorrido en base a su distancia con el punto final
function lanzarPlaneta(planeta, px,py)
    ix = planeta.x
    iy = planeta.y 

    --último planeta en ser lanzado
    if planeta == urano then 
        print( "3", planeta )
        transition.to(planeta,{x=(ix+px)/2,y=iy-(px-ix)/2,time=tiempoDespliegue/2})
        transition.to(planeta,{x=px,y=py,time=tiempoDespliegue/2,delay = tiempoDespliegue/2+1,onComplete=rotarSistema})
    end


    if px<cw/2 then
        print( "1", planeta )
        transition.to(planeta,{x=(ix+px)/2,y=iy+(ix-px)/2,time=tiempoDespliegue/2})
        transition.to(planeta,{x=px,y=py,time=tiempoDespliegue/2,delay = tiempoDespliegue/2+1})
    elseif py<ch/2 then 
        print( "2", planeta )
        transition.to(planeta,{x=ix-(iy-py)/2,y=(py+iy)/2,time=tiempoDespliegue/2})
        transition.to(planeta,{x=px,y=py,time=tiempoDespliegue/2,delay = tiempoDespliegue/2+1})
    elseif px>cw/2 then 
        print( "3", planeta )
        transition.to(planeta,{x=(ix+px)/2,y=iy-(px-ix)/2,time=tiempoDespliegue/2})
        transition.to(planeta,{x=px,y=py,time=tiempoDespliegue/2,delay = tiempoDespliegue/2+1})
    else 
        print( "4", planeta )
        transition.to(planeta,{x=ix+(py-iy)/2,y=(py+iy)/2,time=tiempoDespliegue/2})
        transition.to(planeta,{x=px,y=py,time=tiempoDespliegue/2,delay = tiempoDespliegue/2+1})
    end
end     

--Despues de una breve pausa empieza la rotación del sistema llamando 
--al controlador cada 50 ms
function rotarSistema()
    timer.performWithDelay( 50, controlador, -1 )
end

--Controla el tiempo y hace que planetas y satelites puedan orbitar en
--base al tiempo y su órbita
function controlador()
    tiempo = tiempo +1
    --print( "tiempo" )
    moverPlaneta(mercurio,orbitaMercurio,0)
    moverPlaneta(venus,orbitaVenus,orbitaVenus.a)
    moverPlaneta(tierra,orbitaTierra,orbitaTierra.a*2)
    moverPlaneta(marte,orbitaMarte,orbitaMarte.a*3)
    moverPlaneta(jupiter,orbitaJupiter,0)
    moverPlaneta(saturno,orbitaSaturno,orbitaSaturno.a)
    moverPlaneta(urano,orbitaUrano,orbitaUrano.a*2)

    if satelitesVisibles then 
        moverSatelite(luna,tierra,orbitaLuna,0)
        moverSatelite(phobos,marte,orbitaPhobos,0)
        moverSatelite(deimos,marte,orbitaDeimos,2*orbitaDeimos.r)
        moverSatelite(umbriel,urano,orbitaUmbriel,orbitaUmbriel.r/2)
        moverSatelite(oberon,urano,orbitaOberon,orbitaOberon.r*3/2)
        moverSatelite(puck,urano,orbitaPuck,orbitaPuck.r*3)
    end
end


--Mueve al planeta elegido en base a una orbita elíptica, desde una posicion
-- inicial en x de la siguiente forma:
-- 0 : planeta empieza a la izquierda
-- orbita.a : planeta empieza arriba
-- orbita.a*2: planeta empieza a la derecha
--orbita.a*3 : planeta enpieza abajo
function moverPlaneta( planeta, orbita,posicionInicial)

    a= orbita.a 
    b= orbita.b 
    h= orbita.h
    k= orbita.k

    t=tiempo+posicionInicial


    if t % (a*4) < 2*a then 
        posicionX = (t % (a*2))+h - a
        posicionY = ((-b*math.sqrt( a^2 - (posicionX-h)^2))/a)+k
        planeta.x=posicionX
        planeta.y=posicionY
    else
        posicionX= -(t % (2*a))+h+a
        posicionY = ((b*math.sqrt( a^2 - (posicionX-h)^2))/a)+k
        planeta.x=posicionX
        planeta.y=posicionY
    end
end

--Mueve al satelite elgeido en base a una orbita circular, desde una posicion
-- inicial en x de la siguiente forma:
-- 0 : satelite empieza a la izquierda
-- orbita.r : satelite empieza arriba
-- orbita.r*2: satelite empieza a la derecha
--orbita.r*3 : satelite enpieza abajo
function moverSatelite(satelite,planeta,orbita,posicionInicial)
    r=orbita.r
    h= planeta.x 
    k = planeta.y
    t=tiempo+posicionInicial

    if t % (r*4) < 2*r then
        posicionX = (t%(r*2))+h-r
        posicionY = (math.sqrt(r^2 - (posicionX-h)^2))+k
        satelite.x=posicionX
        satelite.y=posicionY
    else
        posicionX= -(t % (r*2))+h+r
        posicionY = (-math.sqrt(r^2 - (posicionX-h)^2))+k
        satelite.x=posicionX
        satelite.y=posicionY
    end
end

--Crea una serie de rectangulos pequeños que dibujarán a orbita y se 
--guardarán en el atributo "linea" de la orbita
function dibujarOrbita(orbitaEliptica)
    a= orbitaEliptica.a 
    b= orbitaEliptica.b 
    h= orbitaEliptica.h
    k= orbitaEliptica.k
    for i=cw/2 - a, cw/2 + a ,0.05 do
        x = i 
        y = ((b*math.sqrt( a^2 - (x-h)^2))/a)+k
        y2 = ((-b*math.sqrt( a^2 - (x-h)^2))/a)+k

        table.insert( orbitaEliptica.linea, display.newRect(GrupoOrbitas, x, y, 1, 1 ) )
        table.insert( orbitaEliptica.linea, display.newRect(GrupoOrbitas, x, y2, 1, 1 ) )

            
    end
        table.insert( orbitaEliptica.linea, display.newRect(GrupoOrbitas, h+a, k, 1, 1 ) )

    for i,v in ipairs(orbitaEliptica.linea) do
        v:setFillColor( 0.67 , 0.67, 0.67 , 0.1)
    end
end

--Cambia la visibilidad de las orbitas
function cambiarOrbitas( self, e)

    if e.phase== "began" then 
        if orbitasVisibles then 
            ocultarOrbitas()
        else
            mostrarOrbitas()
        end

    end
    
    return true
end

--Hace a las orbitas de los planetas visibles
function mostrarOrbitas( )
    mostrarOrbita(orbitaMercurio)
    mostrarOrbita(orbitaVenus)
    mostrarOrbita(orbitaTierra)
    mostrarOrbita(orbitaMarte)
    mostrarOrbita(orbitaJupiter)
    mostrarOrbita(orbitaSaturno)
    mostrarOrbita(orbitaUrano)
    orbitasVisibles = true 
end

--Hace a una orbita en específico visible
function mostrarOrbita( Orb )
    for i,v in ipairs(Orb.linea) do
        v:setFillColor( 0.67 , 0.67, 0.67 , 0.1)
    end
end

--Oculta las rbitas de todos los planetas
function ocultarOrbitas(  )
    ocultarOrbita(orbitaMercurio)
    ocultarOrbita(orbitaVenus)
    ocultarOrbita(orbitaTierra)
    ocultarOrbita(orbitaMarte)
    ocultarOrbita(orbitaJupiter)
    ocultarOrbita(orbitaSaturno)
    ocultarOrbita(orbitaUrano)
    orbitasVisibles=false
end

--Oculta una orbita en específico
function ocultarOrbita(Orb)
    for i,v in ipairs(Orb.linea) do
        v:setFillColor( 0.67 , 0.67, 0.67 , 0)
    end
    orbitasVisibles = false
end

--Cambia la visibilidad de los satélites
function cambiarSatelites( self, e)

    if e.phase== "began" then 
        if satelitesVisibles then 
            ocultarSatelites()
        else
            mostrarSatelites()
        end

    end
    
    return true
end

--Muestra a todos los satélites
function mostrarSatelites( )
    luna.alpha=1
    phobos.alpha=1
    deimos.alpha=1
    umbriel.alpha=1
    oberon.alpha=1
    puck.alpha=1
    satelitesVisibles = true 
end

--Oculta a todos los satélites
function ocultarSatelites(  )
    luna.alpha=0
    phobos.alpha=0
    deimos.alpha=0
    umbriel.alpha=0
    oberon.alpha=0
    puck.alpha=0
    satelitesVisibles = false
end

--Prepara al escenario para el agujero negro
function destruirConAgujero( self, e)

    if e.phase== "ended" and not universoDestruido then 
        botonBigBang:toFront( )
        universoDestruido = true
        eliminarBigBang()
        timer.cancelAll( )
        transition.cancelAll( )

        invocarAgujeroNegro()
    end
    return true 
end

--Prepara el escenario para un nuevo big bang, remueve el agujero negro
--de la pantalla
function relanzarBigBang ( self, e)
    if e.phase== "ended" and  universoDestruido then 
        universoDestruido = false
        tierraVisible = true
        botonAgujeroNegro:toFront( )
        transition.to(agujeroNegro,{alpha=0,time=1000,onComplete=activarBigBang})
        
    end
    return true 
end

--Oculta el planeta seleccionado
function ocultarPlaneta(self,e)
    if e.phase== "ended" then 
        self.alpha=0
        
    end
    return true 
end 

--Muestra a todos los planetas
function mostrarPlanetas ( self, e)
    if e.phase== "ended"  then 

        mercurio.alpha=1
        venus.alpha=1
        tierra.alpha=1
        marte.alpha=1
        jupiter.alpha=1
        saturno.alpha=1
        urano.alpha=1

        
    end
    return true 
end

--Crea un agujero negro con rotación constante y llama a succionar 
--planetas
function invocarAgujeroNegro()
    iniciarAgujeroNegro()
    transition.to(agujeroNegro,{xScale=1,yScale=1,time=1500,onComplete=succionarAstros})
    transition.to( agujeroNegro, {rotation = 360, time = 3000, iterations=-1} )
end

--Succiona a todos los elementos en el espacio hacia el agujero y los
--desaparece
function succionarAstros()
    succionarAstro(mercurio)
    succionarAstro(venus)
    succionarAstro(tierra)
    succionarAstro(marte)
    succionarAstro(jupiter)
    succionarAstro(saturno)
    succionarAstro(urano)

    succionarAstro(luna)
    succionarAstro(phobos)
    succionarAstro(deimos)
    succionarAstro(oberon)
    succionarAstro(umbriel)
    succionarAstro(puck)

    if not (cometa1 == nil ) then 
        succionarAstro(cometa1)
        transition.to(cometa1,{alpha=0,time=1000,delay=tiempoDeSuccion})
    end 

    if not (cometa2 == nil) then 
        succionarAstro(cometa2)
        transition.to(cometa2,{alpha=0,time=1000,delay=tiempoDeSuccion})

    end

    transition.to(luna,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(phobos,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(deimos,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(oberon,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(umbriel,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(puck,{alpha=0,time=1000,delay=tiempoDeSuccion})


    transition.to(sol,{alpha=0,time=1000})
    transition.to(mercurio,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(venus,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(tierra,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(marte,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(jupiter,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(saturno,{alpha=0,time=1000,delay=tiempoDeSuccion})
    transition.to(urano,{alpha=0,time=1000,delay=tiempoDeSuccion,onComplete=destruirAstros})



end

--Remueve los diplays asociados a los astros
function destruirAstros()
    display.remove( sol )
    display.remove( mercurio )
    display.remove( venus )
    display.remove( tierra )
    display.remove( marte )
    display.remove( jupiter )
    display.remove( saturno )
    display.remove( urano )

    display.remove(luna)
    display.remove(phobos)
    display.remove(deimos)
    display.remove(umbriel)
    display.remove(oberon)
    display.remove(puck)

    if not (cometa1 == nil ) then 
        display.remove(cometa1)
    end 

    if not (cometa2 == nil) then 
        display.remove(cometa2)
    end

    satelitesVisibles=false
end


--Lleva a un astro al centro del agujero
function succionarAstro(astro)
    transition.to(astro,{x=24*uw,y=16*uh,time=tiempoDeSuccion})
end

--Resetea el universo mediante un nuevo Big bang
function activarBigBang()
    tiempo = 0

    if not (agujeroNegro == nil) then 
        eliminarAgujeroNegro()
    end

    iniciarBigBang()
    transition.to(bigBang,{xScale=10,yScale=10,alpha=0,time=tiempoDespliegue*3})
    transition.to(bigBang2,{xScale=2,yScale=2,alpha=0,time=tiempoDespliegue*3})

    iniciarUniverso()
end

--Limpia las orbitas para ser nuevamente calculadas
--Inicia a los Astros
function iniciarUniverso()
    
    orbitaMercurio.linea={}
    orbitaVenus.linea={}
    orbitaTierra.linea={}
    orbitaMarte.linea={}
    orbitaJupiter.linea={}
    orbitaSaturno.linea={}
    orbitaUrano.linea={}


    iniciarSol()

    iniciarMercurio()
    iniciarVenus()
    iniciarTierra()
    iniciarMarte()
    iniciarJupiter()
    iniciarSaturno()
    iniciarUrano()

    iniciarLuna()
    iniciarPhobos()
    iniciarDeimos()
    iniciarUmbriel()
    iniciarOberon()
    iniciarPuck()

    ocultarOrbitas()

    lanzarPlanetas()

    timer.performWithDelay( 13000, iniciarCometa1,-1 )
    timer.performWithDelay( 9000, iniciarCometa2,-1 )

end

--Remueve los displays del big bang
function eliminarBigBang( )
    display.remove( bigBang )
    display.remove( bigBang2 )
end

--Quita el display del agujero negro
function eliminarAgujeroNegro ()
    display.remove( agujeroNegro )
end

 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
 
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    --Iniciar los botones
    iniciarBotonOrbitas()
    iniciarBotonBigBang()
    iniciarBotonAgujeroNegro()
    iniciarBotonSatelites()
    --botonAgujeroNegro:toFront()
    iniciarBotonTierra()

    --Agrupar los ditintos grupos existentes en el grupo de la escena
    sceneGroup:insert(GrupoFondo)
    sceneGroup:insert(GrupoOrbitas)
    sceneGroup:insert(GrupoAstros)
    sceneGroup:insert(GrupoAstros2)
    sceneGroup:insert(GrupoInterfaz)


end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 


    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 

    --Activa el primer big bang
    activarBigBang()
 
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