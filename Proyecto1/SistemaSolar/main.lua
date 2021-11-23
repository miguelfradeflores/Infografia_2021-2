-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
display.setStatusBar( display.HiddenStatusBar )
local composer = require( "composer" )

composer.gotoScene( "splash",  {
    effect = "fade",
   -- time = 1000
} )




--[[local cw = display.actualContentWidth
local ch = display.actualContentHeight

local uw = cw/48
local uh = ch/32

local tiempoDespliegue=1500
local tiempoDeSuccion = 500

local tiempo = 0
local orbitasVisibles = true 
local satelitesVisibles = false
local universoDestruido = false
local tierraVisible = true

local GrupoFondo = display.newGroup()
local GrupoOrbitas = display.newGroup()
local GrupoAstros = display.newGroup()
local GrupoAstros2 = display.newGroup( )
local GrupoInterfaz = display.newGroup()

local fondo = display.newImageRect(GrupoFondo,"Imagenes/espacio.jpg",cw,ch)
fondo.x = cw/2; fondo.y = ch/2

local botonOrbitas
local botonAgujeroNegro
local botonBigBang
local botonSatelites
local botonTierra

local sol 
local bigBang
local bigBang2
local agujeroNegro

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


function iniciarMercurio(  )
	mercurio = display.newImageRect( GrupoAstros,"Imagenes/mercurio.png", uw, uh )
	--mercurio.x = 20.5*uw; mercurio.y = 16*uh
	mercurio.x = 24*uw; mercurio.y = 16*uh
	mercurio.touch = ocultarPlaneta
	mercurio:addEventListener( "touch", mercurio )
	dibujarOrbita(orbitaMercurio)

end

function iniciarVenus(  )
	venus = display.newImageRect( GrupoAstros,"Imagenes/venus.png", uw, uh )
	venus.x = 24*uw; venus.y = 16*uh
	venus.touch = ocultarPlaneta
	venus:addEventListener( "touch", venus )
	dibujarOrbita(orbitaVenus)

end

function iniciarTierra(  )
	tierra = display.newImageRect( GrupoAstros,"Imagenes/tierra.png", uw, uh )
	tierra.x = 24*uw; tierra.y = 16*uh
	tierra.touch = ocultarPlaneta
	tierra:addEventListener( "touch", tierra )
	dibujarOrbita(orbitaTierra)

end

function iniciarMarte(  )
	marte = display.newImageRect( GrupoAstros,"Imagenes/marte.png", uw, uh )
	marte.x = 24*uw; marte.y = 16*uh
	marte.touch = ocultarPlaneta
	marte:addEventListener( "touch", marte )
	dibujarOrbita(orbitaMarte)

end

function iniciarJupiter(  )
	jupiter = display.newImageRect( GrupoAstros,"Imagenes/jupiter.png", uw*2, uh*2 )
	jupiter.x = 24*uw; jupiter.y = 16*uh
	jupiter.touch = ocultarPlaneta
	jupiter:addEventListener( "touch", jupiter )
	dibujarOrbita(orbitaJupiter)

end

function iniciarSaturno(  )
	saturno = display.newImageRect( GrupoAstros,"Imagenes/saturno.png", uw*3, uh*2 )
	saturno.x = 24*uw; saturno.y = 16*uh
	saturno.touch = ocultarPlaneta
	saturno:addEventListener( "touch", saturno )
	dibujarOrbita(orbitaSaturno)

end

function iniciarUrano(  )
	urano = display.newImageRect( GrupoAstros,"Imagenes/urano.png", uw, uh )
	urano.x = 24*uw; urano.y = 16*uh
	urano.touch = ocultarPlaneta
	urano:addEventListener( "touch", urano )
	dibujarOrbita(orbitaUrano)

end

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


function lanzarPlanetas(  )
	lanzarPlaneta(mercurio, 20.5*uw, 16*uh)
	lanzarPlaneta(venus, 24*uw, 12*uh)
	lanzarPlaneta(tierra, 31*uw, 16*uh)
	lanzarPlaneta(marte, 24*uw, 23.5*uh)
	lanzarPlaneta(jupiter, 11.5*uw, 16*uh)
	lanzarPlaneta(saturno, 24*uw, 4.5*uh)
	lanzarPlaneta(urano, 43.5*uw, 16*uh)
end


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

function iniciarTraslacion(  )
	timer.performWithDelay( tiempoDespliegue+300, rotarSistema )
end

function rotarSistema()
	timer.performWithDelay( 50, controlador, -1 )
end

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


--Mueve al planeta elgeido en base a una orbita elíptica, desde una posicion
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

function mostrarOrbita( Orb )
	for i,v in ipairs(Orb.linea) do
		v:setFillColor( 0.67 , 0.67, 0.67 , 0.1)
	end
end

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

function ocultarOrbita(Orb)
	for i,v in ipairs(Orb.linea) do
		v:setFillColor( 0.67 , 0.67, 0.67 , 0)
	end
	orbitasVisibles = false
end

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

function mostrarSatelites( )
	luna.alpha=1
	phobos.alpha=1
	deimos.alpha=1
	umbriel.alpha=1
	oberon.alpha=1
	puck.alpha=1
	satelitesVisibles = true 
end

function ocultarSatelites(  )
	luna.alpha=0
	phobos.alpha=0
	deimos.alpha=0
	umbriel.alpha=0
	oberon.alpha=0
	puck.alpha=0
	satelitesVisibles = false
end

function destruirConAgujero( self, e)

	if e.phase== "ended" and not universoDestruido then 
		botonBigBang:toFront( )
		universoDestruido = true
		timer.cancelAll( )
		if orbitasVisibles then 
			ocultarOrbitas()
		end
		invocarAgujeroNegro()
	end
	return true 
end

function relanzarBigBang ( self, e)
	if e.phase== "ended" and  universoDestruido then 
		universoDestruido = false
		tierraVisible = true
		botonAgujeroNegro:toFront( )
		transition.to(agujeroNegro,{alpha=0,time=1000,onComplete=activarBigBang})
		
	end
	return true 
end

function ocultarPlaneta(self,e)
	if e.phase== "ended" then 
		self.alpha=0
		
	end
	return true 
end 

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

function invocarAgujeroNegro()
	iniciarAgujeroNegro()
	transition.to(agujeroNegro,{xScale=1,yScale=1,time=1500,onComplete=succionarPlanetas})
	transition.to( agujeroNegro, {rotation = 360, time = 3000, iterations=-1} )
end

function succionarPlanetas()
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

	satelitesVisibles=false
end



function succionarAstro(astro)
	transition.to(astro,{x=24*uw,y=16*uh,time=tiempoDeSuccion})
end

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

end

function eliminarBigBang( )
	display.remove( bigBang )
	display.remove( bigBang2 )
end

function eliminarAgujeroNegro ()
	display.remove( agujeroNegro )
end

iniciarBotonOrbitas()
iniciarBotonAgujeroNegro()
iniciarBotonBigBang()
iniciarBotonSatelites()
botonAgujeroNegro:toFront()
iniciarBotonTierra()


activarBigBang()
--]]